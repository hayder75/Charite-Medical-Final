/*
  Warnings:

  - You are about to drop the column `specialties` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[visitId]` on the table `MedicalHistory` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "DiagnosisType" AS ENUM ('CLINICAL', 'CONFIRMED', 'SUSPECTED');

-- CreateEnum
CREATE TYPE "DiagnosisStatus" AS ENUM ('ACTIVE', 'RESOLVED', 'RULED_OUT');

-- CreateEnum
CREATE TYPE "BedStatus" AS ENUM ('AVAILABLE', 'OCCUPIED', 'MAINTENANCE', 'CLEANING');

-- CreateEnum
CREATE TYPE "AdmissionStatus" AS ENUM ('PENDING_PAYMENT', 'ADMITTED', 'DISCHARGED', 'CANCELLED');

-- AlterEnum
ALTER TYPE "AccountTransactionType" ADD VALUE 'DEBT';

-- AlterEnum
ALTER TYPE "AccountType" ADD VALUE 'BOTH';

-- AlterEnum
ALTER TYPE "BillingStatus" ADD VALUE 'PARTIALLY_PAID';

-- AlterEnum
ALTER TYPE "BillingType" ADD VALUE 'ACCOMMODATION';

-- AlterEnum
ALTER TYPE "ImageType" ADD VALUE 'OTHER';

-- AlterEnum
ALTER TYPE "NurseServiceStatus" ADD VALUE 'DEFERRED';

-- AlterEnum
ALTER TYPE "OrderStatus" ADD VALUE 'DEFERRED';

-- AlterEnum
ALTER TYPE "PaymentType" ADD VALUE 'CREDIT';

-- AlterEnum
-- This migration adds more than one value to an enum.
-- With PostgreSQL versions 11 and earlier, this is not possible
-- in a single migration. This can be worked around by creating
-- multiple migrations, each migration adding only one value to
-- the enum.


ALTER TYPE "ServiceCategory" ADD VALUE 'DOCTOR_WALKIN';
ALTER TYPE "ServiceCategory" ADD VALUE 'ACCOMMODATION';

-- DropIndex
DROP INDEX "MedicalHistory_visitId_idx";

-- AlterTable
ALTER TABLE "AccountTransaction" ADD COLUMN     "subAccount" TEXT;

-- AlterTable
ALTER TABLE "BatchOrder" ADD COLUMN     "isDeferred" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "BatchOrderService" ADD COLUMN     "customPrice" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "Billing" ADD COLUMN     "discount" DOUBLE PRECISION NOT NULL DEFAULT 0,
ADD COLUMN     "isDeferred" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "paidAmount" DOUBLE PRECISION NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "MedicalCertificate" ADD COLUMN     "appointmentDate" TIMESTAMP(3),
ALTER COLUMN "restStartDate" DROP NOT NULL,
ALTER COLUMN "restEndDate" DROP NOT NULL,
ALTER COLUMN "totalDays" DROP NOT NULL;

-- AlterTable
ALTER TABLE "MedicationOrder" ADD COLUMN     "isDeferred" BOOLEAN NOT NULL DEFAULT false;

-- AlterTable
ALTER TABLE "NurseServiceAssignment" ADD COLUMN     "customPrice" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "PatientAccount" ADD COLUMN     "creditLimit" DOUBLE PRECISION NOT NULL DEFAULT 0;

-- AlterTable
ALTER TABLE "Service" ADD COLUMN     "isVariablePrice" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "maxPrice" DOUBLE PRECISION,
ADD COLUMN     "minPrice" DOUBLE PRECISION;

-- AlterTable
ALTER TABLE "User" DROP COLUMN "specialties",
ADD COLUMN     "qualifications" TEXT[];

-- AlterTable
ALTER TABLE "Visit" ADD COLUMN     "outcome" TEXT;

-- CreateTable
CREATE TABLE "DoctorWalkInOrder" (
    "id" SERIAL NOT NULL,
    "patientId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "doctorId" TEXT,
    "instructions" TEXT,
    "notes" TEXT,
    "status" "OrderStatus" NOT NULL DEFAULT 'UNPAID',
    "billingId" TEXT,
    "completedAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "visitId" INTEGER,

    CONSTRAINT "DoctorWalkInOrder_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Disease" (
    "id" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "category" TEXT,
    "isReportable" BOOLEAN NOT NULL DEFAULT false,
    "reportFrequency" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Disease_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "PatientDiagnosis" (
    "id" TEXT NOT NULL,
    "visitId" INTEGER NOT NULL,
    "patientId" TEXT NOT NULL,
    "doctorId" TEXT NOT NULL,
    "diseaseId" TEXT NOT NULL,
    "type" "DiagnosisType" NOT NULL DEFAULT 'CLINICAL',
    "status" "DiagnosisStatus" NOT NULL DEFAULT 'ACTIVE',
    "isPrimary" BOOLEAN NOT NULL DEFAULT true,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PatientDiagnosis_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Bed" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "code" TEXT NOT NULL,
    "price" DOUBLE PRECISION NOT NULL,
    "type" TEXT,
    "status" "BedStatus" NOT NULL DEFAULT 'AVAILABLE',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Bed_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Admission" (
    "id" TEXT NOT NULL,
    "patientId" TEXT NOT NULL,
    "bedId" TEXT NOT NULL,
    "visitId" INTEGER,
    "admittedById" TEXT NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expectedEndDate" TIMESTAMP(3) NOT NULL,
    "actualEndDate" TIMESTAMP(3),
    "status" "AdmissionStatus" NOT NULL DEFAULT 'ADMITTED',
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "billingId" TEXT,

    CONSTRAINT "Admission_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AdmissionService" (
    "id" TEXT NOT NULL,
    "admissionId" TEXT NOT NULL,
    "serviceId" TEXT NOT NULL,
    "orderedById" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unitPrice" DOUBLE PRECISION NOT NULL,
    "totalPrice" DOUBLE PRECISION NOT NULL,
    "status" TEXT NOT NULL DEFAULT 'PENDING',
    "billingId" TEXT,
    "notes" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "AdmissionService_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_patientId_idx" ON "DoctorWalkInOrder"("patientId");

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_serviceId_idx" ON "DoctorWalkInOrder"("serviceId");

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_doctorId_idx" ON "DoctorWalkInOrder"("doctorId");

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_status_idx" ON "DoctorWalkInOrder"("status");

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_billingId_idx" ON "DoctorWalkInOrder"("billingId");

-- CreateIndex
CREATE INDEX "DoctorWalkInOrder_createdAt_idx" ON "DoctorWalkInOrder"("createdAt");

-- CreateIndex
CREATE UNIQUE INDEX "Disease_code_key" ON "Disease"("code");

-- CreateIndex
CREATE INDEX "PatientDiagnosis_visitId_idx" ON "PatientDiagnosis"("visitId");

-- CreateIndex
CREATE INDEX "PatientDiagnosis_patientId_idx" ON "PatientDiagnosis"("patientId");

-- CreateIndex
CREATE INDEX "PatientDiagnosis_diseaseId_idx" ON "PatientDiagnosis"("diseaseId");

-- CreateIndex
CREATE UNIQUE INDEX "Bed_name_key" ON "Bed"("name");

-- CreateIndex
CREATE UNIQUE INDEX "Bed_code_key" ON "Bed"("code");

-- CreateIndex
CREATE INDEX "AccountTransaction_subAccount_idx" ON "AccountTransaction"("subAccount");

-- CreateIndex
CREATE UNIQUE INDEX "MedicalHistory_visitId_key" ON "MedicalHistory"("visitId");

-- AddForeignKey
ALTER TABLE "DoctorWalkInOrder" ADD CONSTRAINT "DoctorWalkInOrder_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoctorWalkInOrder" ADD CONSTRAINT "DoctorWalkInOrder_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoctorWalkInOrder" ADD CONSTRAINT "DoctorWalkInOrder_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "DoctorWalkInOrder" ADD CONSTRAINT "DoctorWalkInOrder_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientDiagnosis" ADD CONSTRAINT "PatientDiagnosis_visitId_fkey" FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientDiagnosis" ADD CONSTRAINT "PatientDiagnosis_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientDiagnosis" ADD CONSTRAINT "PatientDiagnosis_doctorId_fkey" FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PatientDiagnosis" ADD CONSTRAINT "PatientDiagnosis_diseaseId_fkey" FOREIGN KEY ("diseaseId") REFERENCES "Disease"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_patientId_fkey" FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_bedId_fkey" FOREIGN KEY ("bedId") REFERENCES "Bed"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Admission" ADD CONSTRAINT "Admission_admittedById_fkey" FOREIGN KEY ("admittedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdmissionService" ADD CONSTRAINT "AdmissionService_admissionId_fkey" FOREIGN KEY ("admissionId") REFERENCES "Admission"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdmissionService" ADD CONSTRAINT "AdmissionService_serviceId_fkey" FOREIGN KEY ("serviceId") REFERENCES "Service"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "AdmissionService" ADD CONSTRAINT "AdmissionService_orderedById_fkey" FOREIGN KEY ("orderedById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
