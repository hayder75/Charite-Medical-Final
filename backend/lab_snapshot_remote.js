const prisma = require('./src/config/database');

async function main() {
  const tests = await prisma.labTest.findMany({
    where: { isActive: true, code: { in: ['URINE001', 'CBC001', 'STOOL001', 'HPA001', 'VDRL001', 'PICT001'] } },
    select: {
      code: true,
      name: true,
      resultFields: {
        select: { label: true, fieldName: true, fieldType: true, unit: true, displayOrder: true },
        orderBy: { displayOrder: 'asc' }
      }
    },
    orderBy: { code: 'asc' }
  });
  console.log(JSON.stringify(tests, null, 2));
}

main().catch((e) => {
  console.error(e);
  process.exit(1);
});
