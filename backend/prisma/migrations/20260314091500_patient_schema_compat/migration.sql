-- Idempotent compatibility migration for environments that missed demographic columns.
-- Safe to run multiple times due to IF NOT EXISTS clauses.

ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "region" TEXT;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "zone" TEXT;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "woreda" TEXT;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "kebele" TEXT;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "nationalId" TEXT;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "age" INTEGER;
ALTER TABLE "Patient" ADD COLUMN IF NOT EXISTS "cardType" "CardType" DEFAULT 'GENERAL';
