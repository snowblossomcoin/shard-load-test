#!/bin/bash

. shard-settings.sh
if [ $# -ne 1 ]
then
  echo "syntax: $0 group"
  exit 1
fi

group=$1

snow-pool-start.sh $group
snow-pool-miner-start.sh $group



