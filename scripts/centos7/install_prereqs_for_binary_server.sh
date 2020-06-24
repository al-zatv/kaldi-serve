#!/bin/bash

#sudo docker pull centos:centos7
#sudo docker run -d -v $HOME:/H/home -v /:/H/root centos:centos7 sleep 36500d
#sudo docker exec -ti 21fa /bin/bash
#... and, do download binaries inside docker

yum install mc tmux # for convinience
yum install boost
yum install gcc-c++ # for mkl
KALDI_SERVE/scripts/install_mkl.sh
echo "Also, for AMD CPUs you probably need this in every session:"
echo "export MKL_DEBUG_CPU_TYPE=5"
