#!/bin/bash

image=snowblossom/snowshard

network=$1
uri=$2
port=$3

if [ $# -lt 3 ]
then
  echo "syntax: $0 network uri port"
  exit 1
fi

tag="snow.explore"

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx4g" \
  -e snow_explorer_network=$network \
  -e snow_explorer_node_uri=$uri \
  -e snow_explorer_port=$port \
  -v $tag:/data $image explorer


