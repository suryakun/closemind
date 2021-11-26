FROM golang:1.17.3-buster AS builder

ARG VERSION=dev

WORKDIR /go/src/app
COPY . .
RUN go mod download
RUN go build -o main -ldflags=-X=main.version=${VERSION} .

FROM debian:buster-slim
COPY --from=builder /go/src/app/main /go/bin/main
ENV PATH="/go/bin:${PATH}"
CMD ["main"]