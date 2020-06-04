#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob

export kaldi=kaldi

# ==============================
# GRPC
# https://grpc.io/docs/languages/cpp/quickstart/
# ==============================
export MY_INSTALL_DIR=$HOME/.local
mkdir -p $MY_INSTALL_DIR
export PATH="$PATH:$MY_INSTALL_DIR/bin"
wget -q -O cmake-linux.sh https://github.com/Kitware/CMake/releases/download/v3.17.0/cmake-3.17.0-Linux-x86_64.sh
sh cmake-linux.sh -- --skip-license --prefix=$MY_INSTALL_DIR
rm cmake-linux.sh
yum install autoconf libtool pkgconfig # no build-essentials. probably, yum groupinstall "Development Tools"; is analogue.
git clone --recurse-submodules -b v1.28.1 https://github.com/grpc/grpc
cd grpc
pushd cmake/build
cmake -DgRPC_INSTALL=ON \
-DgRPC_BUILD_TESTS=OFF \
-DCMAKE_INSTALL_PREFIX=$MY_INSTALL_DIR \
../..
make -j
make install
popd
### check that grpc is built
##cd examples/cpp/helloworld
##mkdir -p cmake/build
##pushd cmake/build
##cmake -DCMAKE_PREFIX_PATH=$MY_INSTALL_DIR ../..
##make -j
##./greeter_server &
##./greeter_client
##kill %1

# ==============================
# kaldi-serve
# ==============================
yum install boost-devel openssl-devel libstdc++-static 
cd ~
git clone https://github.com/Vernacular-ai/kaldi-serve.git
cd kaldi-serve/
export PKG_CONFIG_PATH=$HOME/grpc/cmake/build/libs/opt/pkgconfig:$HOME/.local/lib64/pkgconfig
make KALDI_ROOT=$kaldi -j8
LD_LIBRARY_PATH=$kaldi/src/lib:$kaldi/tools/openfst/lib:$LD_LIBRARY_PATH ./kaldi_serve_app model-spec.toml
