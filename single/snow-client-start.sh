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
uri=grpc+tls://localhost:${node_tls}/

tag="snow.client.$group.$shard"

wallet_vol="$HOME/shard-load-test.git/loadclients/${network}/client.${group}"
docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx256m" \
  -e snowblossom_network=$network \
  -e snowblossom_node_uri=$uri \
  -e snowblossom_wallet_path=/wallet \
  -e snowblossom_seed_gap=0 \
  -e snowblossom_preferred_shard=$shard \
  -e snowblossom_loadtest_send_rate=$load_test_rate \
  -v $wallet_vol:/wallet \
  -v $tag:/data $image client loadtest_shard

