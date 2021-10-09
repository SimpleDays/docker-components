#!/bin/bash

docker rmi -f nginx-proxy:v1

docker build -t nginx-proxy:v1 .

echo 'success'
