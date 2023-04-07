FROM golang:1.20 AS builder

WORKDIR /app

ADD go.mod go.sum ./
RUN go mod download

ADD . ./
RUN go build -o backend

FROM alpine:latest

RUN apk --no-cache add ca-certificates

WORKDIR /root/

COPY --from=builder /app/backend ./
CMD ["./backend"]
