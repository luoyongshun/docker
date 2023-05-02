#!/bin/sh
docker run -it --name=mosquitto -p 1883:1883 -d eclipse-mosquitto

# 更改账号密码：
# （1）、进入容器中
docker exec -it mosquitto sh
# （2）、进入cd /mosquitto/config，打开配置文件 vi mosquitto.conf
# （3）、增加listener 1883，这个不添加，只有本机才能够访问，其它地址访问不了。
# 设置allow_anonymous false ，这个配置文件中有，打开注释即可，含义为不允许匿名登录。可以 / allow_anonymous false 进行搜索，按n键搜索下一条。
# 搜索password_file，打开注释，在password_file后面加上 /mosquitto/config/pwdfile.conf，保存退出，写绝对地址，不要写相对地址，这个设置的是存放密码的文件的位置
# （4）、退出到mosquitto.conf 所在位置，建立一个文件touch pwdfile.conf,
# 写入账号密码：mosquitto_passwd -b pwdfile.conf admin public （admin 是账号，public 是密码）
# （5）、退出容器，重启服务。docker restart mosquitto