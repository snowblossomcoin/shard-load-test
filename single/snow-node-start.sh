
. shard-settings.sh
if [ $# -ne 2 ]
then
  echo "syntax: $0 group shard"
  exit 1
fi

group=$1
shard=$2

network=testshard

tag="snow.node.$group.$shard"

node_tls=$(get-port.sh $group $shard node_tls)
node_tcp=$(get-port.sh $group $shard node_tcp)

trust_vol="$HOME/shard-load-test.git/trustkey/trustkey.${group}"
trust_addr=$(cat ~/shard-load-test.git/trustkey/trustkey.${group}/address.txt)

docker volume create $tag

docker run -d --restart always --name $tag --network host \
  -e SNOWBLOSSOM_JAVA_OPTIONS="-Xmx4g" \
  -e snow_node_network=$network \
  -e snow_node_service_port=$node_tcp \
  -e snow_node_tls_service_port=$node_tls \
  -e snow_node_shards=$shard \
  -e snow_node_trustnet_key_path=/data/trust \
  -e snow_node_trustnet_signers=${trust_addr} \
  -v $trust_vol:/data/trust \
  -v $tag:/data $image

