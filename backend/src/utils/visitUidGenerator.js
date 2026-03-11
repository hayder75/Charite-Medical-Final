// Note: Prisma client will be passed as parameter to avoid multiple instances

/**
 * Generate a unique visitUid with random 3-digit suffix
 * Format: VISIT-YYMMDD-RND
 *
 * Uses:
 * - Date (YYMMDD) for date-based grouping
 * - Random 3-digit suffix (001-999)
 * - Existence checks + fallback pool selection for high-concurrency safety
 * 
 * @param {Object} prisma - Prisma client instance
 * @returns {Promise<string>} A unique visitUid
 */
async function generateVisitUid(prisma) {
  const now = new Date();
  const year = now.getFullYear().toString().slice(-2); // Last 2 digits of year
  const month = (now.getMonth() + 1).toString().padStart(2, '0');
  const day = now.getDate().toString().padStart(2, '0');
  const dateStr = `${year}${month}${day}`; // YYMMDD

  const buildVisitUid = (num) => `VISIT-${dateStr}-${String(num).padStart(3, '0')}`;

  // Fast random attempts first to avoid scanning daily rows on each request.
  for (let i = 0; i < 25; i++) {
    const randomNum = Math.floor(Math.random() * 999) + 1; // 1..999
    const candidateUid = buildVisitUid(randomNum);

    const existing = await prisma.visit.findUnique({
      where: { visitUid: candidateUid },
      select: { id: true }
    });

    if (!existing) {
      return candidateUid;
    }
  }

  // Fallback: deterministically choose from the remaining suffix pool for the day.
  const existingVisits = await prisma.visit.findMany({
    where: {
      visitUid: {
        startsWith: `VISIT-${dateStr}-`
      }
    },
    select: { visitUid: true }
  });

  const usedSuffixes = new Set(
    existingVisits
      .map(v => {
        const parts = v.visitUid.split('-');
        if (parts.length !== 3 || parts[0] !== 'VISIT' || parts[1] !== dateStr) return null;
        const parsed = parseInt(parts[2], 10);
        return Number.isInteger(parsed) && parsed >= 1 && parsed <= 999 ? parsed : null;
      })
      .filter(Boolean)
  );

  const available = [];
  for (let n = 1; n <= 999; n++) {
    if (!usedSuffixes.has(n)) {
      available.push(n);
    }
  }

  if (available.length === 0) {
    throw new Error('Daily visit ID capacity exhausted for today (001-999).');
  }

  const chosen = available[Math.floor(Math.random() * available.length)];
  return buildVisitUid(chosen);
}

/**
 * Generate a unique visitUid with retry logic for database collision handling
 * This wraps the generation in retry logic in case of race conditions (multiple visits created simultaneously)
 * 
 * @param {Function} createFunction - Async function that creates the visit (should throw on P2002 error)
 * @param {Object} prisma - Prisma client instance
 * @param {number} maxRetries - Maximum number of retries (default: 10)
 * @returns {Promise<Object>} The created visit
 */
async function generateUniqueVisitUid(createFunction, prisma, maxRetries = 10) {
  let retries = 0;
  
  while (retries < maxRetries) {
    try {
      const visitUid = await generateVisitUid(prisma);
      const result = await createFunction(visitUid);
      return result;
    } catch (error) {
      // If it's a unique constraint error on visitUid, retry with a new ID
      if (error.code === 'P2002' && error.meta?.target?.includes('visitUid')) {
        retries++;
        if (retries >= maxRetries) {
          throw new Error('Unable to generate unique visit ID after multiple attempts. Please try again.');
        }
        // Wait a tiny bit before retrying (allows time for other concurrent requests to complete)
        await new Promise(resolve => setTimeout(resolve, 50)); // 50ms delay
      } else {
        // Different error - throw it immediately
        throw error;
      }
    }
  }
}

module.exports = {
  generateVisitUid,
  generateUniqueVisitUid
};


