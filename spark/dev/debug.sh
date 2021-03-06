#!/bin/bash
this_dir=`dirname $0`

image_name=andy/spark:latest
container_name=spark-debugging

# docker ps -a | grep Exited | awk '{print $1}' | xargs docker rm -v
# docker images | grep none | awk '{print $3}' | xargs docker image rm

if [[ $1 == b ]]; then
	${this_dir}/build.sh
fi

docker stop  ${container_name}
docker rm -v ${container_name}
#docker run --rm -d --name ${container_name} andy/hadoop:latest
# docker run --rm -it -P --hostname ${container_name} --name ${container_name} $image_name /run.sh -bash

# docker run --rm -it --net=dockerhadoop_hadoop-net -P -e HADOOP_CONF_DATA="core:fs.defaultFS=hdfs://namenode-a:9000 yarn:yarn.resourcemanager.hostname=resourcemanager-a" --hostname spark-debugging --name spark-debugging andy/spark:latest /docker-spark/run.sh -bash
docker run --rm -it -p 4040:4040 -p 18080:18080 -P \
	-e SPARK_RUN_HISTORYSERVER="on" \
	--hostname spark-debugging --name spark-debugging \
	andy/spark:latest /docker-spark/run.sh -bash
