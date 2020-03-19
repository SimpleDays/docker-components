#!/bin/bash

############################### Introduce #############################################
#介绍
#这是hexo出现崩溃无法修复之后，使用此脚本根据备份hexo的blog文件进行修复
#注意请把他和hexo.sh脚本放在一个目录下，原因是最后会调度hexo.sh
#如果在其他地方自行修改最后一行shell脚本代码
#一键运行

############################# Define ################################################
#定义基础配置参数

#指定出错容器名
hexo_name='hexo'

#当前挂载blog地址，指定到blog上级目录即可
hexo_current_path='/home/dongliang/mnt/hexo'

#备份文件地址，也是指定到blog上一级目录即可
hexo_back_path='/home/dongliang/mnt/hexo-empty-demo'

#是否要使用当前source
hexo_need_current_source="false"

#是否要使用当前的themes
hexo_need_current_themes="false"

#是否要替换当前hexo的配置文件_config.yml
hexo_need_current_config="false"

#执行脚本地址
hexo_shell_path='hexo.sh'


############################# Exec #################################################

#stop hexo container
echo -e "\e[32m INFO: \e[0m""暂停容器：${hexo_name}"
docker stop ${hexo_name}

#bak current hexo
echo -e "\e[32m INFO: \e[0m""临时备份当前hexo的blog至当前目录下，命名为：hexo-temp-bak"
mv ${hexo_current_path} ./hexo-temp-bak

#restore hexo
echo -e "\e[32m INFO: \e[0m""还原之前备份的hexo配置，还原路径为：${hexo_back_path}"
cp -rf ${hexo_back_path} ${hexo_current_path}

#restore source
if [ ${hexo_need_current_source} == 'true' ]
then
    echo -e "\e[32m INFO: \e[0m""使用当前source配置"
	rm -rf ${hexo_current_path}/blog/source
	cp -rf hexo-temp-bak/blog/source ${hexo_current_path}/blog/source
fi

#restore themes
if [ ${hexo_need_current_themes} == 'true' ]
then
	echo -e "\e[32m INFO: \e[0m""使用当前themes配置"
	rm -rf ${hexo_current_path}/blog/themes
	cp -rf hexo-temp-bak/blog/themes ${hexo_current_path}/blog/themes
fi

#restore _config.yml
if [ ${hexo_need_current_config} == 'true' ]
then
	echo -e "\e[32m INFO: \e[0m""使用当前config配置"
	rm -rf ${hexo_current_path}/blog/_config.yml
	cp -rf hexo-temp-bak/blog/_config.yml ${hexo_current_path}/blog/_config.yml
fi

#rm hexo-temp-bak
echo -e "\e[32m INFO: \e[0m""移除临时备份文件hexo-temp-bak"
rm -rf hexo-temp-bak

#run new hexo shell
echo -e "\e[32m INFO: \e[0m""重新执行部署脚本，执行 sh ${hexo_shell_path}"
sh ${hexo_shell_path}
