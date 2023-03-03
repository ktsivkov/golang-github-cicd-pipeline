FROM golang:1.20.1-alpine as builder

RUN export GOPATH=$HOME/go
RUN export PATH=$PATH:$GOPATH/bin

COPY . /app
WORKDIR /app

RUN go build -o application.out main.go

# Start over - not to keep codebase inside the container
FROM alpine:latest

COPY --from=builder /app/application.out /application.out
RUN chmod +x /application.out

ENTRYPOINT ["/application.out"]
