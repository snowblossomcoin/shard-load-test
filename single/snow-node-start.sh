#!/bin/bash

. shard-settings.sh
if [ $# -ne 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2


tag="snow.node.$group.$shard"

node_tls=$(get-port.sh $group $shard node_tls)
node_tcp=$(get-port.sh $group $shard node_tcp)

trust_vol="$HOME/shard-load-test.git/trustkey/${network}/trustkey.${group}"
trust_addr=$(cat ~/shard-load-test.git/trustkey/${network}/trustkey.${group}/address.txt)

extra_ops=""

if [ "$group" == "z" ]
then
  for g in a b c d
  do
    trust_addr=$trust_addr,$(cat ~/shard-load-test.git/trustkey/${network}/trustkey.${g}/address.txt)
  done

  echo "Seed trust: $trust_addr"
  extra_ops="-e snowblossom_mempool_reject_p2p_tx=true"
  ram="$seed_ram"

fi

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="$ram" \
  -e snowblossom_network=$network \
  -e snowblossom_service_port=$node_tcp \
  -e snowblossom_tls_service_port=$node_tls \
  -e snowblossom_shards=$shard \
  -e snowblossom_trustnet_key_path=/data/trust \
  -e snowblossom_trustnet_signers=${trust_addr} \
  -e snowblossom_seed_uris=grpc+tls://localhost/ \
  ${extra_ops} \
  -v $trust_vol:/data/trust \
  -v $tag:/data $image


