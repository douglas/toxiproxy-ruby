#!/bin/bash -e

VERSION='v2.0.0rc2'
TOXIPROXY_LOG_DIR=${CIRCLE_ARTIFACTS:-'/tmp'}

echo "[start toxiproxy]"
curl --silent -L https://github.com/Shopify/toxiproxy/releases/download/$VERSION/toxiproxy-server-linux-amd64 -o ./bin/toxiproxy-server
chmod +x ./bin/toxiproxy-server
nohup bash -c "./bin/toxiproxy-server > ${TOXIPROXY_LOG_DIR}/toxiproxy.log 2>&1 &"
