#!/bin/sh
# Abort on any error (including if wait-for-it fails).
set -e

echo "run db migration"
/app/migrate -path /app/migration -database $DB_SOURCE -verbose up
echo "db migration done"

exec "$@"