#!/bin/bash

image=snowblossom/snowshard


network=testshard
uri=grpc+tls://localhost/

if [ $# -lt 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2
address=$(cat ~/shard-load-test.git/loadclients/client.${group}/address.txt)
tag="snowmine.$group.$shard"

docker volume create $tag

docker run -d --restart always --name snow.mine.$group --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx1g" \
  -e snowblossom_network=$network \
  -e snowblossom_node_uri=$uri \
  -e snowblossom_mine_to_address=$address \
  -e snowblossom_rate_limit=2000 \
  -e snowblossom_remark=$tag \
  -v $tag:/data $image solominer

