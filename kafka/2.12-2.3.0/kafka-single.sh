#!/bin/bash

HOMELOG='/home/logs'
KAFKASINGLE=$HOMELOG'/kafka-single'
KAFKALOG=$KAFKASINGLE'/kafka-logs'
KAFKAZK=$KAFKASINGLE'/zk'
KAFKAZKDATA=$KAFKAZK'/data'
KAFKAZKLOG=$KAFKAZK'/log'

#defind zk-version
ZK_VERSION=3.5.5

#defind kafka-version
KAFKA_VERSION=2.12-2.3.0

#defind kafka-manager-version
KAFKAMANAGER_VERSION=stable

if [ ! -d$KAFKALOG ];then
    echo '::: '$KAFKALOG' not exsit folder :::'
    mkdir $KAFKALOG
fi

if [ ! -d$KAFKASINGLE ];then
    echo '::: '$KAFKASINGLE' not exsit folder :::'
    mkdir $KAFKASINGLE
fi

if [ ! -d$KAFKAZK ];then
    echo '::: '$KAFKAZK' not exsit folder :::'
    mkdir $KAFKAZK
fi

#kafka logs
if [ ! -d$KAFKALOG ];then
    echo '::: '$KAFKALOG' not exsit folder :::'
    mkdir $KAFKALOG
fi

#kafka zk data
if [ ! -d$KAFKAZKDATA ];then
    echo '::: '$KAFKAZKDATA' :::'
    mkdir $KAFKAZKDATA
fi

#kafka zk log
if [ ! -d$KAFKAZKLOG ];then
    echo '::: '$KAFKAZKLOG' :::'
    mkdir $KAFKAZKLOG
fi



echo '::: start build zookeeper-single :::'

#zookeeper-cluster-ip
#default cluster 3
MACHINE_HOST="10.1.62.21"

#zookeeper-cluster-port
#default port 2181
ZOOKEEPER_PORT_1=2150


#build zk
docker rm -f kafka-single-zk1

docker run  -d \
--restart=always \
--name kafka-single-zk1 \
-p $ZOOKEEPER_PORT_1:2181 \
-e "ZOO_INIT_LIMIT=2000" \
-e "ZOO_MAX_CLIENT_CNXNS=10000" \
-e "TZ=Asia/Shanghai" \
-v $KAFKAZKDATA:/data \
-v $KAFKAZKLOG:/datalog \
zookeeper:$ZK_VERSION

echo '::: build zookeeper successfully :::'


echo '::: start build kafka single :::'

KAFKA_PORT_1=9090

#kafka broker
#eg ==> send : ./bin/kafka-console-producer.sh --broker-list localhost:9092 --topic mykafka
#eg ==> receive : ./bin/kafka-console-consumer.sh --bootstrap-server localhost:9092 --topic mykafka --from-beginning
docker rm -f kafka-single


docker run -d \
--restart=always \
--name kafka-single \
-p $KAFKA_PORT_1:9090 \
-e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT_1 \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_1 \
-e KAFKA_LISTENERS=PLAINTEXT://:$KAFKA_PORT_1 \
-e KAFKA_BROKER_ID=0 \
-e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
-e KAFKA_LOG_RETENTION_HOURS=24 \
-v /etc/localtime:/etc/localtime \
-v $KAFKALOG:/kafka/logs \
wurstmeister/kafka:$KAFKA_VERSION

echo '::::::::: build  kafka single successfully! ::::::::::::::'


echo '::: start build kafka-single-manager :::'

KAFKAMANAGER_PORT=14670

#kafka manager
docker rm -f kafka-single-manager

docker run -d \
--restart=always \
--name kafka-single-manager \
-p $KAFKAMANAGER_PORT:9000 \
-e ZK_HOSTS=$MACHINE_HOST:$ZOOKEEPER_PORT_1 \
-e APPLICATION_SECRET=letmein \
sheepkiller/kafka-manager:$KAFKAMANAGER_VERSION

echo '::::::::: build kafka-single-manager successfully! ::::::::::::::'