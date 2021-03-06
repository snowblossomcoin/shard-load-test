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

tag="snow.client.$group"

wallet_vol="$HOME/shard-load-test.git/loadclients/client.${group}"

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx1g" \
  -e snowblossom_network=$network \
  -e snowblossom_node_uri=$uri \
  -e snowblossom_wallet_path=/wallet \
  -e snowblossom_seed_gap=0 \
  -e snowblossom_preferred_shard=$shard \
  -e snowblossom_loadtest_send_rate=4 \
  -v $wallet_vol:/wallet $image client loadtest_shard

