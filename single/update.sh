#!/bin/bash

docker pull snowblossom/snowshard
cd ~/shard-load-test.git
git pull
stop.sh

start.sh




