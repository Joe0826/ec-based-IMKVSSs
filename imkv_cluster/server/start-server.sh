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

#
#sudo rm -rf /tmp/*
#
#if [ -d ${TMP_PATH} ]; then
#   echo "Storage dir exists";
#   sudo rm -rf /tmp/*
#else
#  echo "Create storage dir";
#sudo mkdir -p ${TMP_PATH}/memec/;
#  sudo mount -t ramfs -o size=${SIZE} ramfs ${TMP_PATH};
#  echo "This is success!!!"
#fi


STORAGE_PATH=/home/xcq/tmp/${SERVER_NAME}

#echo "Starting server [${SERVER_NAME}]..."
#sudo rm -rf ${STORAGE_PATH}
#echo "success rm ${STORAGE_PATH}"
#sudo mkdir -p ${STORAGE_PATH}
#echo "success mkdir ${STORAGE_PATH}"
#sudo chown xcq:xcq ./tmp/memec
#sudo chown xcq:xcq ${STORAGE_PATH}
screen -dmS ser
screen -dmS ethtool

#本来是开启容器启动，现在尝试改成远程启动
screen -r ser -p 0 -X stuff "./server -v -p ${CONFIG_PATH} -o storage path ${STORAGE_PATH} -o server ${SERVER_NAME} tcp://${SERVER_IP}:${SERVER_PORT}$(printf '\r')"
tail -f /dev/null
