#!/bin/bash

HOMELOG='/home/logs'
KAFKACLUSTER=$HOMELOG'/kafka-cluster'
KAFKAZKCLUSTERPATH=$KAFKACLUSTER'/zk'
ZKDATAPATH=$KAFKAZKCLUSTERPATH'/data'
ZKLOGPATH=$KAFKAZKCLUSTERPATH'/log'
KAFKACLUSTERLOG_1=$KAFKACLUSTER'/kafka1-logs'
KAFKACLUSTERLOG_2=$KAFKACLUSTER'/kafka2-logs'
KAFKACLUSTERLOG_3=$KAFKACLUSTER'/kafka3-logs'

#defind zk-version
ZK_VERSION=3.5.5

#defind kafka-version
KAFKA_VERSION=2.12-2.3.0

#defind kafka-manager-version
KAFKAMANAGER_VERSION=stable

#default cluster 3
MACHINE_HOST="10.1.62.21"

#zookeeper-port
#default port 2181
ZOOKEEPER_PORT=2151

#kafka-broker-ports
#kafka-port
KAFKA_PORT_1=9091
KAFKA_PORT_2=9092
KAFKA_PORT_3=9093

#kafka-manager-port
#default port 9000
KAFKAMANAGER_PORT=14672

#basicpath
if [ ! -d$HOMELOG ];then
    echo '::: '$HOMELOG' not exsit folder mkdir new folder :::'
    mkdir $HOMELOG
fi

if [ ! -d$KAFKACLUSTER ];then
    echo '::: '$KAFKACLUSTER' not exsit folder mkdir new folder :::'
    mkdir $KAFKACLUSTER
fi

#kafka zk path
if [ ! -d$KAFKAZKCLUSTERPATH ];then
    echo '::: '$KAFKAZKCLUSTERPATH' not exsit folder mkdir new folder :::'
    mkdir $KAFKAZKCLUSTERPATH
fi

#kafka zk data
if [ ! -d$ZKDATAPATH ];then
    echo '::: '$ZKDATAPATH' not exsit folder mkdir new folder :::'
    mkdir $ZKDATAPATH
fi

#kafka zk log
if [ ! -d$ZKLOGPATH ];then
    echo '::: '$ZKLOGPATH' not exsit folder mkdir new folder :::'
    mkdir $ZKLOGPATH
fi

#kafka broker log
if [ ! -d$KAFKACLUSTERLOG_1 ];then
    echo '::: '$KAFKACLUSTERLOG_1' not exsit folder mkdir new folder :::'
    mkdir $KAFKACLUSTERLOG_1
fi

if [ ! -d$KAFKACLUSTERLOG_2 ];then
    echo '::: '$KAFKACLUSTERLOG_2' not exsit folder mkdir new folder :::'
    mkdir $KAFKACLUSTERLOG_2
fi

if [ ! -d$KAFKACLUSTERLOG_3 ];then
    echo '::: '$KAFKACLUSTERLOG_3' not exsit folder mkdir new folder :::'
    mkdir $KAFKACLUSTERLOG_3
fi


echo '::: start build zookeeper cluster :::'
#build zk
docker rm -f kafka-cluster-zk

docker run -d \
--restart=always \
--name kafka-cluster-zk \
-p $ZOOKEEPER_PORT:2181 \
-e "TZ=Asia/Shanghai" \
-e "ZOO_INIT_LIMIT=2000" \
-e "ZOO_MAX_CLIENT_CNXNS=10000" \
-v $ZKDATAPATH:/data \
-v $ZKLOGPATH:/datalog \
zookeeper:$ZK_VERSION

echo '::: build zookeeper cluster successfully :::'


echo '::: start build kafka broker cluster :::'

docker rm -f kafka-broker-1
docker rm -f kafka-broker-2
docker rm -f kafka-broker-3

docker run -d \
--restart=always \
--name kafka-broker-1 \
-p $KAFKA_PORT_1:$KAFKA_PORT_1 \
-e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_1 \
-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:$KAFKA_PORT_1 \
-e KAFKA_BROKER_ID=1 \
-e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
-e KAFKA_LOG_RETENTION_HOURS=24 \
-v /etc/localtime:/etc/localtime \
-v $KAFKACLUSTERLOG_1:/kafka/logs \
wurstmeister/kafka:$KAFKA_VERSION

docker run -d \
--restart=always \
--name kafka-broker-2 \
-p $KAFKA_PORT_2:$KAFKA_PORT_2 \
-e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_2 \
-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:$KAFKA_PORT_2 \
-e KAFKA_BROKER_ID=2 \
-e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
-e KAFKA_LOG_RETENTION_HOURS=24 \
-v /etc/localtime:/etc/localtime \
-v $KAFKACLUSTERLOG_2:/kafka/logs \
wurstmeister/kafka:$KAFKA_VERSION

docker run -d \
--restart=always \
--name kafka-broker-3 \
-p $KAFKA_PORT_3:$KAFKA_PORT_3 \
-e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT \
-e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_3 \
-e KAFKA_LISTENERS=PLAINTEXT://0.0.0.0:$KAFKA_PORT_3 \
-e KAFKA_BROKER_ID=3 \
-e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
-e KAFKA_LOG_RETENTION_HOURS=24 \
-v /etc/localtime:/etc/localtime \
-v $KAFKACLUSTERLOG_3:/kafka/logs \
wurstmeister/kafka:$KAFKA_VERSION

echo '::: build kafka broker cluster successfully :::'

echo '::: start build kafka-cluster-manager :::'

#kafka cluster manager
docker rm -f kafka-cluster-manager

docker run -d \
--restart=always \
--name kafka-cluster-manager \
-p $KAFKAMANAGER_PORT:9000 \
-e ZK_HOSTS=$MACHINE_HOST:$ZOOKEEPER_PORT \
-e APPLICATION_SECRET=letmein \
sheepkiller/kafka-manager:$KAFKAMANAGER_VERSION

echo '::::::::: build kafka-cluster-manager successfully! ::::::::::::::'