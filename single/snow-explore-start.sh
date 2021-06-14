#!/bin/bash

. shard-settings.sh
if [ $# -ne 2 ]
then
  echo "syntax: $0 group shards"
  exit 1
fi

group=$1
shard=$2
network=testshard

node_tls=$(get-port.sh $group $shard node_tls)
port=$(get-port.sh $group $shard explorer)

tag="snow.explore.$group.$shard"
uri="grpc+tls://localhost:${node_tls}/"

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx1g" \
  -e snow_explorer_network=$network \
  -e snow_explorer_node_uri=$uri \
  -e snow_explorer_port=$port \
  -v $tag:/data $image explorer


