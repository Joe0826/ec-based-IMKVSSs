#!/bin/bash

gcc gen_workload1.cpp -o gen_workload1
gcc gen_workload2.cpp -o gen_workload2
gcc gen_workload3.cpp -o gen_workload3
gcc gen_workload4.cpp -o gen_workload4

./gen_workload1
./gen_workload2
./gen_workload3
./gen_workload4