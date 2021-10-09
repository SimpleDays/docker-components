#!/bin/bash

docker rm -f nginx-proxy

docker run --restart=always -d -p 9376:9376 \
--link p3x-redis-ui:p3x-redis-ui \
--name=nginx-proxy \
nginx-proxy:v1

