#!/bin/bash

###################################################
#
# Load key-value pairs using YCSB client
# INPUT: (1) Number of threads to use in each client, (2) name of the YCSB workload
#
###################################################

YCSB_PATH=/home/xcq/imkv/ycsb

if [ $# != 1 ]; then
	echo "Usage: $0 [Number of threads]"
	exit 1
fi

ID=$(ifconfig eth0 | grep 'inet ' | awk '{print $2}'| sed 's/172.19.0.2//g')

# Evenly distribute the # of ops to YCSB clients ( 4 in the experiment setting )
# Each client inserts pairs of an independent key range
RECORD_COUNT=100
INSERT_COUNT=$(expr ${RECORD_COUNT} \/ 4)
if [ $ID == 0 ]; then
	INSERT_START=0
elif [ $ID == 1 ]; then
	INSERT_START=${INSERT_COUNT}
elif [ $ID == 2 ]; then
	INSERT_START=$(expr ${INSERT_COUNT} \* 2)
elif [ $ID == 3 ]; then
	INSERT_START=$(expr ${INSERT_COUNT} \* 3)
fi

# Load the store with key-value pairs
${YCSB_PATH}/bin/ycsb \
	load memec \
	-P ${YCSB_PATH}/workloads/workloada \
	-p fieldcount=1 \
	-p readallfields=false \
	-p scanproportion=0 \
	-p table=u \
	-p fieldlength=200 \
	-p requestdistribution=zipfian \
	-p recordcount=${RECORD_COUNT} \
	-p insertstart=${INSERT_START} \
	-p insertcount=${INSERT_COUNT} \
	-p threadcount=$1 \
	-p memec.host=$(hostname -I | sed 's/^.*\(172\.19\.0\.[0-9]*\).*$/\1/g') \
	-p memec.port=9112 \
	-p memec.key_size=255 \
	-p memec.chunk_size=4096
#	-p histogram.buckets=200000 \