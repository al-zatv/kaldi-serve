#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob
set -x
kaldi_folder_name=kaldi #$1
kaldi_checkout=da93074 #$2

yum install -y mc wget python3 software-properties-common  g++ make automake autoconf bzip2 unzip wget sox libtool git zlib1g-dev gfortran ca-certificates patch ffmpeg subversion  python2.7 python python3 ipython3 python3-pip  mc htop aria2 curl ncdu tmux ssh gawk sudo less which

myDir=$(dirname $(readlink -nf $0))

#sctk="$myDir/sctk-2.4.10-20151007-1312Z.tar.bz2"
#[ -f $sctk ] || { echo "ERROR: prereq not found: $sctk or $srilm"; exit 1; }

nj=`nproc --all`

#MAKE DIR
mkdir -p $kaldi_folder_name
cd $kaldi_folder_name

git clone https://github.com/kaldi-asr/kaldi.git .
git checkout $kaldi_checkout


#TOOLS
cd tools
ln -s $sctk .
extras/install_mkl.sh
extras/check_dependencies.sh
make -j $nj

cd .. 

#SRC
cd src
./configure  --shared --use-cuda=no #--mathlib=OPENBLAS --use-cuda #for libs: --shared --use-cuda=no 
make clean depend -j $nj
make -j $nj
cd ..
