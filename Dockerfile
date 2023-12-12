from golang:1.21-alpine3.18 as builder
workdir /app
copy . .
run go build -o main main.go

from alpine:3.18
workdir /app
copy --from=builder /app/main .
copy --from=builder /app/app.env .

Expose 8080
cmd ["/app/main"]