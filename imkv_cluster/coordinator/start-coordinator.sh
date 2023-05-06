#!/bin/bash

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start

COOR_NAME=$(hostname)
COOR_IP=$(hostname -I | xargs)
COOR_PORT=9110
CONFIG_PATH=../config/

echo "Starting coordinator [${COOR_NAME}]..."

screen -dmS coo

screen -S coo -p 0 -X stuff "./coordinator -v -p ${CONFIG_PATH} -o coordinator ${COOR_NAME} tcp://${COOR_IP}:${COOR_PORT}"$'\n'
tail -f /dev/null