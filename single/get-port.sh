#!/bin/bash

if [ $# -ne 3 ]
then
  echo "syntax: $0 group shards service"
  exit 1
fi

group=$1
shard=$2
service=$3

port_str="2"

if [ $group == "a" ]
then
  port_str="${port_str}0"
fi
if [ $group == "b" ]
then
  port_str="${port_str}1"
fi
if [ $group == "c" ]
then
  port_str="${port_str}2"
fi
if [ $group == "d" ]
then
  port_str="${port_str}3"
fi
if [ $group == "e" ]
then
  port_str="${port_str}4"
fi

if [ $shard -lt 10 ]
then
  port_str="${port_str}0"
fi
port_str="${port_str}${shard}"

if [ $service == "node_tcp" ]
then
  port_str="${port_str}0"
fi
if [ $service == "node_tls" ]
then
  port_str="${port_str}1"
fi
if [ $service == "explorer" ]
then
  port_str="${port_str}2"
fi


echo $port_str



