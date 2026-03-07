/*
  Warnings:

  - You are about to drop the column `duration` on the `CustomMedication` table. All the data in the column will be lost.
  - You are about to drop the column `frequency` on the `CustomMedication` table. All the data in the column will be lost.
  - You are about to drop the column `durationPeriod` on the `MedicationOrder` table. All the data in the column will be lost.
  - You are about to drop the column `frequency` on the `MedicationOrder` table. All the data in the column will be lost.
  - You are about to drop the column `frequencyPeriod` on the `MedicationOrder` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "CustomMedication" DROP COLUMN "duration",
DROP COLUMN "frequency",
ADD COLUMN     "atcCode" TEXT,
ADD COLUMN     "deletedAt" TIMESTAMP(3),
ADD COLUMN     "dosageFormCategory" TEXT,
ADD COLUMN     "durationText" TEXT,
ADD COLUMN     "durationUnit" TEXT,
ADD COLUMN     "durationValue" DOUBLE PRECISION,
ADD COLUMN     "frequencyText" TEXT,
ADD COLUMN     "frequencyType" TEXT,
ADD COLUMN     "frequencyUnit" TEXT,
ADD COLUMN     "frequencyValue" DOUBLE PRECISION,
ADD COLUMN     "isDeleted" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "normalizedName" TEXT,
ADD COLUMN     "routeCode" TEXT,
ADD COLUMN     "rxnormCode" TEXT,
ADD COLUMN     "snomedCode" TEXT,
ADD COLUMN     "strengthText" TEXT;

-- AlterTable
ALTER TABLE "MedicationOrder" DROP COLUMN "durationPeriod",
DROP COLUMN "frequency",
DROP COLUMN "frequencyPeriod",
ADD COLUMN     "atcCode" TEXT,
ADD COLUMN     "calculatedQuantity" DOUBLE PRECISION,
ADD COLUMN     "dosageFormCategory" TEXT,
ADD COLUMN     "durationText" TEXT,
ADD COLUMN     "durationUnit" TEXT,
ADD COLUMN     "durationValue" DOUBLE PRECISION,
ADD COLUMN     "finalQuantity" DOUBLE PRECISION,
ADD COLUMN     "frequencyText" TEXT,
ADD COLUMN     "frequencyType" TEXT,
ADD COLUMN     "frequencyUnit" TEXT,
ADD COLUMN     "frequencyValue" DOUBLE PRECISION,
ADD COLUMN     "normalizedName" TEXT,
ADD COLUMN     "quantityOverridden" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "routeCode" TEXT,
ADD COLUMN     "rxnormCode" TEXT,
ADD COLUMN     "snomedCode" TEXT,
ADD COLUMN     "strengthText" TEXT;

-- CreateIndex
CREATE INDEX "CustomMedication_normalizedName_idx" ON "CustomMedication"("normalizedName");
