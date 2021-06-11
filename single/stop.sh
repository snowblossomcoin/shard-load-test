#!/bin/bash

set -eu

for group in $(cat $HOME/shardtest.groups)
do
  for shard in $(cat $HOME/shardtest.shards)
  do
    echo "Stopping $group $shard"

    stop-container.sh snow.node.$group.$shard &
    stop-container.sh snow.explore.$group.$shard &
    stop-container.sh snow.mine.$group.$shard &
    stop-container.sh snow.client.$group.$shard &
  done
done

wait

