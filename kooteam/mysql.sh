#!/bin/bash


############################### Define #############################################
#定义基础配置参数

#mysql实例名称
mysql_name='mysql-kooteam'

#volume mounts
#mysql存储挂载
mysql_mounts_path='/home/dongliang/mnt/mysql/kooteamdata/data'

#mysql对外暴露端口
mysql_port=3306

#mysql的root密码
mysql_pwd=123456

#mysql的镜像版本设置
mysql_version='5.7'

#mysql_maxConnections设置mysql最大连接数
mysql_maxConnections=1000

# rm docker container
echo -e "\e[32m INFO: \e[0m""移除现有容器"
docker stop mysql-kooteam
docker rm mysql-kooteam


############################################ Exec #####################################
#执行运行脚本

#mysql
echo -e "\e[32m INFO: \e[0m""开始通过Docker部署mysql，如果本地私仓没有基础镜像，请耐心等待基础镜像的拉取...."

docker run --name ${mysql_name}  -p ${mysql_port}:3306 -e MYSQL_ROOT_PASSWORD=${mysql_pwd} \
-v /etc/localtime:/etc/localtime:ro \
-v ${mysql_mounts_path}:/var/lib/mysql \
--restart=always -d mysql:${mysql_version} \
--log-bin=mysql-bin --server_id=1 \
--max_connections=${mysql_maxConnections}

echo -e "\e[32m INFO: \e[0m""部署成功"
echo -e "\e[35;46m 实例名：${mysql_name}\e[0;0m"
echo -e "\e[34;42m 版本：${mysql_version} \e[0;0m"
echo -e "\e[31;43m 端口：${mysql_port} \e[0;0m"
echo -e "\e[41;37m 密码：${mysql_pwd} \e[0;0m"
echo -e "\e[45;30m 挂载：${mysql_mounts_path} \e[0;0m"

