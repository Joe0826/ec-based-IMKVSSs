Welcome to EC-based IMKVSSs
----
This is the source code for "Erasure Coding in Distributed In-Memory Key-Value Storage Systems: An Overview". More precisely, we explain how to prepare, install, configure and benchmark EC-based IMKVSSs to re-run the experiments in this paper.

Preparation
---
All our experiments are tested on the docker cluster,
and the operating system of our experimental platform is Ubuntu 22.04 x86_64 with 54 GiB DRAM 
and 8-core CPU.

### Install docker on your platform
```shell
   $ sudo apt-get update
   $ sudo apt-get install docker-ce docker-ce-cli containerd.io
```

### Install erasure coding libs on your platform.
For erasure codes, you need install gf-complete, Jerasure and ISA-L
   
 + gf-complete(https://github.com/ceph/gf-complete.git)
    ```shell
    $./configure
    $ make
    $ sudo make install
    ```
 + Jerasure (https://github.com/tsuraan/Jerasure.git)
   ```shell
   $ autoreconf --force --install
   $ ./configure
   $ make
   $ sudo make install 
   ```
 + ISA-l (https://github.com/intel/isa-l.git) or install manually
   ```shell
   $ ./autogen.sh
   $ ./configure
   $ make
   $ sudo make install
   # manually
    $ tar -zxvf isa-l-2.14.0.tar.gz
    $ cd isa-l-2.14.0
    $ sh autogen.sh
    $ ./configure; make; sudo make install
   ```
    

If you want to test and develop locally, you need to install these dependency packages. But if you want to test in a docker cluster, you don't need to install these, the docker images already include the following dependencies.

1. These are the required libraries that users need to download separately. 
   - gcc/g++(v11.3.0)
   - make(v4.3), cmake(v3.22), autogen(v5.18.6), autoconf(v2.71), automake(v1.16.5),
   - yasm(v1.3),nasm(v2.15)
   - libtool(v2.4.6)
   - libevent(v2.1.12)
   - libboost-all-dev(1.74)
    ```shell
    $ sudo apt-get update
    $ sudo apt install adduser gcc g++ make cmake autogen autoconf 
      automake yasm nasm libtool libboost-all-dev libevent-dev
    ```
   
2. For YCSB, you need install java 1.8, maven-3.6.3, python2.78. 
```shell
    $ sudo apt install python2.7
    $ sudo apt install -y maven openjdk-8-jdk
```

3. For the hybrid mode based on Memcached, you need install project dependencies:
    
    [memcached_cluster](https://github.com/Joe0826/ec-based-IMKVSSs/blob/main/memcached_cluster/README.md)

4. For the Full-encoding
    
    给一个readme的链接
