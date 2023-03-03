FROM golang:1.20.1-bullseye

RUN export GOPATH=$HOME/go
RUN export PATH=$PATH:$GOPATH/bin

COPY . /app
WORKDIR /app

ENTRYPOINT ["/app/cicd/coverage.sh"]
