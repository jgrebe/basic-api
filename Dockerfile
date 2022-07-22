# syntax=docker/dockerfile:1.2

FROM golang:1.18.0-stretch AS builder

ENV GO111MODULE=on \
    CGO_ENABLED=0

WORKDIR /build

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .
RUN go build -ldflags="-w -s" -o main .


# Create the minimal runtime image
FROM scratch

ENV GIN_MODE=debug

USER 65534
COPY --from=builder /build/main /main

ENTRYPOINT ["/main"]

EXPOSE 8080