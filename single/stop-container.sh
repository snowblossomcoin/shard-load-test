#!/bin/bash

. shard-settings.sh

n=$1
docker container stop $n
docker container rm $n

