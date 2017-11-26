#!/bin/bash
this_dir=`dirname $0`

image_name=andy/hadoop-nodemanager:latest
container_name=nodemanager-debugging

# docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm -v
# docker images | grep none | awk '{print $3}' | xargs docker image rm

if [[ $1 == b ]]; then
	${this_dir}/build.sh
fi

docker stop  ${container_name}
docker rm -v ${container_name}
#docker run --rm -d --name ${container_name} andy/hadoop:latest
# docker run --rm -it -P --hostname ${container_name} --name ${container_name} $image_name /run.sh -bash

docker run --rm -it --net=dockerhadoop_hadoop-net -p 8042:8042 -P -e HADOOP_CONF_DATA="yarn:yarn.resourcemanager.hostname=resourcemanager-a" --hostname nodemanager-debugging --name nodemanager-debugging andy/hadoop-nodemanager:latest /docker-hadoop-nodemanager/run.sh -bash