#!/bin/bash
docker rm -f zkwebui

docker run --restart=always --name zkwebui -d -p 6062:8080 vivint/zk-web-docker

echo '::: build zkwebui successfully :::'