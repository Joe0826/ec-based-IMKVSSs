#!/bin/bash

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start

PROXY_NAME=$(hostname)
PROXY_IP=$(hostname -I | xargs)
PROXY_PORT=9112
CONFIG_PATH=../config/

SLEEP_TIME=5s
sleep ${SLEEP_TIME}

echo "Starting client [${PROXY_NAME}]..."

screen -dmS pro
screen -dmS ycsb

screen -S pro -p 0  -X stuff "./client -v -p ${CONFIG_PATH} -o client ${PROXY_NAME} tcp://${PROXY_IP}:${PROXY_PORT}"$'\n'
tail -f /dev/null
