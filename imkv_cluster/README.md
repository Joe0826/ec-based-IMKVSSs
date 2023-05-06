Thanks for your interest in ec-based imkvss of Full-encoding mode. You may try the following steps on a Ubuntu22.04 server.

Preparation
----
1. Install Spread Toolkit. Download and install spread library (These libs are in the download directory of the docker image.)
   ```sudo dpkg -i *spread*.deb ```
   * http://old-releases.ubuntu.com/ubuntu/pool/universe/s/spread/libspread1_3.17.4-4_amd64.deb
   * http://old-releases.ubuntu.com/ubuntu/pool/universe/s/spread/libspread1-dev_3.17.4-4_amd64.deb
   * http://old-releases.ubuntu.com/ubuntu/pool/universe/s/spread/spread_3.17.4-4_amd64.deb
2. Start a standalone Spread server in a separate terminal
 ```shell
 $ sudo spread -n localhost
 ```
3. Get the local ip and modify the spread address. Add the IP to ./config/global.ini file with [states] spread=new ip.
4. Log in to your dockerhub account and pull the docker image imkv_base.
   ```shell
    $ docker pull xcq0826/ec-based:v2
   ```
5. Enter 'imkv_cluster' directory, please do not modify the current directory structure.

Start Docker cluster
----
Build/Start/Stop docker cluster must in imkv_cluster directory, you can change the number of server nodes as needed.
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
   We list workloads with different read/write ratios(workload1:read-only;workload2:read:update=95:5;workload3:70:30;workload4:50:50), and also give tests with different (k,m) RS codes.
   You can modify the number of threads, the encoding parameters, the size of the value, the size of the storage block, the read/write ratio of the workload,
   and the number of records. Modify the corresponding chunk size in ycsb to test the performance under different object organization policies. Modify config/global.ini to change the coding strategy.
   And further more workload via YCSB in GitHub - brianfrankcooper/YCSB: Yahoo! Cloud Serving Benchmark.
```shell
   $ cd imkv_cluster/ycsb/
   $ ../degraded/singleycsb.sh
```
If you encounter error "Segmentation fault (core dumped)" , you can restart the docker cluster (docker-compose down & docker-compose up).

Stop Docker cluster
----
```shell
   $ docker-compose down # twice