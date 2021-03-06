#!/bin/bash

this_dir=`dirname $0`
image_name="andy/hadoop-datanode"

if [[ $1 == "clean" ]]; then
  docker image rm $image_name:latest $image_name:2.8.2
else
  docker build -t $image_name $this_dir/.. --build-arg http_proxy=${http_proxy} --build-arg https_proxy=${https_proxy}
  docker tag $image_name:latest $image_name:2.8.2
fi