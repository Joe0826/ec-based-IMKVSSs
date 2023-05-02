#!/bin/bash

N=14    # number of nodes
K=10    # number of data shards
dir="./"  # 当前目录
IP="172.20.0.2" #集群memc1的ip

echo -e "($N,$K) in $dir" # 输出当前N和K的值以及当前目录
YCSB_HOME=/home/chuqiao/workspace/memcached_cluster/YCSB-0.7.0

cd  $YCSB_HOME
bin/ycsb load basic -P $YCSB_HOME/workloads/workload3 > ./ycsb_load3.load
bin/ycsb run basic -P $YCSB_HOME/workloads/workload3 > ./ycsb_run3.run

sleep 1
for i in 3; do
  cp ycsb_load${i}.load /home/chuqiao/workspace/memcached_cluster/scripts;
  cp ycsb_run${i}.run /home/chuqiao/workspace/memcached_cluster/scripts;
done

cd /home/chuqiao/workspace/memcached_cluster/scripts
gcc gen_workload3.cpp -o gen_workload3
./gen_workload3

sleep 1
for i in 3; do
  cp ycsb_set${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
  cp ycsb_test${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
done

cd /home/chuqiao/workspace/memcached_cluster/throughput
#g++ -std=c++11 workload3_k6m3.cpp -o workload3_k6m3 -lmemcached -lisal

./workload3_k6m3 > ./workload3_k6m3.txt
sleep 1

