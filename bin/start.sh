#!/bin/bash

host=$(hostname)

if [ "$host" = "seed" ]
then
  start-seed.sh
  exit 0
fi


base=$(echo $host|cut -d "-" -f 1)
group=$(echo $host|cut -d "-" -f 3)
shard=$(echo $host|cut -d "-" -f 2)

echo "Base: $base"
echo "Group: $group"
echo "Shard: $shard"

if [ "$base" = "node" ]
then
  start-group.sh $group $shard
  start-client.sh a $shard
  start-client.sh b $shard
  start-client.sh c $shard
  start-client.sh d $shard
fi

