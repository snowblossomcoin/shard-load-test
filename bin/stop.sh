#!/bin/bash

stop-container.sh snow.node &
stop-container.sh snow.mine &
stop-container.sh snow.mine.a &
stop-container.sh snow.mine.b &
stop-container.sh snow.mine.c &
stop-container.sh snow.mine.d &
stop-container.sh snow.explore &
stop-container.sh snow.client &
stop-container.sh snow.client.a &
stop-container.sh snow.client.b &
stop-container.sh snow.client.c &
stop-container.sh snow.client.d &

wait

