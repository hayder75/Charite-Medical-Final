const prisma = require('../config/database');
const { z } = require('zod');
const PdfPrinter = require('pdfmake');
const fs = require('fs');

const fonts = {
  Roboto: {
    normal: 'node_modules/roboto-font/fonts/Roboto/roboto-regular-webfont.ttf',
    bold: 'node_modules/roboto-font/fonts/Roboto/roboto-bold-webfont.ttf',
  },
};

const printer = new PdfPrinter(fonts);

const CARD_REGISTRATION_CODES = ['CARD-REG', 'CARD-REG-DERM'];
const CARD_ACTIVATION_CODES = ['CARD-ACT', 'CARD-ACT-DERM'];

const CARD_REGISTRATION_SERVICE_DEFINITIONS = {
  GENERAL: {
    code: 'CARD-REG',
    name: 'Patient Card Registration',
    price: 100,
    description: 'Initial patient card registration fee (first time only)'
  },
  DERMATOLOGY: {
    code: 'CARD-REG-DERM',
    name: 'Dermatology Patient Card Registration',
    price: 200,
    description: 'Initial dermatology patient card registration fee (first time only)'
  }
};

const normalizeCardType = (value) => {
  const normalized = String(value || 'GENERAL').trim().toUpperCase();
  return normalized.includes('DERM') ? 'DERMATOLOGY' : 'GENERAL';
};

const getOrCreateCardRegistrationService = async (cardType) => {
  const config = CARD_REGISTRATION_SERVICE_DEFINITIONS[cardType] || CARD_REGISTRATION_SERVICE_DEFINITIONS.GENERAL;

  return prisma.service.upsert({
    where: { code: config.code },
    update: {
      name: config.name,
      category: 'CONSULTATION',
      price: config.price,
      description: config.description,
      isActive: true
    },
    create: {
      code: config.code,
      name: config.name,
      category: 'CONSULTATION',
      price: config.price,
      description: config.description,
      isActive: true
    }
  });
};

// Helper function to map service categories to insurance service types
function getServiceTypeFromCategory(category) {
  const categoryMap = {
    'CONSULTATION': 'CONSULTATION',
    'LAB': 'LAB_TEST',
    'RADIOLOGY': 'RADIOLOGY',
    'MEDICATION': 'MEDICATION',
    'PROCEDURE': 'PROCEDURE',
    'NURSE': 'NURSE_SERVICE',
    'CONTINUOUS_INFUSION': 'NURSE_SERVICE',
    'EMERGENCY': 'OTHER',
    'DIAGNOSTIC': 'OTHER',
    'TREATMENT': 'PROCEDURE',
    'OTHER': 'OTHER'
  };

  return categoryMap[category] || 'OTHER';
}

// Validation schemas
const paymentSchema = z.object({
  billingId: z.string(),
  amount: z.union([z.number(), z.string().transform(val => parseFloat(val))]),
  type: z.enum(['CASH', 'BANK', 'INSURANCE', 'CREDIT', 'CHARITY']),
  bankName: z.string().nullable().optional(),
  transNumber: z.string().nullable().optional(),
  insuranceId: z.string().nullable().optional(),
  notes: z.string().nullable().optional(),
});

const createBillingSchema = z.object({
  patientId: z.string(),
  visitId: z.number().optional(),
  insuranceId: z.string().optional(),
  services: z.array(z.object({
    serviceId: z.string(),
    quantity: z.number().int().min(1),
    unitPrice: z.number().positive().optional(),
  })),
  notes: z.string().optional(),
});

const addServiceToBillingSchema = z.object({
  billingId: z.string(),
  serviceId: z.string(),
  quantity: z.number().int().min(1),
  unitPrice: z.number().positive().optional(),
});

exports.registerPatient = async (req, res) => {
  try {
    const { name, type, cardType, dob, gender, mobile, email, address, emergencyContact, bloodType, maritalStatus, insuranceId } = req.body;
    const normalizedCardType = normalizeCardType(cardType);

    // Check for duplicate patient before creating new one
    if (mobile) {
      const existingPatient = await prisma.patient.findFirst({
        where: {
          mobile: mobile,
          status: 'Active'
        }
      });

      if (existingPatient) {
        return res.status(409).json({
          error: 'Patient with this mobile number already exists',
          existingPatient: {
            id: existingPatient.id,
            name: existingPatient.name,
            mobile: existingPatient.mobile,
            type: existingPatient.type
          },
          suggestion: 'Use the search function to find existing patient and create a new visit'
        });
      }
    }

    // Also check by name and DOB for additional duplicate prevention
    if (name && dob) {
      const existingByNameAndDob = await prisma.patient.findFirst({
        where: {
          name: {
            equals: name,
            mode: 'insensitive'
          },
          dob: new Date(dob),
          status: 'Active'
        }
      });

      if (existingByNameAndDob) {
        return res.status(409).json({
          error: 'Patient with this name and date of birth already exists',
          existingPatient: {
            id: existingByNameAndDob.id,
            name: existingByNameAndDob.name,
            mobile: existingByNameAndDob.mobile,
            type: existingByNameAndDob.type,
            dob: existingByNameAndDob.dob
          },
          suggestion: 'Use the search function to find existing patient and create a new visit'
        });
      }
    }

    // Generate unique patient ID with sequential numbering
    const { generateUniquePatientId } = require('../utils/patientIdGenerator');
    const isEmergency = type === 'EMERGENCY';

    const patient = await generateUniquePatientId(async (patientId) => {
      return await prisma.patient.create({
        data: {
          id: patientId,
          name,
          type,
          dob: dob ? new Date(dob) : null,
          gender,
          mobile,
          email,
          address,
          emergencyContact,
          bloodType,
          maritalStatus,
          cardType: normalizedCardType,
          insuranceId,
          status: 'Active'
        }
      });
    }, prisma, isEmergency);

    // Create card registration billing for non-emergency patients
    // Note: Visit is NOT created automatically - must be created manually after payment
    let billing = null;
    if (type !== 'EMERGENCY') {
      try {
        const cardRegService = await getOrCreateCardRegistrationService(normalizedCardType);

        if (cardRegService) {
          billing = await prisma.billing.create({
            data: {
              patientId: patient.id,
              visitId: null, // Visit will be created after payment
              insuranceId,
              totalAmount: cardRegService.price,
              status: 'PENDING',
              billingType: 'REGULAR',
              notes: `${type} patient card registration (${normalizedCardType})`
            }
          });

          await prisma.billingService.create({
            data: {
              billingId: billing.id,
              serviceId: cardRegService.id,
              quantity: 1,
              unitPrice: cardRegService.price,
              totalPrice: cardRegService.price
            }
          });
        }
      } catch (error) {
        console.error('Error creating billing:', error);
      }
    }

    res.json({
      message: 'Patient registered successfully',
      patient,
      billing
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Create a new visit for an existing patient
exports.createVisitForExistingPatient = async (req, res) => {
  try {
    const { patientId, type, notes } = req.body;

    if (!patientId) {
      return res.status(400).json({ error: 'Patient ID is required' });
    }

    // Check if patient exists
    const patient = await prisma.patient.findUnique({
      where: { id: patientId },
      select: {
        id: true,
        name: true,
        type: true,
        mobile: true,
        email: true,
        insuranceId: true,
        status: true,
        cardStatus: true,
        cardExpiryDate: true
      }
    });

    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    if (patient.status !== 'Active') {
      return res.status(400).json({ error: 'Patient is not active' });
    }

    // Check card status - patient must have an active card to create a visit
    if (type !== 'EMERGENCY' && patient.cardStatus !== 'ACTIVE') {
      return res.status(403).json({
        error: 'Patient card is inactive',
        message: 'Please activate the patient\'s card before creating a new visit. Card activation will automatically create a visit and send the patient to triage.',
        cardStatus: patient.cardStatus,
        suggestion: 'Use the card activation option to activate the card. After payment, a visit will be created automatically.'
      });
    }

    // Check if patient already has an active visit
    const activeVisit = await prisma.visit.findFirst({
      where: {
        patientId: patientId,
        status: {
          in: [
            'WAITING_FOR_TRIAGE',
            'TRIAGED',
            'WAITING_FOR_DOCTOR',
            'IN_DOCTOR_QUEUE',
            'UNDER_DOCTOR_REVIEW',
            'SENT_TO_LAB',
            'SENT_TO_RADIOLOGY',
            'SENT_TO_BOTH',
            'RETURNED_WITH_RESULTS',
            'AWAITING_LAB_RESULTS',
            'AWAITING_RADIOLOGY_RESULTS',
            'AWAITING_RESULTS_REVIEW'
          ]
        }
      },
      include: {
        bills: {
          where: {
            status: {
              in: ['PENDING', 'PAID']
            }
          }
        }
      }
    });

    if (activeVisit) {
      return res.status(409).json({
        error: 'Patient already has an active visit',
        existingVisit: {
          id: activeVisit.id,
          visitUid: activeVisit.visitUid,
          status: activeVisit.status,
          createdAt: activeVisit.createdAt,
          hasPendingBilling: activeVisit.bills.some(bill => bill.status === 'PENDING')
        },
        suggestion: 'Complete the current visit before creating a new one'
      });
    }

    // Check if patient has any pending entry fee billing (for extra safety)
    const pendingEntryFee = await prisma.billing.findFirst({
      where: {
        patientId: patientId,
        status: 'PENDING',
        services: {
          some: {
            service: {
              code: 'ENTRY001'
            }
          }
        }
      },
      include: {
        visit: {
          select: {
            id: true,
            visitUid: true,
            status: true
          }
        }
      }
    });

    if (pendingEntryFee) {
      return res.status(409).json({
        error: 'Patient has pending entry fee billing',
        existingBilling: {
          id: pendingEntryFee.id,
          totalAmount: pendingEntryFee.totalAmount,
          status: pendingEntryFee.status,
          visitId: pendingEntryFee.visitId,
          visitUid: pendingEntryFee.visit.visitUid,
          visitStatus: pendingEntryFee.visit.status
        },
        suggestion: 'Please complete the pending payment before creating a new visit'
      });
    }

    // Create a new visit record with unique visitUid (retry logic for race conditions)
    const { generateUniqueVisitUid } = require('../utils/visitUidGenerator');

    const visit = await generateUniqueVisitUid(async (visitUid) => {
      return await prisma.visit.create({
        data: {
          visitUid: visitUid,
          patientId: patient.id,
          status: 'WAITING_FOR_TRIAGE',
          isEmergency: type === 'EMERGENCY',
          notes: notes || `Returning patient visit - ${type || 'regular'}`
        }
      });
    }, prisma);

    // Card is active, so NO billing is created for the visit.
    // Patient goes straight to triage for free.
    let billing = null;

    res.json({
      message: 'Visit created successfully for existing patient',
      patient,
      visit,
      billing
    });
  } catch (error) {
    console.error('Error creating visit for existing patient:', error);
    res.status(500).json({ error: error.message });
  }
};

// Check if patient can create a new visit
exports.checkPatientVisitStatus = async (req, res) => {
  try {
    const { patientId } = req.params;

    if (!patientId) {
      return res.status(400).json({ error: 'Patient ID is required' });
    }

    // Check if patient exists
    const patient = await prisma.patient.findUnique({
      where: { id: patientId },
      select: {
        id: true,
        name: true,
        status: true,
        cardStatus: true,
        cardExpiryDate: true
      }
    });

    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    if (patient.status !== 'Active') {
      return res.status(400).json({
        error: 'Patient is not active',
        canCreateVisit: false,
        reason: 'Patient status is not active'
      });
    }

    // Check for active visits
    const activeVisit = await prisma.visit.findFirst({
      where: {
        patientId: patientId,
        status: {
          in: [
            'WAITING_FOR_TRIAGE',
            'TRIAGED',
            'WAITING_FOR_DOCTOR',
            'IN_DOCTOR_QUEUE',
            'UNDER_DOCTOR_REVIEW',
            'SENT_TO_LAB',
            'SENT_TO_RADIOLOGY',
            'SENT_TO_BOTH',
            'RETURNED_WITH_RESULTS',
            'AWAITING_LAB_RESULTS',
            'AWAITING_RADIOLOGY_RESULTS',
            'AWAITING_RESULTS_REVIEW'
          ]
        }
      },
      include: {
        bills: {
          where: {
            status: 'PENDING'
          }
        }
      }
    });

    if (activeVisit) {
      return res.json({
        canCreateVisit: false,
        reason: 'Patient has an active visit',
        activeVisit: {
          id: activeVisit.id,
          visitUid: activeVisit.visitUid,
          status: activeVisit.status,
          createdAt: activeVisit.createdAt,
          hasPendingBilling: activeVisit.bills.length > 0
        }
      });
    }

    // Check for pending card activation/registration billing
    const pendingCardBilling = await prisma.billing.findFirst({
      where: {
        patientId: patientId,
        status: 'PENDING',
        services: {
          some: {
            service: {
              code: { in: [...CARD_REGISTRATION_CODES, ...CARD_ACTIVATION_CODES] }
            }
          }
        }
      }
    });

    if (pendingCardBilling) {
      return res.json({
        canCreateVisit: false,
        reason: 'Patient has a pending card activation/registration payment. After payment, a visit will be created automatically.',
        cardStatus: patient.cardStatus,
        pendingBilling: {
          id: pendingCardBilling.id,
          totalAmount: pendingCardBilling.totalAmount
        },
        suggestion: 'Please complete the pending card payment at the billing counter.'
      });
    }

    // Check if card is active
    if (patient.cardStatus !== 'ACTIVE') {
      return res.json({
        canCreateVisit: false,
        reason: 'Patient card is inactive. Please activate the card first.',
        cardStatus: patient.cardStatus,
        needsCardActivation: true,
        suggestion: 'Use the card activation option to activate the card. After payment, a visit will be created automatically.'
      });
    }

    // Patient can create a new visit (card is active, no active visits)
    res.json({
      canCreateVisit: true,
      reason: 'Patient card is active and no active visits found',
      cardStatus: patient.cardStatus,
      patient: {
        id: patient.id,
        name: patient.name,
        status: patient.status,
        cardStatus: patient.cardStatus
      }
    });

  } catch (error) {
    console.error('Error checking patient visit status:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.createBilling = async (req, res) => {
  try {
    const { patientId, visitId, insuranceId, services, notes } = createBillingSchema.parse(req.body);

    // Get patient info to determine billing status
    const patient = await prisma.patient.findUnique({
      where: { id: patientId },
      include: { insurance: true }
    });

    if (!patient) {
      return res.status(404).json({ error: 'Patient not found' });
    }

    // Calculate total amount
    let totalAmount = 0;
    const billingServices = [];

    for (const serviceData of services) {
      const service = await prisma.service.findUnique({
        where: { id: serviceData.serviceId }
      });

      if (!service) {
        return res.status(404).json({ error: `Service with ID ${serviceData.serviceId} not found` });
      }

      if (!service.isActive) {
        return res.status(400).json({ error: `Service with ID ${serviceData.serviceId} is not active` });
      }

      const unitPrice = serviceData.unitPrice || service.price;
      const totalPrice = unitPrice * serviceData.quantity;
      totalAmount += totalPrice;

      billingServices.push({
        serviceId: serviceData.serviceId,
        quantity: serviceData.quantity,
        unitPrice,
        totalPrice
      });
    }

    // Determine billing status based on patient type
    let billingStatus = 'PENDING';
    if (patient.type === 'EMERGENCY') {
      billingStatus = 'EMERGENCY_PENDING';
    } else if (patient.type === 'INSURANCE' && patient.insuranceId) {
      billingStatus = 'PENDING_INSURANCE';
    }

    const billing = await prisma.billing.create({
      data: {
        patientId,
        visitId,
        insuranceId,
        totalAmount,
        status: billingStatus,
        notes
      }
    });

    // Create billing services
    for (const serviceData of billingServices) {
      await prisma.billingService.create({
        data: {
          billingId: billing.id,
          ...serviceData
        }
      });
    }

    // Create audit log
    await prisma.auditLog.create({
      data: {
        userId: req.user.id,
        action: 'CREATE_BILLING',
        entity: 'Billing',
        entityId: billing.id,
        details: JSON.stringify({
          patientId: billing.patientId,
          visitId: billing.visitId,
          totalAmount: billing.totalAmount,
          status: billing.status,
          services: billingServices
        }),
        ip: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    const billingWithServices = await prisma.billing.findUnique({
      where: { id: billing.id },
      include: {
        patient: {
          select: {
            id: true,
            name: true,
            type: true
          }
        },
        services: {
          include: {
            service: {
              select: {
                code: true,
                name: true,
                category: true
              }
            }
          }
        },
        insurance: {
          select: {
            name: true,
            code: true
          }
        }
      }
    });

    res.json({
      message: 'Billing created successfully',
      billing: billingWithServices
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: 'Validation error', details: error.errors });
    }
    res.status(500).json({ error: error.message });
  }
};

exports.getInsurances = async (req, res) => {
  try {
    const insurances = await prisma.insurance.findMany({
      where: { isActive: true },
      orderBy: { name: 'asc' }
    });
    res.json({ insurances });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.processPayment = async (req, res) => {
  try {
    console.log('Payment request body:', JSON.stringify(req.body, null, 2));
    // Remove Zod validation completely for testing
    const { billingId, amount, type, bankName, transNumber, insuranceId, notes, isEmergency } = req.body;

    // Convert amount to number if it's a string
    const numericAmount = typeof amount === 'string' ? parseFloat(amount) : amount;
    console.log('Amount conversion:', { original: amount, converted: numericAmount });

    // Get billing with all related data
    const billing = await prisma.billing.findUnique({
      where: { id: billingId },
      include: {
        patient: true,
        services: {
          include: {
            service: true
          }
        },
        payments: true,
        visit: {
          include: {
            labOrders: true,
            radiologyOrders: true,
            medicationOrders: true
          }
        },
        insurance: true
      }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    if (billing.status === 'PAID') {
      return res.status(400).json({ error: 'Billing already paid' });
    }

    // Check if there's already a payment being processed (prevent double-click)
    const existingPayment = await prisma.billPayment.findFirst({
      where: {
        billingId: billingId,
        amount: numericAmount,
        type: type
      }
    });

    if (existingPayment) {
      return res.status(400).json({ error: 'Payment already processed' });
    }

    // Check if patient has an account (null for walk-in patients)
    let patientAccount = null;
    try {
      patientAccount = await prisma.patientAccount.findUnique({
        where: { patientId: billing.patientId }
      });
    } catch (error) {
      // Patient account might not exist for walk-in patients
      console.log('No patient account found for patient:', billing.patientId);
      patientAccount = null;
    }

    // Calculate remaining balance
    const totalPaid = billing.payments.reduce((sum, p) => sum + p.amount, 0);
    let remainingBalance = billing.totalAmount - totalPaid;

    // Validate payment amount - allow 0 for converting full amount to debt
    if (numericAmount > remainingBalance) {
      return res.status(400).json({ error: `Payment exceeds remaining balance of ${remainingBalance} ETB` });
    }

    if (numericAmount < 0) {
      return res.status(400).json({ error: 'Payment amount cannot be negative' });
    }

    // Allow 0 payment - this converts full remaining balance to debt
    // Handle advance account payment
    const useAccount = req.body.useAccount || false;
    let amountFromAccount = 0;
    let amountFromCash = numericAmount;

    if (useAccount && patientAccount && patientAccount.balance > 0) {
      amountFromAccount = Math.min(numericAmount, patientAccount.balance);
      amountFromCash = numericAmount - amountFromAccount;
    }

    // If this is a partial payment that should be converted to debt
    const convertToDebt = req.body.convertToDebt || billing.isDeferred;

    // Create patient account automatically if it doesn't exist and we need to handle debt
    if (convertToDebt && !patientAccount) {
      patientAccount = await prisma.patientAccount.create({
        data: {
          patientId: billing.patientId,
          accountType: 'CREDIT',
          status: 'VERIFIED',
          balance: 0,
          debtOwed: 0
        }
      });
      console.log('Automatically created CREDIT account for patient:', billing.patientId);
    }

    // Handle account deduction or debt creation
    const payment = await prisma.$transaction(async (tx) => {
      // Create primary payment (Cash/Bank/Insurance)
      const mainPayment = await tx.billPayment.create({
        data: {
          billingId,
          patientId: billing.patientId,
          amount: numericAmount,
          type,
          bankName,
          transNumber,
          insuranceId,
          notes: notes || (convertToDebt ? 'Partial payment' : null)
        }
      });

      // Update billing paid amount
      await tx.billing.update({
        where: { id: billingId },
        data: {
          paidAmount: {
            increment: numericAmount
          }
        }
      });

      // If there's a remaining balance and we should convert to debt
      if (convertToDebt && remainingBalance > numericAmount) {
        const debtAmount = remainingBalance - numericAmount;

        // Create a CREDIT type payment for the remainder
        await tx.billPayment.create({
          data: {
            billingId,
            patientId: billing.patientId,
            amount: debtAmount,
            type: 'CREDIT',
            notes: 'Converted to debt/credit'
          }
        });

        // Update billing paid amount again (the bill is now fully covered by Cash + Credit)
        await tx.billing.update({
          where: { id: billingId },
          data: {
            paidAmount: {
              increment: debtAmount
            }
          }
        });

        // Add to patient's debt (and upgrade account to BOTH if it was ADVANCE)
        const accountUpdateData = {
          debtOwed: { increment: debtAmount }
        };
        if (patientAccount.accountType === 'ADVANCE') {
          accountUpdateData.accountType = 'BOTH';
        }

        await tx.patientAccount.update({
          where: { id: patientAccount.id },
          data: accountUpdateData
        });

        // Log transaction
        await tx.accountTransaction.create({
          data: {
            accountId: patientAccount.id,
            patientId: billing.patientId,
            type: 'DEBT',
            subAccount: 'CREDIT',
            amount: debtAmount,
            balanceBefore: patientAccount.debtOwed,
            balanceAfter: patientAccount.debtOwed + debtAmount,
            billingId: billing.id,
            visitId: billing.visitId,
            notes: `Debt added from billing ${billing.id}`,
            description: `Unpaid balance from billing #${billing.id.substring(0, 8)}`,
            processedById: req.user.id
          }
        });
      }

      return mainPayment;
    });

    // If this is an insurance payment, create insurance transactions for each service
    if (type === 'INSURANCE' && insuranceId) {
      for (const billingService of billing.services) {
        await prisma.insuranceTransaction.create({
          data: {
            insuranceId,
            patientId: billing.patientId,
            visitId: billing.visitId,
            serviceType: getServiceTypeFromCategory(billingService.service.category),
            serviceId: billingService.serviceId,
            serviceName: billingService.service.name,
            serviceCode: billingService.service.code,
            unitPrice: billingService.unitPrice,
            totalAmount: billingService.totalPrice,
            quantity: billingService.quantity,
            status: 'PENDING',
            notes: notes || 'Insurance payment processed',
            createdById: req.user.id
          }
        });
      }
    }

    // Handle account deduction if applicable
    if (amountFromAccount > 0 && patientAccount) {
      // For all account types, 'useAccount' specifically applies to Advance 'balance'
      const newBalance = patientAccount.balance - amountFromAccount;

      await prisma.patientAccount.update({
        where: { id: patientAccount.id },
        data: {
          balance: newBalance,
          totalUsed: {
            increment: amountFromAccount
          }
        }
      });

      // Create service description
      const serviceDescriptions = billing.services.map(s => `${s.service.name} (${s.quantity}x)`).join(', ');
      const description = `${serviceDescriptions || 'Services'}`;

      // Create transaction log for balance
      await prisma.accountTransaction.create({
        data: {
          accountId: patientAccount.id,
          patientId: billing.patientId,
          type: 'USAGE',
          subAccount: 'ADVANCE',
          amount: amountFromAccount,
          balanceBefore: patientAccount.balance,
          balanceAfter: newBalance,
          billingId: billing.id,
          visitId: billing.visitId,
          notes: `Advance used for billing ${billing.id}`,
          description: description,
          processedById: req.user.id
        }
      });
    }

    // Create audit log
    await prisma.auditLog.create({
      data: {
        userId: req.user.id,
        action: 'PROCESS_PAYMENT',
        entity: 'BillPayment',
        entityId: 0,
        details: JSON.stringify({
          billingId,
          patientId: billing.patientId,
          paymentId: payment.id,
          amount: numericAmount,
          amountFromAccount,
          amountFromCash,
          type,
          bankName,
          transNumber,
          notes,
          isEmergency,
          processedBy: req.user.fullname || req.user.username
        }),
        ip: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    // If marked as emergency, copy services to emergency billing
    if (isEmergency) {
      console.log('Emergency service detected - copying to emergency billing');

      // Find or create emergency billing for this patient
      let emergencyBilling = await prisma.billing.findFirst({
        where: {
          patientId: billing.patientId,
          billingType: 'EMERGENCY',
          status: 'EMERGENCY_PENDING'
        }
      });

      if (!emergencyBilling) {
        // Create new emergency billing
        emergencyBilling = await prisma.billing.create({
          data: {
            patientId: billing.patientId,
            visitId: billing.visitId,
            totalAmount: 0,
            status: 'EMERGENCY_PENDING',
            billingType: 'EMERGENCY',
            notes: 'Emergency services - payment deferred'
          }
        });
      }

      // Copy all services from this billing to emergency billing
      for (const service of billing.services) {
        // Check if service already exists in emergency billing
        const existingService = await prisma.billingService.findFirst({
          where: {
            billingId: emergencyBilling.id,
            serviceId: service.serviceId
          }
        });

        if (!existingService) {
          await prisma.billingService.create({
            data: {
              billingId: emergencyBilling.id,
              serviceId: service.serviceId,
              quantity: service.quantity,
              unitPrice: service.unitPrice,
              totalPrice: service.totalPrice
            }
          });
        }
      }

      // Update emergency billing total
      const emergencyServices = await prisma.billingService.findMany({
        where: { billingId: emergencyBilling.id }
      });

      const emergencyTotal = emergencyServices.reduce((sum, service) => sum + service.totalPrice, 0);

      await prisma.billing.update({
        where: { id: emergencyBilling.id },
        data: { totalAmount: emergencyTotal }
      });

      console.log(`Emergency billing updated: ${emergencyBilling.id}, Total: ${emergencyTotal}`);
    }

    // Check if billing is fully paid
    const allPayments = await prisma.billPayment.findMany({
      where: { billingId: billing.id }
    });
    const newTotalPaid = allPayments.reduce((sum, p) => sum + p.amount, 0);
    const isFullyPaid = newTotalPaid >= billing.totalAmount;

    // Update billing status based on payment amount
    if (isFullyPaid) {
      // Fully paid
      await prisma.billing.update({
        where: { id: billingId },
        data: { status: 'PAID' }
      });
    } else if (newTotalPaid > 0) {
      // Partially paid
      await prisma.billing.update({
        where: { id: billingId },
        data: { status: 'PARTIALLY_PAID' }
      });
    } else {
      // Still pending
      await prisma.billing.update({
        where: { id: billingId },
        data: { status: 'PENDING' }
      });
    }

    if (isFullyPaid) {

      // Check for pending admission linked to this billing and activate it
      const pendingAdmission = await prisma.admission.findFirst({
        where: {
          billingId: billingId,
          status: 'PENDING_PAYMENT'
        }
      });

      if (pendingAdmission) {
        await prisma.admission.update({
          where: { id: pendingAdmission.id },
          data: { status: 'ADMITTED' }
        });
      }

      // Check if this is card activation billing (for automatic card activation)
      const isCardActivation = billing.services.some(service =>
        CARD_ACTIVATION_CODES.includes(service.service.code)
      );
      const isCardRegistration = billing.services.some(service =>
        CARD_REGISTRATION_CODES.includes(service.service.code)
      );

      // Automatically activate card after payment for card registration or activation
      if (isCardActivation || isCardRegistration) {
        // Get card expiry period from system settings
        const systemSettingsController = require('./systemSettingsController');
        const expiryPeriodDays = await systemSettingsController.getCardExpiryPeriodDays();

        const activationDate = new Date();
        const expiryDate = new Date(activationDate);
        expiryDate.setDate(expiryDate.getDate() + expiryPeriodDays); // Card valid for configured period

        await prisma.patient.update({
          where: { id: billing.patientId },
          data: {
            cardStatus: 'ACTIVE',
            cardActivatedAt: activationDate,
            cardExpiryDate: expiryDate
          }
        });

        // Create card activation history record (wrapped in try-catch so visit creation still works if this fails)
        try {
          const existingActivation = await prisma.cardActivation.findFirst({
            where: {
              billingId: billing.id,
              patientId: billing.patientId
            }
          });

          if (!existingActivation) {
            await prisma.cardActivation.create({
              data: {
                patientId: billing.patientId,
                activatedById: req.user.id,
                activatedAt: activationDate,
                expiresAt: expiryDate,
                billingId: billing.id,
                notes: isCardRegistration ? 'Initial card registration' : 'Card renewal/activation'
              }
            });
            console.log(`✅ Card activation record created for billing ${billing.id}`);
          } else {
            console.log(`Card activation already exists for billing ${billing.id}, skipping creation`);
          }
        } catch (cardActivationError) {
          console.error(`⚠️ Failed to create card activation record for billing ${billing.id}, but continuing with visit creation:`, cardActivationError.message);
        }

        // Log action (wrapped in try-catch)
        try {
          await prisma.auditLog.create({
            data: {
              action: 'CARD_ACTIVATED_AUTOMATIC',
              entity: 'Patient',
              entityId: parseInt(billing.patientId.split('-').pop()) || 0,
              userId: req.user.id,
              details: `Card automatically activated after payment for patient ${billing.patient.name} (${billing.patientId}). Expires: ${expiryDate.toISOString()}`
            }
          });
        } catch (auditError) {
          console.error('⚠️ Failed to create audit log for card activation:', auditError.message);
        }

        // Automatically create visit and send to triage after CARD-REG or CARD-ACT payment
        // This handles both new patients (CARD-REG) and returning patients reactivating their card (CARD-ACT)
        if ((isCardRegistration || isCardActivation) && !billing.visitId) {
          try {
            const { generateUniqueVisitUid } = require('../utils/visitUidGenerator');

            // Check if patient already has an active visit (for returning patients)
            const activeVisit = await prisma.visit.findFirst({
              where: {
                patientId: billing.patientId,
                status: {
                  in: [
                    'WAITING_FOR_TRIAGE',
                    'TRIAGED',
                    'WAITING_FOR_DOCTOR',
                    'IN_DOCTOR_QUEUE',
                    'UNDER_DOCTOR_REVIEW',
                    'SENT_TO_LAB',
                    'SENT_TO_RADIOLOGY',
                    'SENT_TO_BOTH',
                    'RETURNED_WITH_RESULTS',
                    'AWAITING_LAB_RESULTS',
                    'AWAITING_RADIOLOGY_RESULTS',
                    'AWAITING_RESULTS_REVIEW'
                  ]
                }
              }
            });

            let visit;
            if (activeVisit) {
              // If patient has an active visit, link the billing to it
              visit = activeVisit;
              await prisma.billing.update({
                where: { id: billing.id },
                data: { visitId: visit.id }
              });

              // Log action
              await prisma.auditLog.create({
                data: {
                  action: 'BILLING_LINKED_TO_VISIT',
                  entity: 'Billing',
                  entityId: 0,
                  userId: req.user.id,
                  details: `Card activation billing linked to existing active visit ${visit.visitUid} for patient ${billing.patient.name} (${billing.patientId})`
                }
              });
              console.log(`✅ Billing linked to existing visit ${visit.visitUid} for patient ${billing.patient.name}`);
            } else {
              // Create new visit for patient
              visit = await generateUniqueVisitUid(async (visitUid) => {
                return await prisma.visit.create({
                  data: {
                    visitUid,
                    patientId: billing.patientId,
                    createdById: req.user.id,
                    status: 'WAITING_FOR_TRIAGE',
                    queueType: 'CONSULTATION',
                    isEmergency: false,
                    notes: `Automatic visit creation after ${isCardRegistration ? 'card registration' : 'card activation'} payment`
                  }
                });
              }, prisma);

              // Update billing to link the visit
              await prisma.billing.update({
                where: { id: billing.id },
                data: { visitId: visit.id }
              });

              // Log action
              await prisma.auditLog.create({
                data: {
                  action: 'VISIT_CREATED_AUTOMATIC',
                  entity: 'Visit',
                  entityId: visit.id,
                  userId: req.user.id,
                  details: `Visit automatically created after ${isCardRegistration ? 'CARD-REG' : 'CARD-ACT'} payment for patient ${billing.patient.name} (${billing.patientId}). Status: WAITING_FOR_TRIAGE`
                }
              });
              console.log(`✅ Visit ${visit.visitUid} created and sent to triage for patient ${billing.patient.name}`);
            }
          } catch (visitError) {
            console.error(`❌ Failed to create visit for patient ${billing.patientId} after card activation payment:`, visitError.message);
          }
        }
      }

      // Check if this is diagnostics billing (lab/radiology), nurse walk-in, emergency drugs, or material needs
      const hasLabServices = billing.services.some(service =>
        service.service.category === 'LAB'
      );
      const hasRadiologyServices = billing.services.some(service =>
        service.service.category === 'RADIOLOGY'
      );
      const hasNurseWalkInServices = billing.services.some(service =>
        service.service.category === 'NURSE_WALKIN'
      );
      const hasEmergencyDrugServices = billing.services.some(service =>
        service.service.category === 'EMERGENCY_DRUG'
      );
      const hasMaterialNeedsServices = billing.services.some(service =>
        service.service.category === 'MATERIAL_NEEDS'
      );
      const isDiagnosticsBilling = hasLabServices || hasRadiologyServices;
      const isNurseWalkInBilling = hasNurseWalkInServices;
      const isEmergencyDrugBilling = hasEmergencyDrugServices;
      const isMaterialNeedsBilling = hasMaterialNeedsServices;

      // Update walk-in lab orders (no visitId, use billingId) - for walk-ins
      if (isDiagnosticsBilling && !billing.visit) {
        console.log('💰 [Payment] Updating walk-in lab orders for billing:', billing.id);
        console.log('   Conditions met: isDiagnosticsBilling=', isDiagnosticsBilling, '!billing.visit=', !billing.visit);

        // Check how many orders exist before update
        const ordersBeforeUpdate = await prisma.labTestOrder.count({
          where: {
            billingId: billing.id,
            isWalkIn: true
          }
        });
        console.log(`   Found ${ordersBeforeUpdate} LabTestOrders for this billing`);

        // Update old system lab orders
        const oldLabOrdersUpdated = await prisma.labOrder.updateMany({
          where: {
            billingId: billing.id,
            isWalkIn: true,
            status: 'UNPAID'
          },
          data: { status: 'QUEUED' }
        });
        console.log(`   ✅ Updated ${oldLabOrdersUpdated.count} old lab orders to QUEUED`);

        // Update new system LabTestOrders
        const labTestOrdersUpdated = await prisma.labTestOrder.updateMany({
          where: {
            billingId: billing.id,
            isWalkIn: true,
            status: 'UNPAID'
          },
          data: { status: 'PAID' }
        });
        console.log(`   ✅ Updated ${labTestOrdersUpdated.count} new lab test orders to PAID`);

        // Verify update worked
        if (labTestOrdersUpdated.count === 0 && ordersBeforeUpdate > 0) {
          console.warn('   ⚠️  WARNING: Orders exist but update count is 0. Checking order statuses...');
          const existingOrders = await prisma.labTestOrder.findMany({
            where: {
              billingId: billing.id,
              isWalkIn: true
            },
            select: { id: true, status: true }
          });
          console.log('   Existing orders statuses:', existingOrders);
        }

        // Update radiology orders: set to PAID (they will be shown in radiology queue)
        const radOrdersUpdated = await prisma.radiologyOrder.updateMany({
          where: {
            billingId: billing.id,
            isWalkIn: true,
            status: 'UNPAID'
          },
          data: { status: 'PAID' }
        });
        console.log(`   ✅ Updated ${radOrdersUpdated.count} radiology orders to PAID`);
      }

      // Update walk-in nurse service orders
      if (isNurseWalkInBilling && !billing.visit) {
        console.log('💰 [Payment] Updating walk-in nurse service orders for billing:', billing.id);

        const nurseWalkInOrdersUpdated = await prisma.nurseWalkInOrder.updateMany({
          where: {
            billingId: billing.id,
            status: 'UNPAID'
          },
          data: { status: 'PAID' }
        });
        console.log(`   ✅ Updated ${nurseWalkInOrdersUpdated.count} nurse walk-in orders to PAID`);
      }

      // Update emergency drug orders
      if (isEmergencyDrugBilling) {
        console.log('💰 [Payment] Updating emergency drug orders for billing:', billing.id);

        const emergencyDrugOrdersUpdated = await prisma.emergencyDrugOrder.updateMany({
          where: {
            billingId: billing.id,
            status: 'UNPAID'
          },
          data: { status: 'PAID' }
        });
        console.log(`   ✅ Updated ${emergencyDrugOrdersUpdated.count} emergency drug orders to PAID`);
      }

      // Update material needs orders
      if (isMaterialNeedsBilling) {
        console.log('💰 [Payment] Updating material needs orders for billing:', billing.id);

        const materialNeedsOrdersUpdated = await prisma.materialNeedsOrder.updateMany({
          where: {
            billingId: billing.id,
            status: 'UNPAID'
          },
          data: { status: 'PAID' }
        });
        console.log(`   ✅ Updated ${materialNeedsOrdersUpdated.count} material needs orders to PAID`);
      }

      if (!isDiagnosticsBilling && !isNurseWalkInBilling && !isEmergencyDrugBilling && !isMaterialNeedsBilling) {
        console.log('💰 [Payment] Skipping order update:', {
          isDiagnosticsBilling,
          hasVisit: !!billing.visit,
          billingId: billing.id
        });
      }

      // Update related orders based on billing type (for regular visits)
      if (billing.visit) {
        await prisma.$transaction(async (tx) => {

          // Check if this is a triage/visit creation billing (automatic send to nurse triage)
          const isTriageService = billing.services.some(service =>
            service.service.code === 'TRIAGE' ||
            service.service.name.toLowerCase().includes('triage') ||
            service.service.category === 'CONSULTATION'
          );

          // Automatically send to triage if this is a visit creation billing and visit is in WAITING_FOR_TRIAGE status
          if (isTriageService && billing.visit.status === 'WAITING_FOR_TRIAGE') {
            await tx.visit.update({
              where: { id: billing.visit.id },
              data: { status: 'WAITING_FOR_TRIAGE' } // Keep as WAITING_FOR_TRIAGE - nurse will see it in their queue
            });

            // Log action
            await prisma.auditLog.create({
              data: {
                action: 'VISIT_SENT_TO_TRIAGE',
                entity: 'Visit',
                entityId: billing.visit.id,
                userId: req.user.id,
                details: `Visit ${billing.visit.visitUid} automatically sent to triage after payment for patient ${billing.patient.name} (${billing.patientId})`
              }
            });
          }

          // --- INDEPENDENT CATEGORY UPDATES ---

          // 1. Dental Services
          const hasDental = billing.services.some(s => s.service.category === 'DENTAL');
          if (hasDental || billing.visit.status === 'DENTAL_SERVICES_ORDERED') {
            const dentalBatchOrders = await tx.batchOrder.findMany({
              where: { visitId: billing.visit.id, type: 'DENTAL', status: 'UNPAID' },
              select: { id: true }
            });

            if (dentalBatchOrders.length > 0) {
              const dentalBatchIds = dentalBatchOrders.map(b => b.id);
              await tx.batchOrder.updateMany({
                where: { id: { in: dentalBatchIds } },
                data: { status: 'PAID' }
              });
              await tx.batchOrderService.updateMany({
                where: { batchOrderId: { in: dentalBatchIds }, status: 'UNPAID' },
                data: { status: 'PAID' }
              });
            }

            await tx.visit.update({
              where: { id: billing.visit.id },
              data: { status: 'IN_DOCTOR_QUEUE' }
            });
            console.log(`   ✅ Updated dental orders to PAID`);
          }

          // 2. Diagnostics (Lab/Radiology)
          if (isDiagnosticsBilling) {
            console.log('💰 [Payment] Updating diagnostics orders for visit:', billing.visit.id);

            // Radiology Logic (BatchOrders)
            const radiologyServices = billing.services.filter(s => s.service.category === 'RADIOLOGY');
            if (radiologyServices.length > 0) {
              const radiologyServiceIds = radiologyServices.map(s => s.serviceId);
              const investigationTypes = await tx.investigationType.findMany({
                where: { serviceId: { in: radiologyServiceIds }, category: 'RADIOLOGY' }
              });

              for (const rs of radiologyServices) {
                const invType = investigationTypes.find(it => it.serviceId === rs.serviceId);
                if (invType) {
                  const radBatchOrders = await tx.batchOrder.findMany({
                    where: { visitId: billing.visit.id, type: 'RADIOLOGY', status: 'UNPAID' },
                    select: { id: true }
                  });
                  const radBatchIds = radBatchOrders.map(b => b.id);

                  if (radBatchIds.length > 0) {
                    await tx.batchOrder.updateMany({
                      where: { id: { in: radBatchIds } },
                      data: { status: 'PAID' }
                    });
                    await tx.batchOrderService.updateMany({
                      where: { batchOrderId: { in: radBatchIds }, serviceId: rs.serviceId, status: 'UNPAID' },
                      data: { status: 'PAID' }
                    });
                  }
                }
              }
            }

            // Lab Logic (LabTestOrder & BatchOrders)
            await tx.labTestOrder.updateMany({
              where: { billingId: billing.id, visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'PAID' }
            });

            const labBatchOrdersFound = await tx.batchOrder.findMany({
              where: { visitId: billing.visit.id, status: 'UNPAID', type: { in: ['LAB', 'MIXED'] } },
              select: { id: true }
            });

            if (labBatchOrdersFound.length > 0) {
              const labBatchIds = labBatchOrdersFound.map(b => b.id);
              await tx.batchOrder.updateMany({
                where: { id: { in: labBatchIds } },
                data: { status: 'QUEUED' }
              });

              await tx.batchOrderService.updateMany({
                where: { batchOrderId: { in: labBatchIds }, status: 'UNPAID' },
                data: { status: 'QUEUED' }
              });
            }

            // Backward compat
            await tx.labOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'QUEUED' }
            });
            await tx.radiologyOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'QUEUED' }
            });
            console.log(`   ✅ Updated diagnostics orders to PAID/QUEUED`);
          }

          // 3. Medical Procedures
          const hasProcedure = billing.services.some(s => s.service.category === 'PROCEDURE');
          if (hasProcedure) {
            // Find batch orders of type PROCEDURE for this visit
            const procedureBatchOrders = await tx.batchOrder.findMany({
              where: {
                visitId: billing.visit.id,
                type: 'PROCEDURE',
                status: 'UNPAID'
              },
              select: { id: true }
            });

            if (procedureBatchOrders.length > 0) {
              const batchIds = procedureBatchOrders.map(b => b.id);

              await tx.batchOrder.updateMany({
                where: { id: { in: batchIds } },
                data: { status: 'PAID' }
              });

              await tx.batchOrderService.updateMany({
                where: { batchOrderId: { in: batchIds }, status: 'UNPAID' },
                data: { status: 'PAID' }
              });
              console.log(`   ✅ Updated ${batchIds.length} procedure batch orders to PAID`);
            }
          }

          // 4. Medication & Emergency Drugs (Normal/Emergency)
          const hasMedication = billing.services.some(s => ['MEDICATION', 'EMERGENCY_DRUG', 'NURSE_WALKIN', 'MATERIAL_NEEDS'].includes(s.service.category));
          if (hasMedication) {
            // Medication Orders
            await tx.medicationOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'QUEUED' }
            });

            // Continuous Infusions
            const visitMedicationOrders = await tx.medicationOrder.findMany({
              where: { visitId: billing.visit.id },
              select: { id: true }
            });
            const medOrderIds = visitMedicationOrders.map(mo => mo.id);

            if (medOrderIds.length > 0) {
              await tx.continuousInfusion.updateMany({
                where: { medicationOrderId: { in: medOrderIds }, status: 'UNPAID' },
                data: { status: 'QUEUED' }
              });
            }

            // Emergency Drug Orders
            await tx.emergencyDrugOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'PAID' }
            });

            // Nurse Walk-in Orders (if linked to visit)
            await tx.nurseWalkInOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'PAID' }
            });

            // Material Needs
            await tx.materialNeedsOrder.updateMany({
              where: { visitId: billing.visit.id, status: 'UNPAID' },
              data: { status: 'PAID' }
            });

            console.log(`   ✅ Updated medication and related orders to QUEUED/PAID`);
          }
        });
      }
    }

    // Add to daily cash management for CASH and BANK payments
    // Only count the cash portion (not account balance used)
    // Note: INSURANCE and CHARITY payments don't count as cash received here
    if ((type === 'CASH' || type === 'BANK') && amountFromCash > 0) {
      try {
        // Find active cash session for today
        const today = new Date();
        today.setHours(0, 0, 0, 0);
        const tomorrow = new Date(today);
        tomorrow.setDate(tomorrow.getDate() + 1);

        let activeSession = await prisma.dailyCashSession.findFirst({
          where: {
            createdById: req.user.id,
            sessionDate: {
              gte: today,
              lt: tomorrow
            },
            status: 'ACTIVE'
          }
        });

        // If no active session, create one
        if (!activeSession) {
          activeSession = await prisma.dailyCashSession.create({
            data: {
              createdById: req.user.id,
              startingCash: 0,
              sessionDate: new Date()
            }
          });
        }

        // Create cash transaction
        await prisma.cashTransaction.create({
          data: {
            sessionId: activeSession.id,
            type: 'PAYMENT_RECEIVED',
            amount: amountFromCash,
            description: `Payment from ${billing.patient.name} (${billing.patient.id}) - ${billing.services.map(s => s.service.name).join(', ')}`,
            paymentMethod: type === 'BANK' ? 'BANK' : 'CASH',
            patientId: billing.patientId,
            billingId: billing.id,
            processedById: req.user.id
          }
        });
      } catch (cashError) {
        // Log error but don't fail the payment
        console.error('Error adding payment to cash session:', cashError);
      }
    }

    // Generate PDF receipt with safe error handling
    let receiptUrl = '';
    try {
      const timestamp = Date.now();
      const fileName = `receipt-${billingId}-${timestamp}.pdf`;
      const filePath = `uploads/${fileName}`;
      receiptUrl = `/uploads/${fileName}`;

      const docDefinition = {
        content: [
          { text: 'Payment Receipt', style: 'header' },
          { text: `Patient: ${billing.patient.name} (${billing.patient.id})`, margin: [0, 10] },
          { text: `Billing Total: ${billing.totalAmount} ETB`, margin: [0, 5] },
          { text: `Amount Paid: ${numericAmount} ETB`, margin: [0, 5] },
          { text: `Payment Type: ${type}`, margin: [0, 5] },
          { text: bankName ? `Bank: ${bankName}, Transaction: ${transNumber}` : '', margin: [0, 5] },
          { text: `Remaining Balance: ${billing.totalAmount - newTotalPaid} ETB`, margin: [0, 5] },
          { text: 'Services:', margin: [0, 10] },
          { ul: billing.services.map(bs => `${bs.service.name} (${bs.quantity}x): ${bs.totalPrice} ETB`) },
        ],
        styles: { header: { fontSize: 18, bold: true } },
      };

      const pdfDoc = printer.createPdfKitDocument(docDefinition);
      pdfDoc.pipe(fs.createWriteStream(filePath));
      pdfDoc.end();
      console.log(`   📄 Receipt generated: ${filePath}`);
    } catch (pdfError) {
      console.error('❌ Error generating PDF receipt:', pdfError);
      // Don't fail the response if just the PDF failed
    }

    res.json({
      message: 'Payment processed successfully',
      payment,
      billingStatus: isFullyPaid ? 'PAID' : 'PARTIALLY_PAID',
      remainingBalance: billing.totalAmount - newTotalPaid,
      receiptUrl: receiptUrl
    });
  } catch (error) {
    console.error('Payment processing error:', error);
    console.error('Error type:', error.constructor.name);
    console.error('Error message:', error.message);
    if (error instanceof z.ZodError) {
      console.error('Zod validation errors:', error.errors);
      return res.status(400).json({ error: 'Validation error', details: error.errors });
    }
    res.status(500).json({ error: error.message });
  }
};

exports.getBillings = async (req, res) => {
  try {
    const { status, patientId, visitId, page = 1, limit = 10, search = '' } = req.query;

    const pageNum = parseInt(page);
    const limitNum = parseInt(limit);
    const skip = (pageNum - 1) * limitNum;

    let whereClause = {};

    if (status && status !== 'ALL') {
      whereClause.status = status;
    }

    if (patientId) {
      whereClause.patientId = patientId;
    }

    if (visitId) {
      whereClause.visitId = parseInt(visitId);
    }

    if (search) {
      whereClause.OR = [
        { patient: { name: { contains: search, mode: 'insensitive' } } },
        { patient: { id: { contains: search, mode: 'insensitive' } } },
        { patient: { mobile: { contains: search } } },
        { id: { contains: search, mode: 'insensitive' } }
      ];
    }

    // Get total count for pagination
    const totalCount = await prisma.billing.count({ where: whereClause });

    const billings = await prisma.billing.findMany({
      where: whereClause,
      include: {
        patient: {
          select: {
            id: true,
            name: true,
            type: true,
            mobile: true,
            email: true
          }
        },
        services: {
          include: {
            service: {
              select: {
                code: true,
                name: true,
                category: true
              }
            }
          }
        },
        payments: true,
        visit: {
          select: {
            id: true,
            visitUid: true,
            status: true,
            isEmergency: true
          }
        },
        insurance: {
          select: {
            name: true,
            code: true
          }
        }
      },
      orderBy: { createdAt: 'desc' },
      skip: skip,
      take: limitNum
    });

    res.json({
      billings,
      pagination: {
        totalCount,
        totalPages: Math.ceil(totalCount / limitNum),
        currentPage: pageNum,
        limit: limitNum
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get billing dashboard statistics for a specific user
exports.getBillingDashboardStats = async (req, res) => {
  try {
    const userId = req.user.id;
    const { period = 'daily' } = req.query; // daily, weekly, monthly, yearly

    // Calculate date ranges based on period
    const now = new Date();
    let startDate, endDate;

    switch (period) {
      case 'daily':
        startDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        endDate = new Date(startDate.getTime() + 24 * 60 * 60 * 1000);
        break;
      case 'weekly':
        const dayOfWeek = now.getDay();
        startDate = new Date(now.getTime() - dayOfWeek * 24 * 60 * 60 * 1000);
        startDate.setHours(0, 0, 0, 0);
        endDate = new Date(startDate.getTime() + 7 * 24 * 60 * 60 * 1000);
        break;
      case 'monthly':
        startDate = new Date(now.getFullYear(), now.getMonth(), 1);
        endDate = new Date(now.getFullYear(), now.getMonth() + 1, 1);
        break;
      case 'yearly':
        startDate = new Date(now.getFullYear(), 0, 1);
        endDate = new Date(now.getFullYear() + 1, 0, 1);
        break;
      default:
        startDate = new Date(now.getFullYear(), now.getMonth(), now.getDate());
        endDate = new Date(startDate.getTime() + 24 * 60 * 60 * 1000);
    }

    // Get payments processed by this user in the specified period
    const payments = await prisma.billPayment.findMany({
      where: {
        createdAt: {
          gte: startDate,
          lt: endDate
        },
        // We need to join with audit logs to find payments processed by this user
      },
      include: {
        billing: {
          include: {
            patient: {
              select: {
                id: true,
                name: true
              }
            }
          }
        },
        insurance: {
          select: {
            name: true,
            code: true
          }
        }
      },
      orderBy: { createdAt: 'desc' }
    });

    // Filter payments that were actually processed by this user using audit logs
    const userProcessedPayments = [];
    for (const payment of payments) {
      const auditLog = await prisma.auditLog.findFirst({
        where: {
          userId: userId,
          action: 'PROCESS_PAYMENT',
          details: {
            contains: payment.id
          },
          createdAt: {
            gte: startDate,
            lt: endDate
          }
        }
      });

      if (auditLog) {
        userProcessedPayments.push(payment);
      }
    }

    // Calculate statistics by payment type
    const statsByType = {
      CASH: { count: 0, amount: 0 },
      BANK: { count: 0, amount: 0 },
      INSURANCE: { count: 0, amount: 0 },
      CHARITY: { count: 0, amount: 0 }
    };

    let totalAmount = 0;
    let totalCount = 0;

    userProcessedPayments.forEach(payment => {
      statsByType[payment.type].count += 1;
      statsByType[payment.type].amount += payment.amount;
      totalAmount += payment.amount;
      totalCount += 1;
    });

    // Get account deposits (ADVANCE - prepayments) in the period
    const accountDeposits = await prisma.accountDeposit.findMany({
      where: {
        createdAt: {
          gte: startDate,
          lt: endDate
        }
      },
      include: {
        account: {
          select: {
            accountType: true,
            patient: {
              select: { name: true }
            }
          }
        }
      }
    });

    // Calculate ADVANCE deposits (prepayments)
    const advanceDeposits = accountDeposits.filter(d => d.account.accountType === 'ADVANCE');
    const totalAdvanceAmount = advanceDeposits.reduce((sum, d) => sum + d.amount, 0);

    // Get account payments (CREDIT - debt repayments) in the period
    const accountPayments = await prisma.accountTransaction.findMany({
      where: {
        type: 'PAYMENT',
        createdAt: {
          gte: startDate,
          lt: endDate
        }
      },
      include: {
        account: {
          select: {
            accountType: true,
            patient: {
              select: { name: true }
            }
          }
        }
      }
    });

    // Calculate CREDIT payments (debt repayments)
    const creditPayments = accountPayments.filter(p => p.account.accountType === 'CREDIT');
    const totalCreditAmount = creditPayments.reduce((sum, p) => sum + p.amount, 0);

    // Total collected = bill payments + advance deposits + credit payments (debt repayments)
    const totalCollected = totalAmount + totalAdvanceAmount + totalCreditAmount;

    // Get pending billings count (all users can see this)
    const pendingBillings = await prisma.billing.count({
      where: {
        status: 'PENDING'
      }
    });

    // Get total pending amount (all users can see this)
    const pendingBillingsData = await prisma.billing.findMany({
      where: {
        status: 'PENDING'
      },
      select: {
        totalAmount: true
      }
    });

    const pendingAmount = pendingBillingsData.reduce((sum, billing) => sum + billing.totalAmount, 0);

    // Get insurance totals for the period (separate from cash/bank)
    const insuranceTransactions = await prisma.insuranceTransaction.findMany({
      where: {
        serviceDate: {
          gte: startDate,
          lt: endDate
        }
      },
      select: {
        totalAmount: true,
        status: true,
        insurance: {
          select: {
            name: true,
            code: true
          }
        }
      }
    });

    const insuranceTotal = insuranceTransactions.reduce((sum, t) => sum + t.totalAmount, 0);
    const insurancePending = insuranceTransactions
      .filter(t => ['PENDING', 'SUBMITTED', 'APPROVED'].includes(t.status))
      .reduce((sum, t) => sum + t.totalAmount, 0);
    const insuranceCollected = insuranceTransactions
      .filter(t => t.status === 'COLLECTED')
      .reduce((sum, t) => sum + t.totalAmount, 0);

    // Get recent transactions (last 10 payments processed by this user)
    const recentTransactions = userProcessedPayments.slice(0, 10).map(payment => ({
      id: payment.id,
      amount: payment.amount,
      type: payment.type,
      patientName: payment.billing.patient.name,
      createdAt: payment.createdAt,
      bankName: payment.bankName,
      transNumber: payment.transNumber,
      insuranceName: payment.insurance?.name
    }));

    res.json({
      period,
      dateRange: {
        start: startDate,
        end: endDate
      },
      stats: {
        totalAmount, // Cash/Bank payments only (original)
        totalCollected, // All money received including advances and debt repayments
        totalCount,
        pendingBillings,
        pendingAmount,
        byType: statsByType,
        advanceDeposits: {
          count: advanceDeposits.length,
          amount: totalAdvanceAmount
        },
        creditPayments: {
          count: creditPayments.length,
          amount: totalCreditAmount
        },
        insurance: {
          totalAmount: insuranceTotal,
          pendingAmount: insurancePending,
          collectedAmount: insuranceCollected,
          totalTransactions: insuranceTransactions.length
        }
      },
      recentTransactions
    });
  } catch (error) {
    console.error('Error fetching billing dashboard stats:', error);
    res.status(500).json({ error: error.message });
  }
};

exports.getUnpaidBillings = async (req, res) => {
  try {
    const { type } = req.query; // 'diagnostics' or 'medications'

    let whereClause = { status: 'PENDING' };

    if (type === 'diagnostics') {
      whereClause.notes = {
        contains: 'diagnostics'
      };
    } else if (type === 'medications') {
      whereClause.notes = {
        contains: 'medication'
      };
    }

    const billings = await prisma.billing.findMany({
      where: whereClause,
      include: {
        patient: {
          select: {
            id: true,
            name: true,
            type: true,
            mobile: true
          }
        },
        services: {
          include: {
            service: {
              select: {
                code: true,
                name: true,
                category: true
              }
            }
          }
        },
        payments: true,
        visit: {
          select: {
            id: true,
            visitUid: true,
            status: true,
            isEmergency: true
          }
        },
        insurance: {
          select: {
            name: true,
            code: true
          }
        }
      },
      orderBy: { createdAt: 'asc' }
    });

    res.json({ billings });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

exports.addServiceToBilling = async (req, res) => {
  try {
    const { billingId, serviceId, quantity, unitPrice } = addServiceToBillingSchema.parse(req.body);

    // Check if billing exists
    const billing = await prisma.billing.findUnique({
      where: { id: billingId }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    if (billing.status === 'PAID') {
      return res.status(400).json({ error: 'Cannot add services to paid billing' });
    }

    // Get service details
    const service = await prisma.service.findUnique({
      where: { id: serviceId }
    });

    if (!service) {
      return res.status(404).json({ error: 'Service not found' });
    }

    if (!service.isActive) {
      return res.status(400).json({ error: 'Service is not active' });
    }

    const finalUnitPrice = unitPrice || service.price;
    const totalPrice = finalUnitPrice * quantity;

    // Check if service already exists in billing
    const existingBillingService = await prisma.billingService.findUnique({
      where: {
        billingId_serviceId: {
          billingId,
          serviceId
        }
      }
    });

    if (existingBillingService) {
      // Update existing service
      await prisma.billingService.update({
        where: {
          billingId_serviceId: {
            billingId,
            serviceId
          }
        },
        data: {
          quantity: existingBillingService.quantity + quantity,
          totalPrice: existingBillingService.totalPrice + totalPrice
        }
      });
    } else {
      // Create new billing service
      await prisma.billingService.create({
        data: {
          billingId,
          serviceId,
          quantity,
          unitPrice: finalUnitPrice,
          totalPrice
        }
      });
    }

    // Update billing total amount
    const newTotalAmount = billing.totalAmount + totalPrice;
    await prisma.billing.update({
      where: { id: billingId },
      data: { totalAmount: newTotalAmount }
    });

    res.json({
      message: 'Service added to billing successfully',
      billingId,
      serviceId,
      quantity,
      totalPrice
    });
  } catch (error) {
    if (error instanceof z.ZodError) {
      return res.status(400).json({ error: 'Validation error', details: error.errors });
    }
    res.status(500).json({ error: error.message });
  }
};

exports.updateEmergencyPatientId = async (req, res) => {
  try {
    const { tempId } = req.body;
    const { generatePatientId } = require('../utils/patientIdGenerator');

    // Generate new sequential ID (not emergency, since we're converting from TEMP)
    const newId = await generatePatientId(prisma, false);

    const patient = await prisma.patient.update({
      where: { id: tempId },
      data: { id: newId }
    });

    res.json({
      message: 'Patient ID updated successfully',
      patient
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get insurance pending billings
exports.getInsuranceBillings = async (req, res) => {
  try {
    const billings = await prisma.billing.findMany({
      where: { status: 'PENDING_INSURANCE' },
      include: {
        patient: {
          select: {
            id: true,
            name: true,
            type: true,
            mobile: true,
            email: true
          }
        },
        services: {
          include: {
            service: {
              select: {
                code: true,
                name: true,
                category: true
              }
            }
          }
        },
        insurance: {
          select: {
            name: true,
            code: true
          }
        },
        visit: {
          select: {
            id: true,
            visitUid: true,
            status: true
          }
        }
      },
      orderBy: { createdAt: 'asc' }
    });

    res.json({ billings });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Get emergency pending billings
exports.getEmergencyBillings = async (req, res) => {
  try {
    const billings = await prisma.billing.findMany({
      where: { status: 'EMERGENCY_PENDING' },
      include: {
        patient: {
          select: {
            id: true,
            name: true,
            type: true,
            mobile: true,
            email: true
          }
        },
        services: {
          include: {
            service: {
              select: {
                code: true,
                name: true,
                category: true
              }
            }
          }
        },
        visit: {
          select: {
            id: true,
            visitUid: true,
            status: true
          }
        }
      },
      orderBy: { createdAt: 'asc' }
    });

    res.json({ billings });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Process insurance payment
exports.processInsurancePayment = async (req, res) => {
  try {
    const { billingId, amount, notes } = req.body;

    const billing = await prisma.billing.findUnique({
      where: { id: billingId },
      include: { patient: true }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    if (billing.status !== 'PENDING_INSURANCE') {
      return res.status(400).json({ error: 'Billing is not pending insurance' });
    }

    // Update billing status
    await prisma.billing.update({
      where: { id: billingId },
      data: { status: 'INSURANCE_CLAIMED' }
    });

    // Create payment record
    await prisma.billPayment.create({
      data: {
        billingId,
        patientId: billing.patientId,
        amount,
        type: 'INSURANCE',
        notes: notes || 'Insurance payment processed'
      }
    });

    res.json({
      message: 'Insurance payment processed successfully',
      billing: {
        id: billing.id,
        status: 'INSURANCE_CLAIMED'
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Process emergency payment
exports.processEmergencyPayment = async (req, res) => {
  try {
    const { billingId, amount, type, notes } = req.body;

    const billing = await prisma.billing.findUnique({
      where: { id: billingId },
      include: { patient: true }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    if (billing.status !== 'EMERGENCY_PENDING') {
      return res.status(400).json({ error: 'Billing is not emergency pending' });
    }

    // Update billing status
    await prisma.billing.update({
      where: { id: billingId },
      data: { status: 'PAID' }
    });

    // Create payment record
    await prisma.billPayment.create({
      data: {
        billingId,
        patientId: billing.patientId,
        amount,
        type: type || 'CASH',
        notes: notes || 'Emergency payment processed'
      }
    });

    res.json({
      message: 'Emergency payment processed successfully',
      billing: {
        id: billing.id,
        status: 'PAID'
      }
    });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// Delete a visit (for billing officers to correct mistakes)
exports.deleteVisit = async (req, res) => {
  try {
    const { visitId } = req.params;
    const billingOfficerId = req.user.id;

    if (!visitId) {
      return res.status(400).json({ error: 'Visit ID is required' });
    }

    // Find the visit with all related data
    const visit = await prisma.visit.findUnique({
      where: { id: parseInt(visitId) },
      include: {
        patient: {
          select: {
            id: true,
            name: true
          }
        },
        bills: true,
        vitals: true,
        labOrders: true,
        radiologyOrders: true,
        medicationOrders: true,
        dentalRecords: true,
        dentalPhotos: true,
        attachedImages: true
      }
    });

    if (!visit) {
      return res.status(404).json({ error: 'Visit not found' });
    }

    // Allow deletion only for early stage visits (before doctor consultation, lab, radiology)
    // Once doctor sees patient or lab/radiology work is done, no deletion allowed
    const deletableStatuses = [
      'WAITING_FOR_TRIAGE',
      'TRIAGED',
      'WAITING_FOR_DOCTOR',
      'IN_DOCTOR_QUEUE'
    ];

    if (!deletableStatuses.includes(visit.status)) {
      return res.status(400).json({
        error: 'Cannot delete visit after doctor consultation or lab/radiology work has begun',
        currentStatus: visit.status,
        allowedStatuses: deletableStatuses
      });
    }

    // For early stage visits, allow deletion even with paid bills
    // The patient can create a new visit if needed
    const paidBills = visit.bills.filter(bill => bill.status === 'PAID');
    if (paidBills.length > 0) {
      console.log(`Deleting visit ${visit.id} with paid bills:`, paidBills.map(bill => ({
        id: bill.id,
        totalAmount: bill.totalAmount,
        status: bill.status
      })));
    }

    // Start a transaction to delete all related records
    await prisma.$transaction(async (tx) => {
      // Delete related records in correct order (respecting foreign key constraints)

      // 1. Delete patient attached images
      if (visit.attachedImages.length > 0) {
        await tx.patientAttachedImage.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 2. Delete dental photos
      if (visit.dentalPhotos.length > 0) {
        await tx.dentalPhoto.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 3. Delete dental records
      if (visit.dentalRecords.length > 0) {
        await tx.dentalRecord.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 4. Delete assignments (if any exist for this patient)
      const assignments = await tx.assignment.findMany({
        where: { patientId: visit.patientId }
      });
      if (assignments.length > 0) {
        await tx.assignment.deleteMany({
          where: { patientId: visit.patientId }
        });
      }

      // 5. Delete medication orders
      if (visit.medicationOrders.length > 0) {
        await tx.medicationOrder.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 6. Delete radiology orders
      if (visit.radiologyOrders.length > 0) {
        await tx.radiologyOrder.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 7. Delete lab orders
      if (visit.labOrders.length > 0) {
        await tx.labOrder.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 8. Delete vitals
      if (visit.vitals.length > 0) {
        await tx.vitalSign.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 9. Delete bills and payments
      if (visit.bills.length > 0) {
        // First delete payments for each bill
        for (const bill of visit.bills) {
          await tx.billPayment.deleteMany({
            where: { billingId: bill.id }
          });
        }

        // Then delete billing services for each bill
        for (const bill of visit.bills) {
          await tx.billingService.deleteMany({
            where: { billingId: bill.id }
          });
        }

        // Finally delete the bills
        await tx.billing.deleteMany({
          where: { visitId: parseInt(visitId) }
        });
      }

      // 10. Finally delete the visit
      await tx.visit.delete({
        where: { id: parseInt(visitId) }
      });
    });

    // Create audit log
    await prisma.auditLog.create({
      data: {
        userId: billingOfficerId,
        action: 'DELETE_VISIT',
        entity: 'Visit',
        entityId: parseInt(visitId),
        details: JSON.stringify({
          visitUid: visit.visitUid,
          patientId: visit.patientId,
          patientName: visit.patient.name,
          visitStatus: visit.status,
          deletedAt: new Date().toISOString(),
          reason: 'Billing officer deletion - visit reassignment/rescheduling needed'
        }),
        ip: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json({
      message: 'Visit deleted successfully',
      deletedVisit: {
        id: visit.id,
        visitUid: visit.visitUid,
        patientId: visit.patientId,
        patientName: visit.patient.name,
        status: visit.status
      }
    });

  } catch (error) {
    console.error('Error deleting visit:', error);
    res.status(500).json({ error: error.message });
  }
};

// Delete a billing (for billing officers to correct mistakes)
exports.deleteBilling = async (req, res) => {
  try {
    const { billingId } = req.params;
    const billingOfficerId = req.user.id;

    if (!billingId) {
      return res.status(400).json({ error: 'Billing ID is required' });
    }

    // Find the billing with all related data
    const billing = await prisma.billing.findUnique({
      where: { id: billingId },
      include: {
        patient: {
          select: {
            id: true,
            name: true
          }
        },
        visit: {
          select: {
            id: true,
            visitUid: true
          }
        },
        services: true,
        payments: true
      }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    // Only allow deletion of PENDING billings
    if (billing.status !== 'PENDING') {
      return res.status(400).json({
        error: 'Cannot delete billing that is not in PENDING status',
        currentStatus: billing.status
      });
    }

    // Use transaction to delete all related records
    await prisma.$transaction(async (tx) => {
      // Delete payments
      if (billing.payments.length > 0) {
        await tx.billPayment.deleteMany({
          where: { billingId: billingId }
        });
      }

      // Delete billing services
      if (billing.services.length > 0) {
        await tx.billingService.deleteMany({
          where: { billingId: billingId }
        });
      }

      // Update related LabTestOrders: set status to UNPAID and remove billingId
      const labTestOrdersCount = await tx.labTestOrder.count({
        where: { billingId: billingId }
      });
      if (labTestOrdersCount > 0) {
        await tx.labTestOrder.updateMany({
          where: { billingId: billingId },
          data: {
            status: 'UNPAID',
            billingId: null
          }
        });
      }

      // Update related RadiologyOrders: set status to UNPAID and remove billingId
      const radiologyOrdersCount = await tx.radiologyOrder.count({
        where: { billingId: billingId }
      });
      if (radiologyOrdersCount > 0) {
        await tx.radiologyOrder.updateMany({
          where: { billingId: billingId },
          data: {
            status: 'UNPAID',
            billingId: null
          }
        });
      }

      // Delete the billing
      await tx.billing.delete({
        where: { id: billingId }
      });
    });

    // Create audit log
    await prisma.auditLog.create({
      data: {
        userId: billingOfficerId,
        action: 'DELETE_BILLING',
        entity: 'Billing',
        entityId: 0, // Billing IDs are strings, use 0 as placeholder
        details: JSON.stringify({
          billingId: billing.id,
          patientId: billing.patientId,
          patientName: billing.patient.name,
          totalAmount: billing.totalAmount,
          status: billing.status,
          deletedAt: new Date().toISOString(),
          reason: 'Billing officer deletion - correction needed'
        }),
        ip: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json({
      message: 'Billing deleted successfully',
      deletedBilling: {
        id: billing.id,
        patientId: billing.patientId,
        patientName: billing.patient.name,
        totalAmount: billing.totalAmount
      }
    });

  } catch (error) {
    console.error('Error deleting billing:', error);
    res.status(500).json({ error: error.message });
  }
};
/**
 * Delete a specific service from a billing record
 * and sync with doctor's orders
 */
exports.deleteBillingService = async (req, res) => {
  try {
    const { billingId, serviceId } = req.params;
    const userId = req.user.id;

    console.log("🗑️ Deleting billing service: Billing " + billingId + ", Service " + serviceId);

    // 1. Find the billing and the specific service
    const billing = await prisma.billing.findUnique({
      where: { id: billingId },
      include: {
        services: {
          where: { serviceId: serviceId },
          include: { service: true }
        },
        visit: true
      }
    });

    if (!billing) {
      return res.status(404).json({ error: 'Billing not found' });
    }

    const statuses = ['PENDING', 'EMERGENCY_PENDING', 'PENDING_INSURANCE'];
    if (!statuses.includes(billing.status)) {
      return res.status(400).json({ error: 'Cannot delete services from a processed or cancelled billing' });
    }

    if (billing.services.length === 0) {
      return res.status(404).json({ error: 'Service not found in this billing' });
    }

    const billingService = billing.services[0];
    const amountToRemove = billingService.totalPrice;

    await prisma.$transaction(async (tx) => {
      // 2. Delete the billing service
      await tx.billingService.delete({
        where: {
          billingId_serviceId: {
            billingId,
            serviceId
          }
        }
      });

      // 3. Update billing total
      const updatedBilling = await tx.billing.update({
        where: { id: billingId },
        data: {
          totalAmount: {
            decrement: amountToRemove
          }
        },
        include: { services: true }
      });

      // 4. Sync with doctor's orders
      const visitId = billing.visitId;
      if (visitId) {
        console.log("🔄 Syncing with doctor's orders for visit " + visitId);

        // A. Check for Emergency Drug Orders
        await tx.emergencyDrugOrder.deleteMany({
          where: {
            visitId,
            serviceId,
            status: 'UNPAID'
          }
        });

        // B. Check for Batch Order Services (Lab, Radiology, Dental, Procedures, Nurse)
        const batchOrders = await tx.batchOrder.findMany({
          where: { visitId },
          include: { services: true }
        });

        for (const batchOrder of batchOrders) {
          const matchingService = batchOrder.services.find(s => s.serviceId === serviceId);
          if (matchingService) {
            await tx.batchOrderService.delete({
              where: { id: matchingService.id }
            });

            const remainingServices = await tx.batchOrderService.findMany({
              where: { batchOrderId: batchOrder.id }
            });

            if (remainingServices.length === 0) {
              await tx.batchOrder.delete({
                where: { id: batchOrder.id }
              });
            }
          }
        }

        // C. Check for Nurse Service Assignments
        await tx.nurseServiceAssignment.deleteMany({
          where: {
            visitId,
            serviceId,
            status: 'PENDING'
          }
        });

        // D. Check for Lab/Radiology Orders (via investigation type link)
        const investigationTypes = await tx.investigationType.findMany({
          where: { serviceId }
        });

        if (investigationTypes.length > 0) {
          const itIds = investigationTypes.map(it => it.id);

          await tx.labOrder.deleteMany({
            where: {
              visitId,
              typeId: { in: itIds },
              status: 'UNPAID'
            }
          });

          await tx.radiologyOrder.deleteMany({
            where: {
              visitId,
              typeId: { in: itIds },
              status: 'UNPAID'
            }
          });

          await tx.labTestOrder.deleteMany({
            where: {
              visitId,
              labTest: {
                investigationTypeId: { in: itIds }
              },
              status: 'UNPAID'
            }
          });
        }

        // E. Also check for LabTestOrders linked directly via LabTest.serviceId
        const labTestsWithService = await tx.labTest.findMany({
          where: { serviceId }
        });

        if (labTestsWithService.length > 0) {
          const labTestIds = labTestsWithService.map(lt => lt.id);

          await tx.labTestOrder.deleteMany({
            where: {
              visitId,
              labTestId: { in: labTestIds },
              status: 'UNPAID'
            }
          });
        }
      }

      // If billing has no more services, delete it
      if (updatedBilling.services.length === 0) {
        await tx.billing.delete({
          where: { id: billingId }
        });
      }
    });

    // 5. Create audit log
    await prisma.auditLog.create({
      data: {
        userId,
        action: 'DELETE_BILLING_SERVICE',
        entity: 'BillingService',
        entityId: 0,
        details: JSON.stringify({
          billingId,
          serviceId,
          serviceName: billingService.service.name,
          amountRemoved: amountToRemove,
          visitId: billing.visitId
        }),
        ip: req.ip,
        userAgent: req.get('User-Agent')
      }
    });

    res.json({
      success: true,
      message: "Service " + billingService.service.name + " removed from billing and synced with doctor side."
    });

  } catch (error) {
    console.error('❌ Error deleting billing service:', error);
    res.status(500).json({ error: error.message });
  }
};
