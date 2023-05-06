#!/bin/bash
YCSB_PATH=/home/xcq/imkv/ycsb

if [ $# != 1 ]; then
	echo "Usage: $0 [Number of threads]"
	exit 1
fi

ID=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}'| sed 's/172.19.0.2//g')

FIELD_LENGTH=8192
RECORD_COUNT=500000
INSERT_COUNT=$(expr ${RECORD_COUNT} \/ 1)
if [ $ID == 0 ]; then
  	INSERT_START=0
fi
#elif [ $ID == 1 ]; then
#  	INSERT_START=${INSERT_COUNT}
#elif [ $ID == 2 ]; then
#  	INSERT_START=$(expr ${INSERT_COUNT} \* 2)
#elif [ $ID == 3 ]; then
#  	INSERT_START=$(expr ${INSERT_COUNT} \* 3)
 #失败
#if [ $ID == 0 ]; then
#  	INSERT_START=0
#elif [ $ID == 1 ]; then
#  	INSERT_START=${INSERT_COUNT}
#fi

# 注意workload的位置一定要加ycsb地址
${YCSB_PATH}/bin/ycsb \
load memec \
-P ${YCSB_PATH}/workloads/workload1 \
-p fieldcount=1 \
-p readallfields=false \
-p scanproportion=0 \
-p table=u \
-p requestdistribution=zipfian \
-p fieldlength=${FIELD_LENGTH} \
-p recordcount=${RECORD_COUNT} \
-p insertstart=${INSERT_START} \
-p insertcount=${INSERT_COUNT} \
-p threadcount=$1 \
-p memec.host=$(hostname -I | sed 's/^.*\(172\.19\.0\.[0-9]*\).*$/\1/g') \
-p memec.port=9112 \
-p memec.key_size=20 \
-p memec.chunk_size=8192
#-p maxexecutiontime=600