#!/bin/bash

image=snowblossom/snowshard


if [ $# -ne 2 ]
then
  echo "syntax: $0 group shards"
  exit 1
fi

group=$1
shards=$2


network=testshard

tag="snow.node"

port=2361
tls_port=$(($port+1))


trust_vol="$HOME/shard-load-test.git/trustkey/trustkey.${group}"
trust_addr=$(cat ~/shard-load-test.git/trustkey/trustkey.${group}/address.txt)

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx8g" \
  -e snow_node_network=$network \
  -e snow_node_service_port=$port \
  -e snow_node_tls_service_port=$tls_port \
  -e snow_node_shards=$shards \
  -e snow_node_trustnet_key_path=/data/trust \
  -e snow_node_trustnet_signers=${trust_addr} \
  -v $trust_vol:/data/trust \
  -v $tag:/data $image
