#!/bin/sh
docker network create data_network


# 4.0.1-mondrian
docker pull apachekylin/apache-kylin-standalone:kylin-4.0.1-mondrian

docker run -it -d --privileged --restart=always -e TZ="Asia/Shanghai" --name kylin --network=data_network -m 8G -p 7070:7070 -p 7080:7080 -p 8088:8088 -p 50070:50070 -p 8032:8032 -p 8042:8042 -p 2182:2181 apachekylin/apache-kylin-standalone:kylin-4.0.1-mondrian


# 5.0
docker pull apachekylin/apache-kylin-standalone:5.0.0-alpha

docker run -it -d --privileged --restart=always -e TZ="Asia/Shanghai" --name kylin --network=data_network -m 8G -p 7070:7070 -p 8088:8088 -p 50070:50070 -p 8032:8032 -p 8042:8042 -p 2182:2181 apachekylin/apache-kylin-standalone:5.0.0-alpha

