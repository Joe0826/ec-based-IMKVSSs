#!/bin/bash

N=14    # number of nodes
K=10    # number of data shards
dir="./"  # 当前目录
IP="172.20.0.2"

echo -e "($N,$K) in $dir" # 输出当前N和K的值以及当前目录

cd  /home/chuqiao/workspace/memcached_cluster/YCSB-0.7.0
bash ycsb_gen.sh
sleep 1
for i in {1..4}; do
  cp ycsb_load${i}.load /home/chuqiao/workspace/memcached_cluster/scripts;
  cp ycsb_run${i}.run /home/chuqiao/workspace/memcached_cluster/scripts;
done

cd /home/chuqiao/workspace/memcached_cluster/scripts
bash gen_workload.sh
sleep 1
for i in {1..4}; do
  cp ycsb_set${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
  cp ycsb_test${i}.txt   /home/chuqiao/workspace/memcached_cluster/throughput;
done

cd /home/chuqiao/workspace/memcached_cluster/throughput
#bash make.sh

#./workload1 $dir $N $K $IP> ./workload1.txt
./workload4 > ./workload4.txt
sleep 5
./workload1 > ./workload1.txt
sleep 5
./workload2 > ./workload2.txt
sleep 5
./workload3 > ./workload3.txt
sleep 5

