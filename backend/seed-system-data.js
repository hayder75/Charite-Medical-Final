const { PrismaClient } = require('@prisma/client');
const bcrypt = require('bcryptjs');
const prisma = new PrismaClient();

async function main() {
  console.log('🌱 Seeding database with system data...\n');

  // Create admin user
  console.log('👤 Creating admin user...');
  const hashedPassword = await bcrypt.hash('admin123', 10);
  const admin = await prisma.user.upsert({
    where: { username: 'admin' },
    update: {},
    create: {
      id: 'a9e63cbf-3913-419b-8f4c-8e06fc10a306',
      fullname: 'System Administrator',
      username: 'admin',
      password: hashedPassword,
      email: 'admin@clinic.com',
      role: 'ADMIN',
      isActive: true,
      availability: true,
    },
  });
  console.log('✅ Admin user created: username=admin, password=admin123\n');

  // Create essential services
  console.log('🏥 Creating essential services...');
  const services = [
    { id: '98367a2c-42e1-49d5-8a1d-5c5743d319f1', code: 'CONS001', name: 'General Doctor Consultation', category: 'CONSULTATION', price: 200 },
    { id: '5a981cc6-dee9-4b85-b791-f0e3126d9ff8', code: 'CONS002', name: 'Specialist Consultation', category: 'CONSULTATION', price: 200 },
    { id: '0a5a276d-e8a7-4ac1-a235-2b1b1192250f', code: 'CARD-REG', name: 'Patient Card Registration', category: 'CONSULTATION', price: 100 },
    { id: '5b8b1955-b161-4217-993b-c9b5cf4266db', code: 'CARD-ACT', name: 'Patient Card Activation', category: 'CONSULTATION', price: 100 },
    { id: '22eedf04-fddd-4023-a109-114495c9e1e9', code: 'ESR001', name: 'ESR', category: 'LAB', price: 125 },
    { id: '3566536f-f272-4574-a8ab-513df7f9e597', code: 'CBC001', name: 'Complete Blood Count (CBC)', category: 'LAB', price: 400 },
    { id: '66f5dc69-e9c2-4c46-9e20-ebeb319a629d', code: 'BGRH001', name: 'Blood Group & Rh', category: 'LAB', price: 150 },
    { id: '5b08e652-9ad2-4fb4-bee9-be6cca21d6df', code: 'URINE001', name: 'Urinalysis', category: 'LAB', price: 100 },
    { id: '95abafe1-60f8-47a0-8f8d-837c6a24158c', code: 'STOOL001', name: 'Stool Examination', category: 'LAB', price: 100 },
    { id: '907e9fd6-af1d-477e-a8a3-2ebc17a45e53', code: 'US001', name: 'Abdominal Ultrasound', category: 'RADIOLOGY', price: 400 },
    { id: '7e1929db-ce87-4893-a5d7-7436921f7961', code: 'US002', name: 'Pelvic Ultrasound', category: 'RADIOLOGY', price: 380 },
    { id: '6fe4b74f-36ed-4f8f-b28c-9e045e07acda', code: 'US003', name: 'Obstetric Ultrasound', category: 'RADIOLOGY', price: 420 },
  ];

  for (const svc of services) {
    await prisma.service.upsert({
      where: { code: svc.code },
      update: {},
      create: svc,
    });
  }
  console.log(`✅ Created ${services.length} services\n`);

  // Create system settings
  console.log('⚙️ Creating system settings...');
  await prisma.systemSettings.upsert({
    where: { key: 'cardExpiryPeriodDays' },
    update: {},
    create: {
      id: '2c8dd2a2-17cd-4ea9-9228-ecf83f0f1950',
      key: 'cardExpiryPeriodDays',
      value: '15',
      description: 'Number of days before a card expires after activation',
      updatedById: admin.id,
    },
  });
  console.log('✅ System settings created\n');

  console.log('🎉 Database seeding complete!');
  console.log('   Login with: username=admin, password=admin123');
}

main()
  .catch((e) => {
    console.error('❌ Error:', e);
    process.exit(1);
  })
  .finally(async () => await prisma.$disconnect());
