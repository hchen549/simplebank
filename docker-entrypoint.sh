#!/bin/sh
# Abort on any error (including if wait-for-it fails).
set -e

echo "wait for postgres"
/app/wait-for-it.sh "db:5432" 
echo "postgres is up"

echo "run db migration"
source /app/app.env
/app/migrate -path /app/migration -database $DB_SOURCE -verbose up
echo "db migration done"

exec "$@"