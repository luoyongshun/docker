docker run -d --privileged --restart=always -e TZ="Asia/Shanghai" --name rabbitmq -p 47324:47324 -p 1883:1883 -p 5672:5672 -p 15672:15672 -p 25672:25672 -v /var/local/rabbitmq/data:/opt/rabbitmq/data rabbitmq:latest

#开启WEB管理
rabbitmq-plugins enable rabbitmq_management
#开启MQTT插件
rabbitmq-plugins enable rabbitmq_mqtt

# plugins 
# rabbitmq_prometheus
# rabbitmq_web_dispatch
# rabbitmq_management_agent