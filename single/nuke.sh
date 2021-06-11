#!/bin/bash

set -eu

for group in $(cat $HOME/shardtest.groups)
do
  for shard in $(cat $HOME/shardtest.shards)
  do
    echo "Nuke $group $shard"

    docker volume rm snow.node.$group.$shard
    docker volume rm snow.mine.$group.$shard
  done
done

wait

