-- AlterEnum
ALTER TYPE "BatchOrderType" ADD VALUE 'PROCEDURE';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "VisitStatus" ADD VALUE 'PROCEDURE_SERVICES_ORDERED';
ALTER TYPE "VisitStatus" ADD VALUE 'PROCEDURE_SERVICES_COMPLETED';

-- AlterTable
ALTER TABLE "MedicationOrder" ADD COLUMN     "durationPeriod" TEXT,
ADD COLUMN     "frequencyPeriod" TEXT,
ADD COLUMN     "route" TEXT,
ALTER COLUMN "quantity" DROP NOT NULL;

-- AlterTable
ALTER TABLE "Patient" ADD COLUMN     "kebele" TEXT,
ADD COLUMN     "region" TEXT,
ADD COLUMN     "woreda" TEXT,
ADD COLUMN     "zone" TEXT;

-- CreateTable
CREATE TABLE "NurseWalkInOrder" (
    "id" SERIAL NOT NULL,
    "patientId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "nurseId" TEXT,
    "instructions" TEXT,
    "notes" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "billingId" TEXT,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "visitId" INTEGER,

    CONSTRAINT "NurseWalkInOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "EmergencyDrugOrder" (
    "id" SERIAL NOT NULL,
    "visitId" INTEGER,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT,
    "serviceId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "instructions" TEXT,
    "notes" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "billingId" TEXT,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "dosageForm" TEXT,
    "duration" TEXT,
    "durationPeriod" TEXT,
    "frequency" TEXT,
    "frequencyPeriod" TEXT,
    "route" TEXT,
    "strength" TEXT,

    CONSTRAINT "EmergencyDrugOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "MaterialNeedsOrder" (
    "id" SERIAL NOT NULL,
    "visitId" INTEGER,
    "patientId" TEXT NOT NULL,
    "nurseId" TEXT,
    "serviceId" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "instructions" TEXT,
    "notes" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "billingId" TEXT,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "MaterialNeedsOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTestGroup" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT NOT NULL,
    "description" TEXT,
    "displayOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,

    CONSTRAINT "LabTestGroup_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTest" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT,
    "category" TEXT NOT NULL,
    "description" TEXT,
    "price" DOUBLE PRECISION NOT NULL,
    "unit" TEXT DEFAULT 'UNIT',
    "groupId" TEXT,
    "displayOrder" INTEGER NOT NULL DEFAULT 0,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "createdBy" TEXT,
    "updatedBy" TEXT,
    "serviceId" TEXT,

    CONSTRAINT "LabTest_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTestResultField" (
    "id" TEXT NOT NULL,
    "testId" TEXT NOT NULL,
    "fieldName" TEXT NOT NULL,
    "label" TEXT NOT NULL,
    "fieldType" TEXT NOT NULL,
    "unit" TEXT,
    "normalRange" TEXT,
    "options" JSONB,
    "isRequired" BOOLEAN NOT NULL DEFAULT false,
    "displayOrder" INTEGER NOT NULL DEFAULT 0,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LabTestResultField_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTestOrder" (
    "id" TEXT NOT NULL,
    "labTestId" TEXT NOT NULL,
    "batchOrderId" INTEGER,
    "visitId" INTEGER,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT,
    "instructions" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "isWalkIn" BOOLEAN NOT NULL DEFAULT false,
    "billingId" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LabTestOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTestResult" (
    "id" TEXT NOT NULL,
    "orderId" TEXT NOT NULL,
    "testId" TEXT NOT NULL,
    "results" JSONB NOT NULL,
    "additionalNotes" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "verifiedBy" TEXT,
    "verifiedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "LabTestResult_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "LabTestResultFile" (
    "id" TEXT NOT NULL,
    "resultId" TEXT NOT NULL,
    "fileUrl" TEXT NOT NULL,
    "fileName" TEXT,
    "fileType" TEXT,
    "uploadedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "uploadedBy" TEXT,

    CONSTRAINT "LabTestResultFile_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "CustomMedication" (
    "id" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "genericName" TEXT,
    "dosageForm" TEXT NOT NULL,
    "strength" TEXT NOT NULL,
    "quantity" TEXT,
    "frequency" TEXT,
    "duration" TEXT,
    "route" TEXT,
    "instructions" TEXT,
    "frequencyPeriod" TEXT,
    "durationPeriod" TEXT,
    "category" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "CustomMedication_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Referral" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "visitId" INTEGER,
    "referralReason" TEXT NOT NULL,
    "diagnosis" TEXT NOT NULL,
    "facilityName" TEXT NOT NULL,
    "doctorDetails" TEXT NOT NULL,
    "urgency" TEXT NOT NULL DEFAULT 'NORMAL',
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "clinicalHistory" TEXT,
    "physicalExam" TEXT,
    "labInvestigation" TEXT,
    "imaging" TEXT,
    "treatmentGiven" TEXT,
    "region" TEXT,
    "zone" TEXT,
    "woreda" TEXT,
    "kebele" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Referral_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "InternationalMedicalCertificate" (
    "id" TEXT NOT NULL,
    "certificateNo" TEXT NOT NULL,
    "certificateDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "visitId" INTEGER,
    "passportNo" TEXT,
    "hasPreviousDisease" BOOLEAN NOT NULL DEFAULT false,
    "previousDiseaseDetails" TEXT,
    "hasCurrentMedicalComplains" BOOLEAN NOT NULL DEFAULT false,
    "currentMedicalComplainsDetails" TEXT,
    "height" TEXT,
    "weight" TEXT,
    "bp" TEXT,
    "bloodGroup" TEXT,
    "heent" TEXT DEFAULT 'Normal',
    "chest" TEXT DEFAULT 'Normal',
    "cvs" TEXT DEFAULT 'Normal',
    "abdomen" TEXT DEFAULT 'Normal',
    "cns" TEXT DEFAULT 'Normal',
    "chestXRay" TEXT DEFAULT 'Normal',
    "hiv" TEXT DEFAULT 'Negative',
    "hbsag" TEXT DEFAULT 'Negative',
    "vdrl" TEXT DEFAULT 'Negative',
    "hcv" TEXT DEFAULT 'Negative',
    "hcg" TEXT DEFAULT 'Negative',
    "fbsRbs" TEXT DEFAULT 'Negative',
    "finalAssessment" TEXT DEFAULT 'FIT',
    "directoryName" TEXT,
    "status" "CertificateStatus" NOT NULL DEFAULT 'ACTIVE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "InternationalMedicalCertificate_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_patientId_idx" ON "NurseWalkInOrder"("patientId");

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_serviceId_idx" ON "NurseWalkInOrder"("serviceId");

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_nurseId_idx" ON "NurseWalkInOrder"("nurseId");

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_status_idx" ON "NurseWalkInOrder"("status");

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_billingId_idx" ON "NurseWalkInOrder"("billingId");

-- CreateIndex
CREATE INDEX "NurseWalkInOrder_createdAt_idx" ON "NurseWalkInOrder"("createdAt");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_patientId_idx" ON "EmergencyDrugOrder"("patientId");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_visitId_idx" ON "EmergencyDrugOrder"("visitId");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_serviceId_idx" ON "EmergencyDrugOrder"("serviceId");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_doctorId_idx" ON "EmergencyDrugOrder"("doctorId");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_status_idx" ON "EmergencyDrugOrder"("status");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_billingId_idx" ON "EmergencyDrugOrder"("billingId");

-- CreateIndex
CREATE INDEX "EmergencyDrugOrder_createdAt_idx" ON "EmergencyDrugOrder"("createdAt");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_patientId_idx" ON "MaterialNeedsOrder"("patientId");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_visitId_idx" ON "MaterialNeedsOrder"("visitId");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_serviceId_idx" ON "MaterialNeedsOrder"("serviceId");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_nurseId_idx" ON "MaterialNeedsOrder"("nurseId");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_status_idx" ON "MaterialNeedsOrder"("status");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_billingId_idx" ON "MaterialNeedsOrder"("billingId");

-- CreateIndex
CREATE INDEX "MaterialNeedsOrder_createdAt_idx" ON "MaterialNeedsOrder"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "LabTest_code_key" ON "LabTest"("code");

-- CreateIndex
CREATE INDEX "LabTest_category_idx" ON "LabTest"("category");

-- CreateIndex
CREATE INDEX "LabTest_groupId_idx" ON "LabTest"("groupId");

-- CreateIndex
CREATE INDEX "LabTest_isActive_idx" ON "LabTest"("isActive");

-- CreateIndex
CREATE INDEX "LabTestResultField_testId_idx" ON "LabTestResultField"("testId");

-- CreateIndex
CREATE INDEX "LabTestOrder_labTestId_idx" ON "LabTestOrder"("labTestId");

-- CreateIndex
CREATE INDEX "LabTestOrder_batchOrderId_idx" ON "LabTestOrder"("batchOrderId");

-- CreateIndex
CREATE INDEX "LabTestOrder_visitId_idx" ON "LabTestOrder"("visitId");

-- CreateIndex
CREATE INDEX "LabTestOrder_patientId_idx" ON "LabTestOrder"("patientId");

-- CreateIndex
CREATE INDEX "LabTestOrder_status_idx" ON "LabTestOrder"("status");

-- CreateIndex
CREATE INDEX "LabTestResult_testId_idx" ON "LabTestResult"("testId");

-- CreateIndex
CREATE INDEX "LabTestResult_status_idx" ON "LabTestResult"("status");

-- CreateIndex
CREATE UNIQUE INDEX "LabTestResult_orderId_testId_key" ON "LabTestResult"("orderId", "testId");

-- CreateIndex
CREATE INDEX "CustomMedication_doctorId_idx" ON "CustomMedication"("doctorId");

-- CreateIndex
CREATE INDEX "CustomMedication_name_idx" ON "CustomMedication"("name");

-- CreateIndex
CREATE UNIQUE INDEX "CustomMedication_doctorId_name_strength_key" ON "CustomMedication"("doctorId", "name", "strength");

-- CreateIndex
CREATE UNIQUE INDEX "InternationalMedicalCertificate_certificateNo_key" ON "InternationalMedicalCertificate"("certificateNo");

-- CreateIndex
CREATE INDEX "InternationalMedicalCertificate_patientId_idx" ON "InternationalMedicalCertificate"("patientId");

-- CreateIndex
CREATE INDEX "InternationalMedicalCertificate_doctorId_idx" ON "InternationalMedicalCertificate"("doctorId");

-- AddForeignKey
ALTER TABLE "NurseWalkInOrder" ADD CONSTRAINT "NurseWalkInOrder_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NurseWalkInOrder" ADD CONSTRAINT "NurseWalkInOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NurseWalkInOrder" ADD CONSTRAINT "NurseWalkInOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "NurseWalkInOrder" ADD CONSTRAINT "NurseWalkInOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmergencyDrugOrder" ADD CONSTRAINT "EmergencyDrugOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmergencyDrugOrder" ADD CONSTRAINT "EmergencyDrugOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmergencyDrugOrder" ADD CONSTRAINT "EmergencyDrugOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "EmergencyDrugOrder" ADD CONSTRAINT "EmergencyDrugOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialNeedsOrder" ADD CONSTRAINT "MaterialNeedsOrder_nurseId_fkey" FOREIGN KEY ("nurseId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialNeedsOrder" ADD CONSTRAINT "MaterialNeedsOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialNeedsOrder" ADD CONSTRAINT "MaterialNeedsOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "MaterialNeedsOrder" ADD CONSTRAINT "MaterialNeedsOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_groupId_fkey" FOREIGN KEY ("groupId") REFERENCES "LabTestGroup"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTest" ADD CONSTRAINT "LabTest_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestResultField" ADD CONSTRAINT "LabTestResultField_testId_fkey" FOREIGN KEY ("testId") REFERENCES "LabTest"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestOrder" ADD CONSTRAINT "LabTestOrder_batchOrderId_fkey" FOREIGN KEY ("batchOrderId") REFERENCES "BatchOrder"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestOrder" ADD CONSTRAINT "LabTestOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestOrder" ADD CONSTRAINT "LabTestOrder_labTestId_fkey" FOREIGN KEY ("labTestId") REFERENCES "LabTest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestOrder" ADD CONSTRAINT "LabTestOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestOrder" ADD CONSTRAINT "LabTestOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestResult" ADD CONSTRAINT "LabTestResult_orderId_fkey" FOREIGN KEY ("orderId") REFERENCES "LabTestOrder"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestResult" ADD CONSTRAINT "LabTestResult_testId_fkey" FOREIGN KEY ("testId") REFERENCES "LabTest"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "LabTestResultFile" ADD CONSTRAINT "LabTestResultFile_resultId_fkey" FOREIGN KEY ("resultId") REFERENCES "LabTestResult"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "CustomMedication" ADD CONSTRAINT "CustomMedication_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Referral" ADD CONSTRAINT "Referral_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Referral" ADD CONSTRAINT "Referral_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Referral" ADD CONSTRAINT "Referral_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InternationalMedicalCertificate" ADD CONSTRAINT "InternationalMedicalCertificate_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InternationalMedicalCertificate" ADD CONSTRAINT "InternationalMedicalCertificate_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "InternationalMedicalCertificate" ADD CONSTRAINT "InternationalMedicalCertificate_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;
