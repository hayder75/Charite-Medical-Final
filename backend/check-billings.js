const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function check() {
    try {
        // Get all billings to check for invalid dates
        const billings = await prisma.billing.findMany({
            where: {
                NOT: {
                    billingType: 'EMERGENCY'
                }
            },
            select: {
                id: true,
                createdAt: true,
                totalAmount: true
            },
            orderBy: { createdAt: 'desc' }
        });

        console.log('Total billings:', billings.length);

        // Check for invalid dates or amounts
        let invalidDates = [];
        let invalidAmounts = [];

        for (const billing of billings) {
            const date = new Date(billing.createdAt);
            if (isNaN(date.getTime())) {
                invalidDates.push({ id: billing.id, createdAt: billing.createdAt });
            }

            if (billing.totalAmount === null || billing.totalAmount === undefined || isNaN(billing.totalAmount)) {
                invalidAmounts.push({ id: billing.id, totalAmount: billing.totalAmount });
            }
        }

        console.log('Invalid dates:', invalidDates.length);
        console.log('Invalid amounts:', invalidAmounts.length);

        if (invalidDates.length > 0) {
            console.log('Sample invalid dates:', invalidDates.slice(0, 5));
        }

        if (invalidAmounts.length > 0) {
            console.log('Sample invalid amounts:', invalidAmounts.slice(0, 5));
        }

        // Verify toLocaleString doesn't crash
        for (const billing of billings.slice(0, 10)) {
            try {
                const dateStr = new Date(billing.createdAt).toLocaleString();
                const amountStr = billing.totalAmount.toLocaleString();
            } catch (e) {
                console.log('Error on billing', billing.id, ':', e.message);
            }
        }

        console.log('Data validation complete');

    } catch (e) {
        console.error('Error:', e);
    } finally {
        await prisma.$disconnect();
    }
}

check();
