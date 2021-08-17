#!/bin/bash

. shard-settings.sh
if [ $# -lt 1 ]
then
  echo "syntax: $0 group"
  exit 1
fi

group=$1

node_port=$(get-port.sh $group 0 pool)
address=$(cat ~/shard-load-test.git/loadclients/client.${group}/address.txt)
tag="snow.poolmine.$group"

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx512m" \
  -e snow_miner_network=$network \
  -e snow_miner_pool_host=localhost \
  -e snow_miner_pool_port=$node_port \
  -e snow_miner_mine_to_address=$address \
  -e snow_miner_rate_limit=$miner_rate \
  -v $tag:/data $image poolminer

