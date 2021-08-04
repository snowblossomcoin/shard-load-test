#!/bin/bash

set -eu

. shard-settings.sh

stop-container.sh snow.node.z.$seed_shard &
stop-container.sh snow.explore.z.$seed_shard &

for group in $group_list
do
  stop-container.sh snow.pool.$group &
  stop-container.sh snow.poolmine.$group &
  for shard in $node_list
  do
    echo "Stopping $group $shard"

    stop-container.sh snow.node.$group.$shard &
    stop-container.sh snow.explore.$group.$shard &
    stop-container.sh snow.mine.$group.$shard &
    stop-container.sh snow.client.$group.$shard &
  done
done

wait

