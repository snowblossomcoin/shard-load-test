#!/bin/bash

. shard-settings.sh
if [ $# -lt 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2

node_tls=$(get-port.sh $group $shard node_tls)
uri=grpc+tls://localhost:$node_tls/
address=$(cat ~/shard-load-test.git/loadclients/${network}/client.${group}/address.txt)
tag="snow.mine.$group.$shard"

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx512m" \
  -e snowblossom_network=$network \
  -e snowblossom_node_uri=$uri \
  -e snowblossom_mine_to_address=$address \
  -e snowblossom_rate_limit=$miner_rate \
  -e snowblossom_remark=$tag \
  -v $tag:/data $image solominer

