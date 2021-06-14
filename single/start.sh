#!/bin/bash

set -eu
. shard-settings.sh

start-group.sh z $seed_shard

for group in $group_list
do
  for shard in $node_list
  do
    echo "Starting $group $shard"
    start-group.sh $group $shard
    start-client.sh $group $shard
  done
done

