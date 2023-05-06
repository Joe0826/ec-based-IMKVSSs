#!/bin/bash

t=16
w=$1

ROOT_PATH=/home/xcq/imkv/degraded

if [ $w == "load" ]; then
  echo "-------------ycsb load ( `date` )--------"
  ${ROOT_PATH}/singleload.sh $t 2>&1 | tee -a ${ROOT_PATH}/load_$(date '+%Y-%m-%d_%H-%M-%S').txt

else
   echo "-------------ycsb $w ( `date` )--------"
   ${ROOT_PATH}/singlerun.sh $t $w 2>&1 | tee -a ${ROOT_PATH}/run_$(date '+%Y-%m-%d_%H-%M-%S').txt
fi

