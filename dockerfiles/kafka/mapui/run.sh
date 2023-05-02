#!/bin/sh
docker run -it -d --privileged --restart=always --name kafka-map -p 9001:8080 -v /var/local/kafka-map/data:/opt/kafka-map/data -e DEFAULT_USERNAME=admin -e DEFAULT_PASSWORD=admin -e TZ="Asia/Shanghai" dushixiang/kafka-map:latest
  