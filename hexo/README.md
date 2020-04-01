# Hexo

## 介绍

hexo是我选择的自己开源的博客框架,博客地址： <http://47.98.210.153:4000>  
hexo是一个快速、简洁且高效的博客框架，有大量成熟的主题与个人博客所需要插件，丰富的文档满足各种需求。  
通过提交markdown类型文章可以有效的渲染出美观的页面。  

## 主题选择

我是用hexo并且选择了next主题。  

**hexo官网：** <https://hexo.io/zh-cn/>  
**next主题：** <https://github.com/iissnan/hexo-theme-next>

## 我的博客起名想法与寓意

博客名字 **鴻儒小站**  
鴻： ”大“的意思  
儒： 泛指博闻多学之人  
寓意：希望自己学习点滴记录下来能让自己知识面拓宽，增长见识，变成一位博学多闻的人。

博客网站图标为一个**小帆船**  
寓意： 借唐代**李白**的**早发白帝城**的诗句 “轻舟已过万重山”启发而得 ，告诫自己不管在事业上或者在生活中遇到艰难险阻，自己能够调整心态如坐这小小泛舟一般愉悦的穿越过去，坚持下去。

## 部署说明

### 1、脚本说明

**hexo.sh :** 通过docker启动的脚本，选择了 **yoshikazum/hexo** 作为基础镜像。  

**hexo-fix.sh :** 根据备份挂载blog文件修复脚本，配置好参数一键备份比较方便。  

**hexo-empty-demo :** Hexo初始安装好需要自动下载默认主题和配置，有懒得等待下载的可以直接用这个blog进行挂载。  

**hexo-next-bak :** 我自己的主题配置，方便快速恢复使用，有喜欢的朋友也可以加载使用。  

### 注 ： 在启动脚本前进入看下脚本内的配置参数是否满足要求，然后再启动

### 2、Hexo-next主题下本地搜索配置

#### 进入容器  

```# docker exec -it hexo /bin/bash```

#### 安装search-db

```# npm install hexo-generator-searchdb --save```

#### 编辑Hexo站点配置（hexo根目录下的_config.yml文件）

在配置文件下新增如下代码：  

``` yml
search:
  path: search.xml
  field: post
  format: html
  limit: 10000

```

#### 编辑next主题下的配置文件

在配置文件下设置启用

``` yml
# Local search
local_search:
  enable: true
```

## 说明

备份文件：  

**hexo-next-bak-20200401.tar ：** 带有评论、seo的主题备份
