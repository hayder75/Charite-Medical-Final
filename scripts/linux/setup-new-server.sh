#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"
BACKEND_DIR="$ROOT_DIR/backend"
FRONTEND_DIR="$ROOT_DIR/frontend"
BACKEND_ENV="$BACKEND_DIR/.env"
FRONTEND_ENV_PROD="$FRONTEND_DIR/.env.production"
BACKUP_DIR="$ROOT_DIR/DB backup"
DUMP_FILE="${1:-$BACKUP_DIR/medical_clinic_full_latest.sql}"

run_with_sudo() {
  if [[ "${EUID:-$(id -u)}" -eq 0 ]]; then
    "$@"
  elif command -v sudo >/dev/null 2>&1; then
    sudo "$@"
  else
    echo "[ERROR] sudo is required to install packages. Run as root or install sudo." >&2
    exit 1
  fi
}

require_cmd() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "[ERROR] Missing required command: $1" >&2
    exit 1
  fi
}

set_env_value() {
  local file="$1"
  local key="$2"
  local value="$3"

  if grep -qE "^${key}=" "$file"; then
    sed -i "s|^${key}=.*|${key}=${value}|" "$file"
  else
    echo "${key}=${value}" >> "$file"
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

is_port_busy() {
  local port="$1"
  ss -ltn "sport = :${port}" | awk 'NR>1 {print}' | grep -q .
}

find_free_port() {
  local candidate="$1"

  while true; do
    if [[ "$candidate" -eq 3000 || "$candidate" -eq 5000 ]]; then
      candidate=$((candidate + 1))
      continue
    fi

    if ! is_port_busy "$candidate"; then
      echo "$candidate"
      return
    fi

    candidate=$((candidate + 1))
  done
}

install_base_packages() {
  if command -v apt-get >/dev/null 2>&1; then
    echo "[INFO] Installing Linux packages (postgresql, build tools, node/npm)..."
    run_with_sudo apt-get update
    run_with_sudo apt-get install -y postgresql postgresql-contrib curl ca-certificates gnupg lsb-release nodejs npm
  else
    echo "[WARN] apt-get not found. Skipping OS package installation."
  fi
}

echo "=============================================================="
echo "Medical Clinic Linux Server Setup"
echo "=============================================================="

echo "[STEP] 1/8 Install required system packages"
install_base_packages

echo "[STEP] 2/8 Validate project files"
if [[ ! -f "$BACKEND_ENV" ]]; then
  echo "[ERROR] backend/.env not found at $BACKEND_ENV" >&2
  exit 1
fi
if [[ ! -f "$BACKEND_DIR/package.json" || ! -f "$FRONTEND_DIR/package.json" ]]; then
  echo "[ERROR] backend/frontend package.json not found. Run script from project copy." >&2
  exit 1
fi

require_cmd node
require_cmd npm
require_cmd psql
require_cmd ss

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

if [[ "$DB_HOST" == "localhost" ]]; then
  DB_HOST="127.0.0.1"
fi

if [[ -z "$DB_NAME" || -z "$DB_USER" ]]; then
  echo "[ERROR] Could not parse database info from DATABASE_URL" >&2
  exit 1
fi

export PGPASSWORD="$DB_PASSWORD"

echo "[STEP] 3/8 Create database if missing"
DB_EXISTS="$(psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -tAc "SELECT 1 FROM pg_database WHERE datname='${DB_NAME}'" || true)"
if [[ "$DB_EXISTS" != "1" ]]; then
  echo "[INFO] Creating database: $DB_NAME"
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d postgres -c "CREATE DATABASE \"${DB_NAME}\";"
else
  echo "[INFO] Database already exists: $DB_NAME"
fi

echo "[STEP] 4/8 Install Node dependencies"
(cd "$BACKEND_DIR" && npm install)
(cd "$FRONTEND_DIR" && npm install)

echo "[STEP] 5/8 Initialize DB schema/data"
if [[ -f "$DUMP_FILE" ]]; then
  echo "[INFO] Using SQL dump: $DUMP_FILE"
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -c 'DROP SCHEMA IF EXISTS public CASCADE; CREATE SCHEMA public;'
  psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" -d "$DB_NAME" -f "$DUMP_FILE"
else
  echo "[WARN] Dump file not found. Running Prisma migrate + seed instead."
  (cd "$BACKEND_DIR" && npx prisma migrate deploy)
  (cd "$BACKEND_DIR" && npm run seed:all)
fi

(cd "$BACKEND_DIR" && npx prisma generate)

echo "[STEP] 6/8 Pick free ports (excluding 3000/5000)"
BACKEND_PORT="$(find_free_port 3002)"
FRONTEND_PORT="$(find_free_port 3003)"
if [[ "$FRONTEND_PORT" -eq "$BACKEND_PORT" ]]; then
  FRONTEND_PORT="$(find_free_port $((BACKEND_PORT + 1)))"
fi

SERVER_IP="$(hostname -I 2>/dev/null | awk '{print $1}')"
if [[ -z "$SERVER_IP" ]]; then
  SERVER_IP="127.0.0.1"
fi

set_env_value "$BACKEND_ENV" "PORT" "$BACKEND_PORT"
set_env_value "$BACKEND_ENV" "NODE_ENV" '"production"'
printf 'VITE_API_URL=http://%s:%s/api\n' "$SERVER_IP" "$BACKEND_PORT" > "$FRONTEND_ENV_PROD"

echo "[STEP] 7/8 Build frontend"
(cd "$FRONTEND_DIR" && npm run build)

echo "[STEP] 8/8 Start processes with PM2"
if ! command -v pm2 >/dev/null 2>&1; then
  npm install -g pm2
fi

pm2 delete medical-clinic-backend medical-clinic-frontend >/dev/null 2>&1 || true
pm2 start "$BACKEND_DIR/server.js" --name medical-clinic-backend --cwd "$BACKEND_DIR"
pm2 serve "$FRONTEND_DIR/dist" "$FRONTEND_PORT" --name medical-clinic-frontend --spa
pm2 save

sleep 2

echo "=============================================================="
echo "Setup Complete"
echo "=============================================================="
echo "Backend port : $BACKEND_PORT"
echo "Frontend port: $FRONTEND_PORT"
echo "API URL      : http://$SERVER_IP:$BACKEND_PORT/api"
echo "Frontend URL : http://$SERVER_IP:$FRONTEND_PORT"
echo "Dump used    : $DUMP_FILE"
echo
echo "PM2 status:"
pm2 status
