#!/bin/bash

echo ':::::::: build kafka-manager :::::::'

docker rm -f kafka-cluster-manager

docker run -d \
--restart=always \
--name kafka-cluster-manager \
-p 9000:9000 \
-e ZK_HOSTS=10.1.62.23:2181 \
-e APPLICATION_SECRET=letmein \
hlebalbau/kafka-manager:stable
