const fs = require('fs');
const { PrismaClient } = require('@prisma/client');
const prisma = new PrismaClient();

async function importPatients() {
  const content = fs.readFileSync('/home/hayder/Pictures/Medical-clinic-system-new/DB backup/1-25-2026.sql', 'utf8');

  const match = content.match(/COPY public\."Patient"[^\n]*\n([\s\S]*?)\n\\\./);
  if (!match) {
    console.log('No Patient data found');
    return;
  }

  const lines = match[1].split('\n').filter(l => l.trim());
  console.log('Found', lines.length, 'patient rows');

  let inserted = 0;
  for (const line of lines.slice(0, 500)) {
    const parts = line.split('\t');
    if (parts.length < 17) continue;
    
    try {
      await prisma.patient.upsert({
        where: { id: parts[0] },
        update: {},
        create: {
          id: parts[0],
          name: parts[1] || null,
          dob: parts[2] ? new Date(parts[2]) : null,
          gender: parts[3] || null,
          type: parts[4] || 'REGULAR',
          mobile: parts[5] || null,
          email: parts[6] !== '\\N' ? parts[6] : null,
          address: parts[7] !== '\\N' ? parts[7] : null,
          emergencyContact: parts[8] !== '\\N' ? parts[8] : null,
          bloodType: parts[9] !== '\\N' ? parts[9] : null,
          maritalStatus: parts[10] || null,
          status: parts[11] || 'Active',
          insuranceId: parts[12] !== '\\N' ? parts[12] : null,
          cardStatus: parts[13] || 'INACTIVE',
          cardActivatedAt: parts[14] ? new Date(parts[14]) : null,
          cardExpiryDate: parts[15] ? new Date(parts[15]) : null,
          createdAt: parts[16] ? new Date(parts[16]) : new Date(),
          updatedAt: parts[17] ? new Date(parts[17]) : new Date()
        }
      });
      inserted++;
    } catch (e) {
      // skip duplicates/errors
    }
  }

  console.log('Inserted', inserted, 'patients');
  await prisma.$disconnect();
}

importPatients();
