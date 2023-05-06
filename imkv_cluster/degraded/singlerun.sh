#!/bin/bash
YCSB_PATH=/home/xcq/imkv/ycsb

if [ $# != 2 ]; then
	echo "Usage: $0 [Number of threads] [Workload]"
	exit 1
fi

ID=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}'| sed 's/172.19.0.2//g')

FIELD_LENGTH=8192
RECORD_COUNT=500000
INSERT_COUNT=$(expr ${RECORD_COUNT} \/ 1)
OPERATION_COUNT=$(expr ${RECORD_COUNT} \/ 1)
if [ $ID == 0 ]; then
  	INSERT_START=0
fi

${YCSB_PATH}/bin/ycsb \
	run memec \
	-P ${YCSB_PATH}/workloads/$2 \
	-p fieldcount=1 \
	-p readallfields=false \
	-p scanproportion=0 \
	-p table=u \
	-p requestdistribution=zipfian \
	-p fieldlength=${FIELD_LENGTH} \
  -p recordcount=${RECORD_COUNT} \
  -p insertstart=${INSERT_START} \
  -p insertcount=${INSERT_COUNT} \
	-p operationcount=${OPERATION_COUNT} \
	-p threadcount=$1 \
	-p memec.host=$(hostname -I | sed 's/^.*\(172\.19\.0\.[0-9]*\).*$/\1/g') \
	-p memec.port=9112 \
	-p memec.key_size=20 \
	-p memec.chunk_size=8192