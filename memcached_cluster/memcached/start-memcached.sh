#!/bin/bash

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa <<< y
touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start

IP=$(hostname -I | xargs)
PORT=11211
HOST_NAME=$(hostname)

echo "Starting ${HOST_NAME} memcached"
screen -dmS memc
screen -S memc -p 0 -X stuff "memcached -d -m 2048 -u xcq -l $IP -p 11211"$'\n'
tail -f /dev/null