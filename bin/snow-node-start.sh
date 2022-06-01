#!/bin/bash

image=snowblossom/snowshard


if [ $# -ne 2 ]
then
  echo "syntax: $0 group shards"
  exit 1
fi

group=$1
shards=$2

mempool_reject_p2p_tx=false

# The seed node doesn't want a bunch of mempool cloggers
if [ "$shards" = "0" ]
then
  mempool_reject_p2p_tx=true
fi

network=testshard

tag="snow.node"

port=2361
tls_port=$(($port+1))


trust_vol="$HOME/shard-load-test.git/trustkey/trustkey.${group}"
trust_addr=$(cat ~/shard-load-test.git/trustkey/trustkey.${group}/address.txt)

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx4g" \
  -e snowblossom_network=$network \
  -e snowblossom_service_port=$port \
  -e snowblossom_tls_service_port=$tls_port \
  -e snowblossom_shards=$shards \
  -e snowblossom_trustnet_key_path=/data/trust \
  -e snowblossom_trustnet_signers=${trust_addr} \
  -e snowblossom_mempool_reject_p2p_tx=${mempool_reject_p2p_tx} \
  -v $trust_vol:/data/trust \
  -v $tag:/data $image

