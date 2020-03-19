#!/bin/bash

############################### Introduce #############################################
#介绍
#hexo是我选择的自己开源的博客框架
#
#关于hexo
#hexo是一个快速、简洁且高效的博客框架，有大量成熟的主题与个人博客所需要插件，丰富的文档满足各种需求。
#通过提交markdown类型文章可以有效的渲染出美观的页面
#
#我是用hexo并且选择了next主题
#
#hexo官网：https://hexo.io/zh-cn/
#next主题：https://github.com/iissnan/hexo-theme-next

############################# Define ################################################
#定义基础配置参数

#实例名称
hexo_name='hexo'

#挂载博客与相关hexo配置文件
#我博客已经被我调整好，里面是一个调整完毕最初的样子可以参考使用，如若不喜欢就不需要拷贝
#容器启动时候会检测挂载下是否存在配置，没有会去拉取
#当然我也提供了一个拉取下来的demo空配置可以挂载
hexo_mounts_path='/home/dongliang/mnt/hexo/blog'

#端口配置
hexo_port=4000



echo -e "\e[32m INFO: \e[0m""移除现有容器"

docker stop hexo
docker rm hexo

echo -e "\e[32m INFO: \e[0m""开始通过Docker部署hexo，如果本地私仓没有基础镜像，请耐心等待基础镜像的拉取...."

docker run --restart=always -d \
-p ${hexo_port}:4000 -v ${hexo_mounts_path}:/blog \
--name=${hexo_name} yoshikazum/hexo

echo -e "\e[32m INFO: \e[0m""部署成功"
echo -e "\e[35;46m 实例名：${hexo_name}\e[0;0m"
echo -e "\e[31;43m 端口：${hexo_port} \e[0;0m"
echo -e "\e[45;30m 挂载：${hexo_mounts_path} \e[0;0m"
