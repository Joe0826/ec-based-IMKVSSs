#!/bin/bash

N=9    # number of nodes
K=6    # number of data shards
dir="./"  # 当前目录
IP="172.20.0.2" #集群memc1的ip

echo -e "($N,$K) in $dir" # 输出当前N和K的值以及当前目录
YCSB_HOME=/home/chuqiao/workspace/memcached_cluster/YCSB-0.7.0

cd  $YCSB_HOME
bin/ycsb load basic -P $YCSB_HOME/workloads/workload1 > ./ycsb_load1.load
bin/ycsb run basic -P $YCSB_HOME/workloads/workload1 > ./ycsb_run1.run

sleep 1
for i in 1; do
  cp ycsb_load${i}.load /home/chuqiao/workspace/memcached_cluster/scripts;
  cp ycsb_run${i}.run /home/chuqiao/workspace/memcached_cluster/scripts;
done

cd /home/chuqiao/workspace/memcached_cluster/scripts
gcc gen_workload1.cpp -o gen_workload1
./gen_workload1

sleep 1
for i in 1; do
  cp ycsb_set${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
  cp ycsb_test${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
done

cd /home/chuqiao/workspace/memcached_cluster/throughput
#g++ -std=c++11 workload1_k6m3.cpp -o workload1_k6m3 -lmemcached -lisal

./workload1_k6m3 > ./workload1_k6m3.txt
sleep 1

#./workload1 $N $K > ./workload1.txt
