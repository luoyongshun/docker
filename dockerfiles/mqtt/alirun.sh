#!/bin/sh 

docker pull registry.cn-hangzhou.aliyuncs.com/synbop/emqttd:2.3.6

# 运行镜像 –name 名字 -p 18083 服务器启动端口 -p 1882 TCP端口 -p 8083 WS端口 -p 8084 WSS端口 -p 8883 SSL端口 -d 指定容器
docker run --name emq -p 18083:18083 -p 1883:1883 -p 8084:8084 -p 8883:8883 -p 8083:8083 -d registry.cn-hangzhou.aliyuncs.com/synbop/emqttd:2.3.6

# 进入容器, 不能用 /bin/bash 进入
docker exec -it emq /bin/sh

# 建立用户和权限的 mysql 表, 可以拉一个 mysql 容器, 也可以直接在你的 ubuntu 里的 mysql 中创建
CREATE DATABASE emq charset utf8;
use emq;
CREATE TABLE mqtt_user ( 
id int(11) unsigned NOT NULL AUTO_INCREMENT, 
username varchar(100) DEFAULT NULL, 
password varchar(100) DEFAULT NULL, 
salt varchar(20) DEFAULT NULL, 
is_superuser tinyint(1) DEFAULT 0, 
created datetime DEFAULT NULL, 
PRIMARY KEY (id), 
UNIQUE KEY mqtt_username (username) 
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE mqtt_acl ( 
id int(11) unsigned NOT NULL AUTO_INCREMENT, 
allow int(1) DEFAULT NULL COMMENT '0: deny, 1: allow', 
ipaddr varchar(60) DEFAULT NULL COMMENT 'IpAddress', 
username varchar(100) DEFAULT NULL COMMENT 'Username', 
clientid varchar(100) DEFAULT NULL COMMENT 'ClientId', 
access int(2) NOT NULL COMMENT '1: subscribe, 2: publish, 3: pubsub', 
topic varchar(100) NOT NULL DEFAULT '' COMMENT 'Topic Filter', 
PRIMARY KEY (id) 
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


# 插入ACL规则 - ACL规则
INSERT INTO `mqtt_acl` (`id`, `allow`, `ipaddr`, `username`, `clientid`, `access`, `topic`) VALUES 
(1,1,NULL,'$all',NULL,2,'#'),
(2,0,NULL,'$all',NULL,1,'$SYS/#'),
(3,0,NULL,'$all',NULL,1,'eq #'),
(5,1,'127.0.0.1',NULL,NULL,2,'$SYS/#'),
(6,1,'127.0.0.1',NULL,NULL,2,'#'),
(7,1,NULL,'dashboard',NULL,1,'$SYS/#');

# 插入用户, 由此开始订阅与发布的 Client 都必须通过用户验证（sha256值）
# 可以配置超级管理员(超级管理员会无视ACL规则对所有的topic都有订阅和推送的权限)
insert into mqtt_user (`username`, `password`) values ('admin', '03ac674216f3e15c761ee1a5e255f067953623c8b388b4459e13f978d7c846f4');
update mqtt_user set is_superuser=1 where id= 超级管理员ID ;

ps:注意 auth.mysql.password_hash(默认为sha256) 为sha256的话，新增用户时需要手动传递加密后的值，plain的话则无需加密，明码存放


# 修改emq的mysql配置文件
vi /opt/emqttd/etc/plugins/emq_auth_mysql.conf
auth.mysql.server = 你的mysql-IP:3306 
auth.mysql.username = root 
auth.mysql.password = xxxxxxxx 
auth.mysql.database = emq


/opt/emqttd/bin/ emqx stop
/opt/emqttd/bin/ emqx start
/opt/emqttd/bin/emqttd_ctl plugins load emq_auth_mysql   #开启mysql认证插件
