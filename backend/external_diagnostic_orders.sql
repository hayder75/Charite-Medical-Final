DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_type WHERE typname = 'ExternalDiagnosticOrderType') THEN
    CREATE TYPE "ExternalDiagnosticOrderType" AS ENUM ('LAB', 'RADIOLOGY');
  END IF;
END $$;

CREATE TABLE IF NOT EXISTS "ExternalDiagnosticOrder" (
  "id" SERIAL NOT NULL,
  "visitId" INTEGER NOT NULL,
  "patientId" TEXT NOT NULL,
  "doctorId" TEXT NOT NULL,
  "requestedByName" TEXT NOT NULL,
  "type" "ExternalDiagnosticOrderType" NOT NULL,
  "examinations" TEXT[] NOT NULL,
  "relevantClinicalData" TEXT,
  "diagnosis" TEXT,
  "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  "updatedAt" TIMESTAMP(3) NOT NULL,
  CONSTRAINT "ExternalDiagnosticOrder_pkey" PRIMARY KEY ("id")
);

CREATE INDEX IF NOT EXISTS "ExternalDiagnosticOrder_visitId_type_createdAt_idx" ON "ExternalDiagnosticOrder"("visitId", "type", "createdAt");
CREATE INDEX IF NOT EXISTS "ExternalDiagnosticOrder_patientId_type_idx" ON "ExternalDiagnosticOrder"("patientId", "type");
CREATE INDEX IF NOT EXISTS "ExternalDiagnosticOrder_doctorId_createdAt_idx" ON "ExternalDiagnosticOrder"("doctorId", "createdAt");

DO $$
BEGIN
  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ExternalDiagnosticOrder_visitId_fkey') THEN
    ALTER TABLE "ExternalDiagnosticOrder"
      ADD CONSTRAINT "ExternalDiagnosticOrder_visitId_fkey"
      FOREIGN KEY ("visitId") REFERENCES "Visit"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ExternalDiagnosticOrder_patientId_fkey') THEN
    ALTER TABLE "ExternalDiagnosticOrder"
      ADD CONSTRAINT "ExternalDiagnosticOrder_patientId_fkey"
      FOREIGN KEY ("patientId") REFERENCES "Patient"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
  END IF;

  IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'ExternalDiagnosticOrder_doctorId_fkey') THEN
    ALTER TABLE "ExternalDiagnosticOrder"
      ADD CONSTRAINT "ExternalDiagnosticOrder_doctorId_fkey"
      FOREIGN KEY ("doctorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
  END IF;
END $$;
