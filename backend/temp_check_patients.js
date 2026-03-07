const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function checkPatients() {
    const patientIds = ['PAT-2026-337024-704', 'PAT-2026-24', 'PAT-2026-103', 'PAT-2026-118'];

    for (const id of patientIds) {
        console.log('--- Checking Patient:', id, '---');
        const patient = await prisma.patient.findUnique({
            where: { id },
            include: {
                visits: {
                    where: { status: { notIn: ['COMPLETED', 'CANCELLED'] } },
                    include: {
                        labOrders: true,
                        radiologyOrders: true,
                        labTestOrders: true,
                        batchOrders: {
                            include: {
                                services: true,
                                labTestOrders: true
                            }
                        }
                    }
                }
            }
        });

        if (!patient) {
            console.log('Patient not found');
            continue;
        }

        if (patient.visits.length === 0) {
            console.log('No active visits found');
            continue;
        }

        const visit = patient.visits[0];
        console.log('Visit ID:', visit.id, 'Status:', visit.status);

        console.log('Lab Orders:', visit.labOrders.map(o => ({ id: o.id, status: o.status })));
        console.log('Radiology Orders:', visit.radiologyOrders.map(o => ({ id: o.id, status: o.status })));
        console.log('Lab Test Orders:', visit.labTestOrders.map(o => ({ id: o.id, status: o.status })));
        console.log('Batch Orders:', visit.batchOrders.map(b => ({
            id: b.id,
            type: b.type,
            status: b.status,
            serviceCount: b.services.length,
            pendingServices: b.services.filter(s => ['UNPAID', 'PAID', 'QUEUED', 'IN_PROGRESS'].includes(s.status)).length
        })));
    }
}

checkPatients().catch(console.error).finally(() => prisma.$disconnect());
