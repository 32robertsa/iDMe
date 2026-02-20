#!/bin/bash

echo "Startup date and time: $NOW"
echo $(date +"%Y-%m-%d %T") 

massname=$1
ctau=$2
nevents=$3
nthreads=$4
index=$5

echo "Args:"

tar -xzf submit.tar.gz

echo "massname = ${gridpack}"
echo "ctau = ${ctau}"
echo "nevents = ${nevents}"
echo "nthreads = ${nthreads}"
echo "index = ${index}"

echo "Starting path and files:"
pwd
ls

sh prodchain_from_massname_2024.sh ${massname} ${ctau} ${nevents} ${nthreads} ${index}

echo "Finishing date and time:"
echo $(date +"%Y-%m-%d %T") 

echo "Finishing path and files:"
pwd
ls


exit 0
