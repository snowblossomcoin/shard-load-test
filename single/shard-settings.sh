
group_list="a"

node_list="3 4 5 6"

seed_shard=0

load_test_rate=1

miner_rate=8000

image=snowblossom/snowblossom

ram="-Xms6g -Xmx6g"

seed_ram="-Xms8g -Xmx8g"

network=demoshard

if which shard-settings.local.sh >> /dev/null
then
  . shard-settings.local.sh
fi

