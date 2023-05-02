#! /bin/bash
go mod tidy
mkdir -p ./bin
rm -rf ./bin/*
cp -r ./conf ./bin/conf

go mod init code.cloudbirds.cn/saas/micro-heartbeat-server
go mod tidy
go mod download
go mod vendor

GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -tags=jsoniter -ldflags "-s" -v -o ./bin/micro-heartbeat-server-pro-oversea .
#go build -o micro-heartbeat-oversea main.go
docker build -f Dockerfile -t micro-heartbeat-server-pro-oversea:v1.0.1.1 .