#!/bin/bash
YCSB_PATH=/home/xcq/imkv/ycsb

if [ $# != 1 ]; then
	echo "Usage: $0 [Number of threads]"
	exit 1
fi

ID=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}'| sed 's/172.19.0.2//g')

FIELD_LENGTH=4096
RECORD_COUNT=5000
INSERT_COUNT=$(expr ${RECORD_COUNT} \/ 1)
if [ $ID == 0 ]; then
  	INSERT_START=0
fi

${YCSB_PATH}/bin/ycsb \
load mkvec \
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
-p imkvec.host=$(hostname -I | sed 's/^.*\(172\.19\.0\.[0-9]*\).*$/\1/g') \
-p imkvec.port=9112 \
-p imkvec.key_size=20 \
-p imkvec.chunk_size=4096