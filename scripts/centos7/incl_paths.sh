#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob

export kaldi=$HOME/kaldi
export MY_INSTALL_DIR=$HOME/.local
export PATH="$PATH:$MY_INSTALL_DIR/bin"
