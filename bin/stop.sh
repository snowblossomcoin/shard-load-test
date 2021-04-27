#!/bin/bash

stop-container.sh snow.node &
stop-container.sh snow.mine &
stop-container.sh snow.explore &
stop-container.sh snow.client &

wait

