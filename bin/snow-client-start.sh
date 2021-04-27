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
  -e snow_client_network=$network \
  -e snow_client_node_uri=$uri \
  -e snow_client_wallet_path=/wallet \
  -e snow_client_seed_gap=0 \
  -e snow_client_preferred_shard=$shard \
  -v $wallet_vol:/wallet $image client loadtest_shard

