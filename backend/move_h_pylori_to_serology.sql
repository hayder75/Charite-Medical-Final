-- Move H. pylori Antigen (Stool Test) to Serology
-- and align its result-field template with H. pylori Antibody (Serology)

BEGIN;

-- 1) Move antigen category from Microbiology/Standalone path to Serology
UPDATE "LabTest"
SET category = 'Serology',
        "updatedAt" = NOW()
WHERE code = 'HPYLORIAG001';

-- 2) Rebuild antigen fields from antibody fields so technicians get the same form structure
WITH antibody AS (
    SELECT id, "groupId"
    FROM "LabTest"
    WHERE code = 'HPYLORIAB001'
    LIMIT 1
),
antigen AS (
    SELECT id
    FROM "LabTest"
    WHERE code = 'HPYLORIAG001'
    LIMIT 1
)
UPDATE "LabTest" a
SET "groupId" = ab."groupId",
        "updatedAt" = NOW()
FROM antibody ab
WHERE a.id = (SELECT id FROM antigen);

DELETE FROM "LabTestResultField"
WHERE "testId" = (SELECT id FROM "LabTest" WHERE code = 'HPYLORIAG001' LIMIT 1);

INSERT INTO "LabTestResultField" (
    id,
    "testId",
    "fieldName",
    label,
    "fieldType",
    unit,
    "normalRange",
    options,
    "isRequired",
    "displayOrder",
    "createdAt",
    "updatedAt"
)
SELECT
    gen_random_uuid(),
    antigen.id,
    f."fieldName",
    f.label,
    f."fieldType",
    f.unit,
    f."normalRange",
    f.options,
    f."isRequired",
    f."displayOrder",
    NOW(),
    NOW()
FROM "LabTestResultField" f
CROSS JOIN (SELECT id FROM "LabTest" WHERE code = 'HPYLORIAG001' LIMIT 1) antigen
WHERE f."testId" = (SELECT id FROM "LabTest" WHERE code = 'HPYLORIAB001' LIMIT 1)
ORDER BY f."displayOrder" ASC;

COMMIT;

-- Verification
SELECT code, name, category, "groupId"
FROM "LabTest"
WHERE code IN ('HPYLORIAG001', 'HPYLORIAB001');

SELECT t.code, f."fieldName", f.label, f."fieldType", f."displayOrder"
FROM "LabTestResultField" f
JOIN "LabTest" t ON t.id = f."testId"
WHERE t.code IN ('HPYLORIAG001', 'HPYLORIAB001')
ORDER BY t.code, f."displayOrder";
