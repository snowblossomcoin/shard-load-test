#!/bin/bash

docker pull snowblossom/snowshard

snow-node-start.sh e 0

snow-explore-start.sh testshard grpc+tls://localhost:2362/ 80


