#!/bin/bash

HOMELOG='/home/logs'
KAFKACLUSTER=$HOMELOG'/kafka-cluster'
KAFKACLUSTERLOG_1=$KAFKACLUSTER'/kafka1-logs'
KAFKACLUSTERLOG_2=$KAFKACLUSTER'/kafka2-logs'
KAFKACLUSTERLOG_3=$KAFKACLUSTER'/kafka3-logs'
KAFKAZKCLUSTERPATH_1=$KAFKACLUSTER'/zk1'
KAFKAZKCLUSTERPATH_2=$KAFKACLUSTER'/zk2'
KAFKAZKCLUSTERPATH_3=$KAFKACLUSTER'/zk3'

#basicpath
if [ ! -d$HOMELOG ];then
    echo '::: '$HOMELOG' :::'
    mkdir $HOMELOG
fi

if [ ! -d$KAFKACLUSTER ];then
    echo '::: '$KAFKACLUSTER' :::'
    mkdir $KAFKACLUSTER
fi

#kafka logs
if [ ! -d$KAFKACLUSTERLOG_1 ];then
    echo '::: '$KAFKACLUSTERLOG_1' not exsit folder :::'
    mkdir $KAFKACLUSTERLOG_1
fi

if [ ! -d$KAFKACLUSTERLOG_2 ];then
    echo '::: '$KAFKACLUSTERLOG_2' not exsit folder :::'
    mkdir $KAFKACLUSTERLOG_2
fi

if [ ! -d$KAFKACLUSTERLOG_3 ];then
    echo '::: '$KAFKACLUSTERLOG_3' not exsit folder :::'
    mkdir $KAFKACLUSTERLOG_3
fi

#kafka zk cluster path
if [ ! -d$KAFKAZKCLUSTERPATH_1 ];then
    echo '::: '$KAFKAZKCLUSTERPATH_1' not exsit folder :::'
    mkdir $KAFKAZKCLUSTERPATH_1
fi

if [ ! -d$KAFKAZKCLUSTERPATH_2 ];then
    echo '::: '$KAFKAZKCLUSTERPATH_2' not exsit folder :::'
    mkdir $KAFKAZKCLUSTERPATH_2
fi

if [ ! -d$KAFKAZKCLUSTERPATH_3 ];then
    echo '::: '$KAFKAZKCLUSTERPATH_3' not exsit folder :::'
    mkdir $KAFKAZKCLUSTERPATH_3
fi

#kafka zk data
if [ ! -d"/home/logs/kafka/zk1/data" ];then
    echo '::: /home/logs/kafka/zk1/data :::'
    mkdir /home/logs/kafka/zk1/data
fi

if [ ! -d"/home/logs/kafka/zk2/data" ];then
    echo '::: /home/logs/kafka/zk2/data :::'
    mkdir /home/logs/kafka/zk2/data
fi

if [ ! -d"/home/logs/kafka/zk3/data" ];then
    echo '::: /home/logs/kafka/zk3/data :::'
    mkdir /home/logs/kafka/zk3/data
fi

#kafka zk log
if [ ! -d"/home/logs/kafka/zk1/log" ];then
    echo '::: /home/logs/kafka/zk1/log :::'
    mkdir /home/logs/kafka/zk1/log
fi

if [ ! -d"/home/logs/kafka/zk2/log" ];then
    echo '::: /home/logs/kafka/zk2/log :::'
    mkdir /home/logs/kafka/zk2/log
fi

if [ ! -d"/home/logs/kafka/zk3/log" ];then
    echo '::: /home/logs/kafka/zk3/log :::'
    mkdir /home/logs/kafka/zk3/log
fi



echo '::: start build zookeeper cluster :::'

#zookeeper-cluster-ip
#default cluster 3
MACHINE_HOST="10.1.62.21"

#zookeeper-cluster-port
#default port 2181
ZOOKEEPER_PORT_1=2151
ZOOKEEPER_PORT_2=2152
ZOOKEEPER_PORT_3=2153

#zookeeper-leader-port
#default port 2888
ZOOKEEPER_LEADERPORT_1=2887
ZOOKEEPER_LEADERPORT_2=2888
ZOOKEEPER_LEADERPORT_3=2889

#zookeeper-vote-port
#default port 3888
ZOOKEEPER_VOTEPORT_1=3887
ZOOKEEPER_VOTEPORT_2=3888
ZOOKEEPER_VOTEPORT_3=3889

#build zk1、zk2、zk3
docker rm -f kafka-zk1
docker rm -f kafka-zk2
docker rm -f kafka-zk3

docker run  -d \
--restart=always \
--name kafka-zk1 \
-p $ZOOKEEPER_PORT_1:2181 \
-p $ZOOKEEPER_LEADERPORT_1:2888 \
-p $ZOOKEEPER_VOTEPORT_1:3888 \
-e "ZOO_INIT_LIMIT=2000" \
-e "ZOO_MAX_CLIENT_CNXNS=10000" \
-e "TZ=Asia/Shanghai" \
-e "ZOO_MY_ID=1" \
-e "ZOO_SERVERS=server.1=0.0.0.0:2888:3888 server.2=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_2:$ZOOKEEPER_VOTEPORT_2 server.3=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_3:$ZOOKEEPER_VOTEPORT_3" \
-v /home/logs/kafka/zk1/data:/data \
-v /home/logs/kafka/zk1/log:/datalog \
zookeeper:3.5.5

docker run  -d \
--restart=always \
--name kafka-zk2 \
-p $ZOOKEEPER_PORT_2:2181 \
-p $ZOOKEEPER_LEADERPORT_2:2888 \
-p $ZOOKEEPER_VOTEPORT_2:3888 \
-e "ZOO_INIT_LIMIT=2000" \
-e "ZOO_MAX_CLIENT_CNXNS=10000" \
-e "TZ=Asia/Shanghai" \
-e "ZOO_MY_ID=2" \
-e "ZOO_SERVERS=server.1=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_1:$ZOOKEEPER_VOTEPORT_1 server.2=0.0.0.0:2888:3888 server.3=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_3:$ZOOKEEPER_VOTEPORT_3" \
-v /home/logs/kafka/zk2/data:/data \
-v /home/logs/kafka/zk2/log:/datalog \
zookeeper:3.5.5

docker run  -d \
--restart=always \
--name kafka-zk3 \
-p $ZOOKEEPER_PORT_3:2181 \
-p $ZOOKEEPER_LEADERPORT_3:2888 \
-p $ZOOKEEPER_VOTEPORT_3:3888 \
-e "ZOO_INIT_LIMIT=2000" \
-e "ZOO_MAX_CLIENT_CNXNS=10000" \
-e "TZ=Asia/Shanghai" \
-e "ZOO_MY_ID=3" \
-e "ZOO_SERVERS=server.1=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_1:$ZOOKEEPER_VOTEPORT_1 server.2=$MACHINE_HOST:$ZOOKEEPER_LEADERPORT_2:$ZOOKEEPER_VOTEPORT_2 server.3=0.0.0.0:2888:3888" \
-v /home/logs/kafka/zk3/data:/data \
-v /home/logs/kafka/zk3/log:/datalog \
zookeeper:3.5.5


echo '::: build zookeeper cluster successfully :::'


echo '::: start build kafka cluster :::'

KAFKA_PORT_1=9092
KAFKA_PORT_2=9093
KAFKA_PORT_3=9094

#kafka broker
#docker rm -f kafka-cluster-1
#docker rm -f kafka-cluster-2
#docker rm -f kafka-cluster-3


# docker run -d \
# --restart=always \
# --name kafka-cluster-1 \
# -p $KAFKA_PORT_1:9092 \
# -e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT_1,$MACHINE_HOST:$ZOOKEEPER_PORT_2,$MACHINE_HOST:$ZOOKEEPER_PORT_3 \
# -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_1 \
# -e KAFKA_LISTENERS=PLAINTEXT://:$KAFKA_PORT_1 \
# -e KAFKA_BROKER_ID=0 \
# -e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
# -e KAFKA_LOG_RETENTION_HOURS=24 \
# -v /etc/localtime:/etc/localtime \
# -v /home/logs/kafka1-logs/:/kafka/logs \
# wurstmeister/kafka:2.12-2.3.0 

# docker run -d \
# --restart=always \
# --name kafka-cluster-2 \
# -p $KAFKA_PORT_2:9092 \
# -e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT_1,$MACHINE_HOST:$ZOOKEEPER_PORT_2,$MACHINE_HOST:$ZOOKEEPER_PORT_3 \
# -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_2 \
# -e KAFKA_LISTENERS=PLAINTEXT://:$KAFKA_PORT_2 \
# -e KAFKA_BROKER_ID=0 \
# -e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
# -e KAFKA_LOG_RETENTION_HOURS=24 \
# -v /etc/localtime:/etc/localtime \
# -v /home/logs/kafka2-logs/:/kafka/logs \
# wurstmeister/kafka:2.12-2.3.0 

# docker run -d \
# --restart=always \
# --name kafka-cluster-3 \
# -p $KAFKA_PORT_3:9092 \
# -e KAFKA_ZOOKEEPER_CONNECT=$MACHINE_HOST:$ZOOKEEPER_PORT_1,$MACHINE_HOST:$ZOOKEEPER_PORT_2,$MACHINE_HOST:$ZOOKEEPER_PORT_3 \
# -e KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://$MACHINE_HOST:$KAFKA_PORT_3 \
# -e KAFKA_LISTENERS=PLAINTEXT://:$KAFKA_PORT_3 \
# -e KAFKA_BROKER_ID=0 \
# -e KAFKA_HEAP_OPTS="-Xmx4G -Xms4G" \
# -e KAFKA_LOG_RETENTION_HOURS=24 \
# -v /etc/localtime:/etc/localtime \
# -v /home/logs/kafka3-logs/:/kafka/logs \
# wurstmeister/kafka:2.12-2.3.0

echo '::::::::: build  kafka cluster successfully! ::::::::::::::'


echo '::: start build kafka-manager :::'

KAFKAMANAGER_PORT=14672

#kafka manager
#docker rm -f kafka-manager

# docker run -d \
# --restart=always \
# --name kafka-manager \
# -p $KAFKAMANAGER_PORT:9000 \
# -e ZK_HOSTS=$MACHINE_HOST:$ZOOKEEPER_PORT_1,$MACHINE_HOST:$ZOOKEEPER_PORT_2,$MACHINE_HOST:$ZOOKEEPER_PORT_3 \
# -e APPLICATION_SECRET=letmein \
# sheepkiller/kafka-manager 

echo '::::::::: build kafka-manager successfully! ::::::::::::::'