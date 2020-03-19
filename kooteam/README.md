# Kooteam

## 介绍

项目 kooteam 是一款轻量级的在线团队协作工具，提供各类文档工具、在线思维导图、在线流程图、项目管理、任务分发，知识库管理等工具。  

官网 <https://www.kooteam.com/>

项目地址：<https://gitee.com/sinbo/kooteam> （只开源了后端，并没有全部开源）

安装教程：<https://www.kooteam.com/view.html?id=5e5893b9c687557cc87e38c3>

## 使用感受

1、本人是被其"四象限"工作任务界面与知识库所吸引才开始使用的。  
2、对于个人工作而言私下生活都可以使用，如若想用于团队建设上。  
3、个人觉得3-5人团队还能勉强使用，人多了还是建议使用开源的 禅道，亦或者 收费的 jira与confluence 或者 worktile 、trello等。  
4、我是使用在个人生活规划上面的，工作上也会规划使用挺方便的。  
5、槽点： 这服务的bug很多，并没有想象的那么好用。

## 如何使用

2个脚本(mysql.sh与kooteam.sh)  
基础镜像：huangxinping/kooteam  

### 步骤如下  

1、先部署mysql提供基础配置。  
2、mysql.sh里面提供一些基础配置进行简单配置，然后启动部署容器。  
3、建立基础库kooteam，提供单独用户名kooteam和密码。  
4、kooteam.sh进行挂载配置和端口配置，然后启动容器。  
5、打开kooteam的web，进行初始化配置，并且登录即可正常使用。  

## 创建脚本

//创建库  
CREATE DATABASE kooteam DEFAULT CHARACTER set utf8mb4 COLLATE utf8mb4_general_ci;  
//创建用户  
CREATE USER  'kooteam'@'%' IDENTIFIED BY '123456';  
//授权  
GRANT select,update,delete,insert ON  kooteam.*  TO  'kooteam';
