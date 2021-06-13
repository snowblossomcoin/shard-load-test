#!/bin/bash

docker pull snowblossom/snowshard
docker pull repo.1209k.com/1209k/snowshard

cd ~/shard-load-test.git
git pull
stop.sh

start.sh




