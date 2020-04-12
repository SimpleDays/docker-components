#!/bin/bash
#用于应急批量删除某个命名空间下满足要求的Pod
#有需要可以随时修改

#需要排除的服务关键字
monitor="monitor"
mesh="mesh"
apollo="apollo"

#指定命名空间
namespace="dev"

for i in `kubectl get pods -n $namespace  | awk '{print $1}'`
do
	if [[ $i != *$monitor* ]] && [[ $i != *$mesh* ]] && [[ $i != *$apollo* ]] && [[ $i != "NAME" ]]
	then
	    echo -e "\e[1;32m pod ：[" $i "] start delete \e[0m"
		kubectl delete pod -n $namespace $i
		echo -e "\e[1;32m pod ：[" $i "] delete success \e[0m"
	fi
done
