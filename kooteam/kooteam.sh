#!/bin/bash

############################### Introduce #############################################
#介绍
#项目 kooteam 是一款轻量级的在线团队协作工具，提供各类文档工具、在线思维导图、在线流程图、项目管理、任务分发，知识库管理等工具。
#官网 https://www.kooteam.com/
#项目地址：https://gitee.com/sinbo/kooteam （只开源了后端，并没有全部开源）
#安装教程：https://www.kooteam.com/view.html?id=5e5893b9c687557cc87e38c3
#使用感受：本人是被其"四象限"工作任务界面与知识库所吸引才开始使用的。
#对于个人工作而言私下生活都可以使用，如若想用于团队建设上。
#个人觉得3-5人团队还能勉强使用，人多了还是建议使用开源的 禅道，亦或者 收费的 jira与confluence 或者 worktile 、trello等
#我是使用在个人生活规划上面的，工作上也会规划使用挺方便的
#槽点： 这服务的bug很多，并没有想象的那么好用。

############################## PreCondition ##########################################
#安装之前的前置条件
#先安装好mysql服务器，因为第一次会初始化配置，主要还是配置存储，支持mysql与mognodb
#我使用的是mysql

############################# Define ################################################
#定义基础配置参数

#上传图片资源的挂载
kooteam_mounts_path='/home/dongliang/mnt/kooteam/upload'

#实例名称
kooteam_name='kooteam'

#docker-link配置，主要还是同一个宿主机配置mysql与kooteam所以希望通过name来访问呢其他容器，方便通信
#如果你是在不同机器上可以忽略这条并把执行上的这行注释  --link 那段
kooteam_mysql_link='mysql-kooteam'

#端口-默认7053
kooteam_port=7053

############################# Exec #################################################

#remove docker container
echo -e "\e[32m INFO: \e[0m""移除现有容器"
docker stop kooteam
docker rm -f kooteam

echo -e "\e[32m INFO: \e[0m""开始通过Docker部署kooteam，如果本地私仓没有基础镜像，请耐心等待基础镜像的拉取...."

docker run --restart=always -d -p ${kooteam_port}:7053 \
-v ${kooteam_mounts_path}:/res/upload \
--name ${kooteam_name} \
--link ${kooteam_mysql_link}:${kooteam_mysql_link} \
huangxinping/kooteam

echo -e "\e[32m INFO: \e[0m""部署成功"
echo -e "\e[35;46m 实例名：${kooteam_name}\e[0;0m"
echo -e "\e[31;43m 端口：${kooteam_port} \e[0;0m"
echo -e "\e[45;30m 挂载：${kooteam_mounts_path} \e[0;0m"
