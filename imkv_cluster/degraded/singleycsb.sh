#!/bin/bash

workloads='workload1'
DEGRADED_PATH=/home/xcq/imkv/degraded
delays='2.0'
for delay in $delays; do

  for iter in 1; do
  echo "******************** Iteration #$iter ( `date` ) ********************"

    echo "-------------------- Load #$iter-------------------"       # for i in {0..3}; do

#    for i in 0;do
#      sshpass -p 'xcq' ssh xcq@172.19.0.2${i} "screen -S ycsb -p 0 -X stuff \" cd /home/xcq/imkv/ycsb $(printf '\r')\""
#      #sshpass -p 'xcq' ssh xcq@172.19.0.2${i} "screen -S ycsb -p 0 -X stuff \"mvn -pl memec -am clean package -Dcheckstyle.skip $(printf '\r')\"" #不用执行，是需要docker-compose 重启
#      sshpass -p 'xcq' ssh xcq@172.19.0.2${i} "screen -S ycsb -p 0 -X stuff \"${DEGRADED_PATH}/singledegraded.sh load $(printf '\r')\""
#      sleep 10
#    done

   for w in $workloads; do
        echo "-------------------- Run #$iter--------------------"
      for i in 0;do
        sshpass -p 'xcq' ssh xcq@172.19.0.2${i} "screen -S ycsb -p 0 -X stuff \"${DEGRADED_PATH}/singledegraded.sh $w $(printf '\r')\""
        sleep 5
      done
     done

  echo "******************** Finish Iteration #$iter ********************"
  done
  done