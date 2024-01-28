postgres:
	docker run --name postgres12  -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d -p 5432:5432 postgres:12-alpine

simplebank:
	docker run --name simplebank --network bank_network -p 8080:8080 -e DB_SOURCE=postgresql://root:secret@postgres12:5432/simple_bank?sslmode=disable simplebank:latest

createnetwork:
	docker create network bank_network

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateupaws:
	migrate -path db/migration -database "postgresql://root:19980320a@simple-bank.clo4iwm4cxqo.us-east-2.rds.amazonaws.com:5432/simple_bank" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	sqlc generate

test:
	go test -v -cover ./...

server: 
	go run main.go

.PHONY: postgres simplebank createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test