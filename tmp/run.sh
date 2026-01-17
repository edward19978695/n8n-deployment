#!/bin/sh
set -eu

echo "Testing DNS..."
getent hosts "$PGHOST" || true

echo "Testing TCP connectivity..."
# busybox nc exists on alpine
nc -vz -w 5 "$PGHOST" "$PGPORT"

echo "Running psql..."
export PGCONNECT_TIMEOUT="${PGCONNECT_TIMEOUT:-10}"
# SSL mode default require if not set
export PGSSLMODE="${PGSSLMODE:-require}"

psql "host=$PGHOST port=$PGPORT dbname=$PGDATABASE user=$PGUSER password=$PGPASSWORD sslmode=$PGSSLMODE connect_timeout=$PGCONNECT_TIMEOUT" \
  -c "select 1 as ok;" \
  -c "select now() as server_time;"

echo "OK: DB connection succeeded."
