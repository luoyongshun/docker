#!/bin/sh
# wurstmeister/kafka
# /opt/kafka_2.13-2.8.1/logs
# -e KAFKA_LOG_DIRS="/kafka/kafka-logs" -v /var/local/kafka/conf/server.properties:/opt/kafka/config/server.properties -v /var/kafka/logs:/opt/kafka_2.13-2.8.1/logs -v /var/local/kafka/data:/kafka/kafka-logs -e KAFKA_CLUSTER_ID="lEZffL5fRROYGapsqr_pOQ"
docker run -it -d --privileged --restart=always -e TZ="Asia/Shanghai" --name kafka --network=kafka_network -e KAFKA_AUTO_CREATE_TOPICS_ENABLE=true -e KAFKA_ADVERTISED_HOST_NAME=kafka -p 9092:9092 -e KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:9092 -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092 -e KAFKA_CFG_ZOOKEEPER_CONNECT=zookeeper:2181 -e KAFKA_CFG_LISTENERS=PLAINTEXT://0.0.0.0:9092 -e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka:9092 -e FF_NETWORK_PER_BUILD=100 -e KAFKA_BROKER_ID=0 -e KAFKA_DEFAULT_REPLICATION_FACTOR=1 -e KAFKA_LOG_RETENTION_HOURS=168 -v /var/kafka/logs:/opt//kafka_2.13-2.8.1/logs -v /var/local/kafka/data:/kafka/kafka-logs wurstmeister/kafka:latest

# exec
cd /opt/kafka_2.13-2.8.1/bin/
./kafka-topics.sh --zookeeper zookeeper:2181 --describe

# stop 
/export/server/kafka_2.12-2.4.1/bin/kafka-server-stop.sh          
