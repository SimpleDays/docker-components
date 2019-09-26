#!/bin/bash
#root@9ba5242c2068:/zk-web/conf# cat zk-web-conf.clj
#{
#:server-port 8080
# :users {"admin" "hello"}
# :default-node ""
#}
#可外置修改conf

docker rm -f zkwebui

docker run --restart=always --name zkwebui -d -p 6062:8080 vivint/zk-web-docker

echo '::: build zkwebui successfully :::'