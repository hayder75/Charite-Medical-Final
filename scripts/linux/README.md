# Linux Migration Scripts

These scripts are Linux-only and do not modify any Windows `.bat` runners.

## 1) Create a fresh full SQL backup

From project root:

```bash
./scripts/linux/refresh-db-backup.sh
```

What it does:
- Reads `DATABASE_URL` from `backend/.env`
- Removes old `*.sql` files inside `DB backup/`
- Creates a brand-new full SQL dump
- Updates `DB backup/medical_clinic_full_latest.sql`

## 2) Initialize a new Linux server end-to-end

From project root on the new server:

```bash
./scripts/linux/setup-new-server.sh
```

Optional: provide a specific dump file path:

```bash
./scripts/linux/setup-new-server.sh "DB backup/medical_clinic_full_latest.sql"
```

What it does:
- Installs Linux packages (`postgresql`, `nodejs`, `npm`, etc.) when `apt-get` is available
- Reads DB settings from `backend/.env`
- Creates the database if it does not exist
- Restores full SQL dump if present (or runs Prisma migrate + `npm run seed:all` if no dump)
- Auto-detects free ports while excluding `3000` and `5000`
- Writes backend `PORT` and frontend `VITE_API_URL`
- Builds frontend
- Starts backend/frontend with PM2

## Notes
- The script picks ports dynamically so it can run alongside existing systems.
- Frontend was updated to respect `VITE_API_URL`, so API calls and report file downloads follow the selected backend port.
