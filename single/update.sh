#!/bin/bash

. shard-settings.sh

docker pull $image

cd ~/shard-load-test.git
git pull
stop.sh

start.sh




