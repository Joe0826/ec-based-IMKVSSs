#!/bin/bash

###################################################
#
# Run the workload using YCSB client
# INPUT: (1) Number of threads to use in each client, (2) name of the YCSB workload
#
###################################################

YCSB_PATH=/home/xcq/imkv/ycsb

if [ $# != 2 ]; then
	echo "Usage: $0 [Number of threads] [Workload]"
	exit 1
fi

ID=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}'| sed 's/172.19.0.2//g')

# Evenly distribute the # of ops to YCSB clients ( 4 in the experiment setting )
RECORD_COUNT=100
INSERT_COUNT=$(expr ${RECORD_COUNT} \/ 4)
OPERATION_COUNT=$(expr ${RECORD_COUNT} \/ 4)
if [ $hos == 0 ]; then
	INSERT_START=0
elif [ $ID == 1 ]; then
	INSERT_START=${INSERT_COUNT}
elif [ $ID == 2 ]; then
	INSERT_START=$(expr ${INSERT_COUNT} \* 2)
elif [ $ID == 3 ]; then
	INSERT_START=$(expr ${INSERT_COUNT} \* 3)
fi

# Run the target workload
${YCSB_PATH}/bin/ycsb \
	run memec \
	-s \
	-P ${YCSB_PATH}/workloads/$2 \
	-p fieldcount=1 \
	-p readallfields=false \
	-p scanproportion=0 \
	-p table=u \
	-p fieldlength=200 \
	-p requestdistribution=zipfian \
	-p recordcount=${RECORD_COUNT} \
	-p insertstart=${INSERT_START} \
	-p insertcount=${INSERT_COUNT} \
	-p operationcount=${OPERATION_COUNT} \
	-p threadcount=$1 \
	-p histogram.buckets=2000 \
	-p memec.host=$(hostname -I | sed 's/^.*\(172\.19\.0\.[0-9]*\).*$/\1/g') \
	-p memec.port=9112 \
	-p memec.key_size=255 \
	-p memec.chunk_size=4096