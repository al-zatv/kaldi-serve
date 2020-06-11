#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob
set -x

. ./incl_paths.sh

# ==============================
# kaldi-serve
# ==============================
yum install boost-devel openssl-devel libstdc++-static 
cd ~
#git clone https://github.com/Vernacular-ai/kaldi-serve.git
git clone https://github.com/al-zatv/kaldi-serve
cd kaldi-serve/
export PKG_CONFIG_PATH=$HOME/grpc/cmake/build/libs/opt/pkgconfig:$MY_INSTALL_DIR/lib64/pkgconfig
make KALDI_ROOT=$kaldi INCLUDES=-I$MY_INSTALL_DIR/include -j8
LD_LIBRARY_PATH=$kaldi/src/lib:$kaldi/tools/openfst/lib:$LD_LIBRARY_PATH ./kaldi_serve_app model-spec.toml
