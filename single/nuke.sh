#!/bin/bash

docker volume rm snow.node.z.0
docker volume rm snow.explore.z.0

for group in $(cat $HOME/shardtest.groups)
do
  for shard in $(cat $HOME/shardtest.shards)
  do
    echo "Nuke $group $shard"

    docker volume rm snow.node.$group.$shard
    docker volume rm snow.mine.$group.$shard
    docker volume rm snow.explore.$group.$shard
    docker volume rm snow.client.$group.$shard
  done
done

wait

