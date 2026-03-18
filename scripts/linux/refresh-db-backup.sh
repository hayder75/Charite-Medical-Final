#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
BACKEND_ENV="$ROOT_DIR/backend/.env"
BACKUP_DIR="$ROOT_DIR/DB backup"

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[ERROR] Missing required command: $1" >&2
    exit 1
  fi
}

parse_database_url() {
  local database_url="$1"
  node -e '
    const raw = process.argv[1];
    const url = new URL(raw);
    const out = [
      decodeURIComponent(url.username || ""),
      decodeURIComponent(url.password || ""),
      url.hostname || "127.0.0.1",
      url.port || "5432",
      url.pathname.replace(/^\//, "")
    ];
    process.stdout.write(out.join("|"));
  ' "$database_url"
}

echo "[INFO] Preparing fresh SQL backup from backend/.env"

require_cmd node
require_cmd pg_dump
require_cmd psql

if [[ ! -f "$BACKEND_ENV" ]]; then
  echo "[ERROR] backend/.env not found at $BACKEND_ENV" >&2
  exit 1
fi

DATABASE_URL_LINE="$(grep -E '^DATABASE_URL=' "$BACKEND_ENV" | tail -n 1 || true)"
if [[ -z "$DATABASE_URL_LINE" ]]; then
  echo "[ERROR] DATABASE_URL is missing in backend/.env" >&2
  exit 1
fi

DATABASE_URL="${DATABASE_URL_LINE#DATABASE_URL=}"
DATABASE_URL="${DATABASE_URL%\"}"
DATABASE_URL="${DATABASE_URL#\"}"
DATABASE_URL="${DATABASE_URL%\'}"
DATABASE_URL="${DATABASE_URL#\'}"

IFS='|' read -r DB_USER DB_PASSWORD DB_HOST DB_PORT DB_NAME <<< "$(parse_database_url "$DATABASE_URL")"

if [[ -z "$DB_NAME" ]]; then
  echo "[ERROR] Failed to parse database name from DATABASE_URL" >&2
  exit 1
fi

mkdir -p "$BACKUP_DIR"

# Per request: remove old dump(s) in DB backup before creating the new one.
rm -f "$BACKUP_DIR"/*.sql

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
DUMP_FILE="$BACKUP_DIR/medical_clinic_full_backup_${TIMESTAMP}.sql"
LATEST_FILE="$BACKUP_DIR/medical_clinic_full_latest.sql"

export PGPASSWORD="$DB_PASSWORD"

echo "[INFO] Verifying database connection to $DB_HOST:$DB_PORT/$DB_NAME"
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c 'SELECT NOW();' >/dev/null

echo "[INFO] Creating full SQL dump: $DUMP_FILE"
pg_dump \
  -h "$DB_HOST" \
  -p "$DB_PORT" \
  -U "$DB_USER" \
  --encoding=UTF8 \
  --format=plain \
  --clean \
  --if-exists \
  --no-owner \
  --no-privileges \
  "$DB_NAME" > "$DUMP_FILE"

cp "$DUMP_FILE" "$LATEST_FILE"

echo "[OK] Backup completed"
echo "[OK] New dump: $DUMP_FILE"
echo "[OK] Latest alias: $LATEST_FILE"