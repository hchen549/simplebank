from golang:1.21-alpine3.18 as builder
workdir /app
copy go.mod go.sum .
run go mod download
RUN apk --no-cache add curl && \
curl -L https://github.com/golang-migrate/migrate/releases/download/v4.15.2/migrate.linux-amd64.tar.gz | tar xvz
copy . .
run go build -o main main.go

from alpine:3.18
workdir /app
copy --from=builder /app/main .
copy --from=builder /app/migrate ./migrate

copy ./app.env .
copy ./db/migration ./migration
copy ./wait-for-it.sh .
copy ./docker-entrypoint.sh .

RUN chmod +x ./wait-for-it.sh ./docker-entrypoint.sh

Expose 8080
cmd ["/app/main"]
ENTRYPOINT ["/app/docker-entrypoint.sh"]
