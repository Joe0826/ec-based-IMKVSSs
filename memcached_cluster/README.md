Thanks for your interest in ec-based imkvss of Hybrid mode. You may try the following steps on a Ubuntu22.04 server.

Preparation
----
1. Install libmemcached-1.0.18
   ```shell
   $ cd libmemcached-1.0.18
   $ sh configure; make; sudo make install
   $ export LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH  #(if it ocuurs library path issue)
   ```
2. Log in to your dockerhub account and pull the docker hub image.
   ```shell
   $ docker pull xcq0826/ec-based:v1
   ```
3. Enter 'memcached_cluster' directory, please do not modify the current directory structure. 
The YCSB directory is the benchmark directory, and the specified workload can be generated by the script 'ycsb_gen.sh'.
The Throughput directory contains source code and test scripts.


Start Docker cluster
----
Build/Start/Stop docker cluster must in memcached_cluster directory, you can change the number of server nodes as needed.
All nodes are automatically in one LAN.
Please try not to open other Docker container when starting a Docker cluster to avoid unknown IP occupancy.
```shell
  1. Create services images：$ docker-compose build (only once)
  2. Start containers: $ docker-compose up
  3. View the status of all active containers：$ docker-compose ps
  4. Access to active containers: $ docker exec -it memc1 /bin/bash 
  5. Exit from active containers: $ exit
```

Evaluation
----
Researchers can use the  provided workload scripts in throughput directory to do demo tests. 
We list workloads with different read/write ratios(workload1:read-only;workload2:read:update=95:5;workload3:70:30;workload4:50:50), and also give tests with (10,4) or (6,3) RS codes.
You can modify the parameters of the workload, and further more workload via YCSB in GitHub - brianfrankcooper/YCSB: Yahoo! Cloud Serving Benchmark.
You should open two terminals:
```shell
   # first terminal
   $ cd memcached_cluster
   $ docker-compose up
   # second terminal
   $ cd memcached_cluster/throuhgput
   $ bash test_all.sh
```
You can also test each case individually
```shell
  $ bash test_rw100\:0_\(10\,4\).sh  # ((10,4)RS r/w=100:0)
  $ bash test_rw100\:0_\(6\,3\).sh  #  ((10,4)RS r/w=100:0)
```
If you encounter error "Segmentation fault (core dumped)" , you can restart the docker cluster (docker-compose down & docker-compose up) or your test machine.

Stop Docker cluster
----
```shell
   $ docker-compose down #twice
```
