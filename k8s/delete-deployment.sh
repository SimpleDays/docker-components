#!/bin/bash
#用于应急批量删除某个命名空间下绝大部分部署
#遇到问题因资源问题导致整个K8s环境不稳定 
#在没有足够资源下 删除绝大部分资源 保留部分 可用资源的脚本
#有需要可以随时修改

#需要排除的服务关键字
monitor="monitor"
mesh="mesh"
apollo="apollo"

#指定命名空间
namespace="dev"

for i in `kubectl get deployment -n $namespace  | awk '{print $1}'`
do
	if [[ $i != *$monitor* ]] && [[ $i != *$mesh* ]] && [[ $i != *$apollo* ]] && [[ $i != "NAME" ]]
	then
		echo "deployment ：[" $i "] must be delete！"
		kubectl delete deployment -n $namespace $i
	fi
done
