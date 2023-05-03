#!/bin/sh
#创建连接
docker network create kafka_network

# wurstmeister/zookeeper
docker run -it -d --privileged --restart=always -e TZ="Asia/Shanghai" --name zookeeper --network=kafka_network -p 2181:2181 -e ZOOKEEPER_CLIENT_PORT=2181 -p 2888:2888 -p 3888:3888 -p 8181:8080 -v /var/local/zookeeper/data:/data -v /var/local/zookeeper/logs:/datalog -v /var/local/zookeeper/conf/zoo.cnf:/conf/zoo.cnf wurstmeister/zookeeper:latest
