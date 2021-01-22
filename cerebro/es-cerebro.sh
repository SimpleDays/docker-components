#!/bin/bash

docker rm -f cerebro

docker run -d --restart=always --name=cerebro -p 9100:9000 lmenezes/cerebro:0.9.3

echo '::: run cerebro successfully :::'