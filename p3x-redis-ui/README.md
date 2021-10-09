# p3x-redis-ui

## 介绍

p3x-redis-ui是一款非常实用的redis数据库GUI, 可以作为响应式的网站或者一个桌面app。  
官网：https://corifeus.com/redis-ui  
github地址：https://github.com/patrikx3/redis-ui  
dockerhub地址：https://hub.docker.com/r/patrikx3/p3x-redis-ui   

## 使用感受

1、我是通过docker镜像去部署使用的。  
2、web界面简洁明了，无需登录，没有权限控制功能  
3、基于第二点，我认为可以通过nginx等代理自行控制权限等  

## 脚本说明

> p3x-redis-ui.sh : 启动redis-ui的脚本  

> ng： nginx容器代理redis-ui的脚本，先build.sh脚本去构建nginx镜像，然后通过run.sh创建redis-ui的代理