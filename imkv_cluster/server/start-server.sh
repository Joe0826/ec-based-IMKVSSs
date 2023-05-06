#!/bin/bash

SLEEP_TIME=2
ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start
sleep ${SLEEP_TIME}
#

SERVER_NAME=$(hostname)
SERVER_IP=$(hostname -I | xargs)
SERVER_PORT=9111
CONFIG_PATH=../config

STORAGE_PATH=/home/xcq/tmp/${SERVER_NAME}

screen -dmS ser
screen -dmS ethtool

screen -r ser -p 0 -X stuff "./server -v -p ${CONFIG_PATH} -o storage path ${STORAGE_PATH} -o server ${SERVER_NAME} tcp://${SERVER_IP}:${SERVER_PORT}$(printf '\r')"
tail -f /dev/null
