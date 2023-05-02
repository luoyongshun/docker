#!/usr/bin/env sh

rm -rf ./deploy/bin
mkdir -p ./deploy/bin


go get -v -insecure -d  ctgit.szctjt.cn/tech/common-golang
go get -v -insecure -d  ctgit.szctjt.cn/tech/go-entity

go mod tidy
go generate ctgit.szctjt.cn/tech/$SERVICE_NAME/app
# go get -u github.com/swaggo/swag/cmd/swag && swag init --parseDependency --generalInfo ./main.go --output ./app/swagger
GOOS=linux GOARCH=amd64 CGO_ENABLED=0 go build -ldflags "-s" -v -o ./deploy/bin/$SERVICE_NAME .