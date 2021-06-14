
. shard-settings.sh
if [ $# -ne 2 ]
then
  echo "syntax: $0 group shards"
  exit 1
fi

group=$1
shard=$2

snow-node-start.sh $group $shard
snow-explore-start.sh $group $shard

