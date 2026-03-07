const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function recovery() {
    const patientIds = [
        'PAT-2026-337024-704',
        'PAT-2026-24',
        'PAT-2026-103',
        'PAT-2026-118'
    ];

    const visits = await prisma.visit.findMany({
        where: {
            patientId: { in: patientIds },
            status: { notIn: ['COMPLETED', 'CANCELLED'] }
        }
    });

    console.log(`Found ${visits.length} active visits to nudge.`);

    for (const visit of visits) {
        // Force move to AWAITING_RESULTS_REVIEW so they appear in Results table
        // and have the Complete button enabled.
        await prisma.visit.update({
            where: { id: visit.id },
            data: {
                status: 'AWAITING_RESULTS_REVIEW',
                queueType: 'RESULTS_REVIEW'
            }
        });

        // Also mark any empty BatchOrders as COMPLETED to clean up the UI
        await prisma.batchOrder.updateMany({
            where: {
                visitId: visit.id,
                status: 'UNPAID',
                services: { none: {} }
            },
            data: { status: 'COMPLETED' }
        });

        console.log(`✅ Visit ID ${visit.id} (Patient ${visit.patientId}) moved to AWAITING_RESULTS_REVIEW`);
    }
}

recovery()
    .then(() => console.log('Recovery completed successfully.'))
    .catch(console.error)
    .finally(() => prisma.$disconnect());
