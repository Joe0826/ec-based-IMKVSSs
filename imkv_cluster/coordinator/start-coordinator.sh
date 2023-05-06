#!/bin/bash

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start

COOR_NAME=$(hostname)
COOR_IP=$(hostname -I | xargs)
COOR_PORT=9110
CONFIG_PATH=../config/

echo "Starting coordinator [${COOR_NAME}]..."

screen -dmS coo
#本来是开启容器启动，现在尝试改成远程启动
screen -S coo -p 0 -X stuff "./coordinator -v -p ${CONFIG_PATH} -o coordinator ${COOR_NAME} tcp://${COOR_IP}:${COOR_PORT}"$'\n'
tail -f /dev/null



#screen -S coordinator -p 0 -X stuff \"./coordinator -v -p ${CONFIG_PATH} -o coordinator ${COOR_NAME} tcp://${COOR_IP}:${COOR_PORT} $(printf '\r\r')\"
#./coordinator -v -p ../config/ -o coordinator $(hostname) tcp://$(hostname -I | xargs):9110
# 目前证明下来必须拆成两行
# ; exec bash
