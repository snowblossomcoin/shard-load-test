#!/bin/bash

image=snowblossom/snowshard

if [ $# -lt 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2

network=testshard
node_tls=$(get-port.sh $group $shard node_tls)
uri=grpc+tls://localhost:${node_tls}/

tag="snow.client.$group.$shard"

wallet_vol="$HOME/shard-load-test.git/loadclients/client.${group}"

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx1g" \
  -e snow_client_network=$network \
  -e snow_client_node_uri=$uri \
  -e snow_client_wallet_path=/wallet \
  -e snow_client_seed_gap=0 \
  -e snow_client_preferred_shard=$shard \
  -e snow_client_loadtest_send_rate=1 \
  -v $wallet_vol:/wallet $image client loadtest_shard

