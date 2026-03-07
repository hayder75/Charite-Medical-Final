const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function main() {
    const images = await prisma.patientGallery.findMany({
        take: 5,
        orderBy: { createdAt: 'desc' }
    });
    console.log('Gallery Images:', JSON.stringify(images, null, 2));

    const attached = await prisma.patientAttachedImage.findMany({
        take: 5,
        orderBy: { uploadedAt: 'desc' }
    });
    console.log('Attached Images:', JSON.stringify(attached, null, 2));
}

main()
    .catch(e => console.error(e))
    .finally(() => prisma.$disconnect());
