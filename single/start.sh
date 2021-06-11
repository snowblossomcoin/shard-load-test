#!/bin/bash

set -eu

for group in $(cat $HOME/shardtest.groups)
do
  for shard in $(cat $HOME/shardtest.shards)
  do
    echo "Starting $group $shard"
    start-group.sh $group $shard
    start-client.sh $group $shard
  done
done

