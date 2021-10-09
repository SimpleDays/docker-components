#!/bin/bash

docker stop p3x-redis-ui

docker rm -f p3x-redis-ui 

docker run --restart=always --name=p3x-redis-ui \
-v /home/dongliang/p3x-redis-ui-settings:/settings \
-h docker-p3x-redis-ui \
-p 7843:7843 -d \
patrikx3/p3x-redis-ui