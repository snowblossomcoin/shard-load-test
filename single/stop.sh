
set -eu

. shard-settings.sh

stop-container.sh snow.node.z.0 &
stop-container.sh snow.explore.z.0 &

for group in $(cat $HOME/shardtest.groups)
do
  for shard in $(cat $HOME/shardtest.shards)
  do
    echo "Stopping $group $shard"

    stop-container.sh snow.node.$group.$shard &
    stop-container.sh snow.explore.$group.$shard &
    stop-container.sh snow.mine.$group.$shard &
    stop-container.sh snow.client.$group.$shard &
  done
done

wait

