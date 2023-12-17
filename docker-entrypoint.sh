#!/bin/sh
# Abort on any error (including if wait-for-it fails).
set -e

echo "wait for postgres"
/app/wait-for-it.sh "db:5432" 
echo "postgres is up"

echo "run db migration"
/app/migrate -path /app/migration -database postgres://postgres:password@db:5432/simple_bank?sslmode=disable -verbose up
echo "db migration done"

exec "$@"