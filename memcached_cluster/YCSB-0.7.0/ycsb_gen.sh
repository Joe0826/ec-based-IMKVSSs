#!/bin/bash
# Please change this according to your ycsb installation

YCSB_HOME=/home/chuqiao/workspace/memcached_cluster/YCSB-0.7.0

${YCSB_HOME}/bin/ycsb load basic -P $YCSB_HOME/workloads/workload1 > ./ycsb_load1.load

${YCSB_HOME}/bin/ycsb run basic -P $YCSB_HOME/workloads/workload1 > ./ycsb_run1.run

${YCSB_HOME}/bin/ycsb load basic -P $YCSB_HOME/workloads/workload2 > ./ycsb_load2.load

${YCSB_HOME}/bin/ycsb run basic -P $YCSB_HOME/workloads/workload2 > ./ycsb_run2.run

${YCSB_HOME}/bin/ycsb load basic -P $YCSB_HOME/workloads/workload3 > ./ycsb_load3.load

${YCSB_HOME}/bin/ycsb run basic -P $YCSB_HOME/workloads/workload3 > ./ycsb_run3.run

${YCSB_HOME}/bin/ycsb load basic -P $YCSB_HOME/workloads/workload4 > ./ycsb_load4.load

${YCSB_HOME}/bin/ycsb run basic -P $YCSB_HOME/workloads/workload4 > ./ycsb_run4.run

echo over
