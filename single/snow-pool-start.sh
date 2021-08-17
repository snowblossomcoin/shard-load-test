#!/bin/bash

. shard-settings.sh
if [ $# -ne 1 ]
then
  echo "syntax: $0 group"
  exit 1
fi

group=$1

pool_port=$(get-port.sh $group 0 pool)
pool_rpc_port=$(get-port.sh $group 0 pool_rpc)

tag="snow.pool.$group"
node_uri=""
for shard in $node_list
do
  p=$(get-port.sh $group $shard node_tls)
  node_uri="${node_uri}grpc+tls://localhost:${p}/,"
done

address=$(cat ~/shard-load-test.git/loadclients/client.${group}/address.txt)

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx2g -Xms2g" \
  -e snow_pool_network=$network \
  -e snow_pool_node_uri=$node_uri \
  -e snow_pool_mining_pool_port=$pool_port \
  -e snow_pool_rpc_port=$pool_rpc_port \
  -e snow_pool_pool_fee=0.005 \
  -e snow_pool_pool_address=$address \
  -e snow_pool_db_type=atomic_file \
  -e snow_pool_db_path=/data/pool.db \
  -e snow_pool_remark=$tag \
  -e snow_pool_min_diff=15 \
  -v $tag:/data $image pool

