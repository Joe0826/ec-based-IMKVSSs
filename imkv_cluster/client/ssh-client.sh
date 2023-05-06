#!/bin/bash

ssh-keygen -t rsa -N '' -f ~/.ssh/id_rsa && touch ~/.ssh/authorized_keys
sudo /etc/init.d/ssh start