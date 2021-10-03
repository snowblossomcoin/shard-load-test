# shard-load-test

The intent of this package is to allow people to easy to run Snowblossom clusters.

There are two modes, one where each node is on its own machine.

And the other mode where each node is a separate docker container on a single machine.

## Multinode cluster

The scripts for this are out of date.  Mostly because it was getting to be a pain and expensive
to run a bunch of GCP images.

## Single node cluster

This mode works well.  The nodes are separate, just like they are on their own hardware
but since they are on one machine it is easy to restart them all.  So a great deal of sharding
developement was done with this setup.

Setup:
  * Install docker
  * Add the directory 'single' to the path
  * Run "update.sh"

Other commands:
  * start.sh - start the cluster
  * stop.sh - stop the cluster
  * update.sh - stop, update docker image and start the cluster
  * nuke.sh - remove all docker volumes related to the cluster

### Parameters

You can change the cluster parameters by editing shard-settings.sh

The default configuration is to run a cluster with 4 nodes with a single group, a.

If desired, you can run multiple groups which run with their own pool miner and 
trust network.

### Observation:

You can attach to a general explore on HTTP port 80.  This node maintains visibility of all shards.

If running with the default config you can see the other nodes on ports:
* 10032 - node 3 - shard 3
* 10042 - node 4 - shard 4
* 10052 - node 5 - shard 5
* 10062 - node 6 - shard 6

At first, they will all show the same data but after the shards start they will show separate data
as they only track their own shards.


