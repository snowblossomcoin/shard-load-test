
. shard-settings.sh
if [ $# -lt 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2
network=testshard

node_tls=$(get-port.sh $group $shard node_tls)
uri=grpc+tls://localhost:$node_tls/
address=$(cat ~/shard-load-test.git/loadclients/client.${group}/address.txt)
tag="snow.mine.$group.$shard"

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx1g" \
  -e snow_miner_network=$network \
  -e snow_miner_node_uri=$uri \
  -e snow_miner_mine_to_address=$address \
  -e snow_miner_rate_limit=2000 \
  -e snow_miner_remark=$tag \
  -v $tag:/data $image solominer

