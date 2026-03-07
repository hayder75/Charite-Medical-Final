const prisma = require('../config/database');

/**
 * Checks if all investigations for a visit are completed and updates visit status accordingly
 * @param {number} visitId - The visit ID to check
 * @returns {Promise<Object>} - Result object with completion status and updated visit info
 */
async function checkVisitInvestigationCompletion(visitId) {
  try {
    console.log(`🔍 Checking investigation completion for visit ${visitId}`);

    // Get the visit with all related orders across ALL systems
    const visit = await prisma.visit.findUnique({
      where: { id: visitId },
      include: {
        labOrders: true,
        radiologyOrders: true,
        labTestOrders: true,
        batchOrders: {
          include: {
            services: true
          }
        }
      }
    });

    if (!visit) {
      console.log(`❌ Visit ${visitId} not found`);
      throw new Error('Visit not found');
    }

    const pendingStatuses = ['UNPAID', 'PAID', 'QUEUED', 'IN_PROGRESS'];

    // 1. Check legacy/direct orders
    const hasPendingLabOrders = visit.labOrders.some(o => pendingStatuses.includes(o.status));
    const hasPendingRadiologyOrders = visit.radiologyOrders.some(o => pendingStatuses.includes(o.status));
    const hasPendingLabTestOrders = visit.labTestOrders.some(o => pendingStatuses.includes(o.status));

    // 2. Check batch orders (handling MIXED type)
    const hasPendingBatchOrders = visit.batchOrders.some(order => {
      // Check if order itself is pending
      if (pendingStatuses.includes(order.status)) {
        // If it's a MIXED or LAB/RADIOLOGY order, check if any of its services are still pending
        // LAB/RADIOLOGY orders that are PAID/QUEUED are always pending
        if (order.type === 'LAB' || order.type === 'RADIOLOGY') return true;

        // MIXED orders are pending if ANY service is pending
        if (order.type === 'MIXED') {
          return order.services.some(s => pendingStatuses.includes(s.status));
        }

        // DENTAL/NURSE/DRUGS don't block consultation completion in this utility
        return false;
      }
      return false;
    });

    const isComplete = !hasPendingLabOrders && !hasPendingRadiologyOrders && !hasPendingLabTestOrders && !hasPendingBatchOrders;

    console.log(`📊 Visit ${visitId} completion check:`, {
      hasPendingLabOrders,
      hasPendingRadiologyOrders,
      hasPendingLabTestOrders,
      hasPendingBatchOrders,
      isComplete
    });

    if (isComplete && (visit.batchOrders.length > 0 || visit.labOrders.length > 0 || visit.radiologyOrders.length > 0 || visit.labTestOrders.length > 0)) {
      console.log(`🔄 Updating visit ${visitId} to AWAITING_RESULTS_REVIEW`);

      const updatedVisit = await prisma.visit.update({
        where: { id: visitId },
        data: {
          status: 'AWAITING_RESULTS_REVIEW',
          queueType: 'RESULTS_REVIEW',
          updatedAt: new Date()
        },
        include: {
          patient: {
            select: { id: true, name: true, type: true }
          }
        }
      });

      // Create audit log
      await prisma.auditLog.create({
        data: {
          action: 'INVESTIGATION_COMPLETION',
          entity: 'Visit',
          entityId: visitId,
          details: JSON.stringify({
            visitId: visitId,
            newStatus: 'AWAITING_RESULTS_REVIEW',
            newQueueType: 'RESULTS_REVIEW'
          }),
          ip: 'system',
          userAgent: 'system'
        }
      });

      return {
        isComplete: true,
        hasInvestigations: true,
        visit: updatedVisit
      };
    }

    return {
      isComplete,
      hasInvestigations: true,
      visit: visit
    };

  } catch (error) {
    console.error('Error checking investigation completion:', error);
    throw error;
  }
}

/**
 * Checks if medication ordering is allowed for a visit
 * @param {number} visitId - The visit ID to check
 * @returns {Promise<Object>} - Result object with medication ordering status
 */
async function checkMedicationOrderingAllowed(visitId) {
  try {
    const visit = await prisma.visit.findUnique({
      where: { id: visitId },
      include: {
        labOrders: true,
        radiologyOrders: true,
        batchOrders: true
      }
    });

    if (!visit) {
      throw new Error('Visit not found');
    }

    // Check if there are any pending investigations
    // Only consider LAB and RADIOLOGY orders - NURSE and DENTAL don't block medication
    const hasLabOrders = visit.labOrders.length > 0;
    const hasRadiologyOrders = visit.radiologyOrders.length > 0;
    // Only count LAB and RADIOLOGY batch orders
    const labRadiologyBatchOrders = visit.batchOrders.filter(order =>
      order.type === 'LAB' || order.type === 'RADIOLOGY' || order.type === 'MIXED'
    );
    const hasBatchOrders = labRadiologyBatchOrders.length > 0;

    if (!hasLabOrders && !hasRadiologyOrders && !hasBatchOrders) {
      // No lab/radiology investigations ordered, medication ordering allowed immediately
      return {
        allowed: true,
        reason: 'No lab or radiology investigations ordered'
      };
    }

    // Check if all lab/radiology investigations are completed
    // Only check LAB and RADIOLOGY batch orders for completion (exclude NURSE and DENTAL)
    const allLabRadiologyBatchComplete = labRadiologyBatchOrders.length === 0 ||
      labRadiologyBatchOrders.every(order => order.status === 'COMPLETED');
    const allLabOrdersComplete = visit.labOrders.length === 0 ||
      visit.labOrders.every(order => order.status === 'COMPLETED');
    const allRadiologyOrdersComplete = visit.radiologyOrders.length === 0 ||
      visit.radiologyOrders.every(order => order.status === 'COMPLETED');

    if (allLabRadiologyBatchComplete && allLabOrdersComplete && allRadiologyOrdersComplete) {
      return {
        allowed: true,
        reason: 'All lab and radiology investigations completed'
      };
    }

    // Get pending investigation details
    // Only check LAB and RADIOLOGY orders - NURSE and DENTAL services don't block medication ordering
    const pendingLab = visit.labOrders.filter(order => order.status !== 'COMPLETED');
    const pendingRadiology = visit.radiologyOrders.filter(order => order.status !== 'COMPLETED');
    // Only check LAB and RADIOLOGY batch orders - exclude NURSE and DENTAL
    const pendingBatch = visit.batchOrders.filter(order =>
      order.status !== 'COMPLETED' &&
      (order.type === 'LAB' || order.type === 'RADIOLOGY' || order.type === 'MIXED')
    );

    const pendingDetails = [];
    if (pendingLab.length > 0) pendingDetails.push(`${pendingLab.length} lab test(s)`);
    if (pendingRadiology.length > 0) pendingDetails.push(`${pendingRadiology.length} radiology test(s)`);
    if (pendingBatch.length > 0) pendingDetails.push(`${pendingBatch.length} batch order(s)`);

    // If no pending lab/radiology orders, allow medication ordering
    if (pendingLab.length === 0 && pendingRadiology.length === 0 && pendingBatch.length === 0) {
      return {
        allowed: true,
        reason: 'All lab and radiology investigations completed'
      };
    }

    return {
      allowed: false,
      reason: `Cannot order medication until all pending results are submitted. Pending: ${pendingDetails.join(', ')}`
    };

  } catch (error) {
    console.error('Error checking medication ordering:', error);
    throw error;
  }
}

module.exports = {
  checkVisitInvestigationCompletion,
  checkMedicationOrderingAllowed
};
