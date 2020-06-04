#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob


# ============= to run client
# https://linuxize.com/post/how-to-install-ffmpeg-on-centos-7/
yum install python3-devel  portaudio-devel 
pip3 install docopt pydub grpcio protobuf pyaudio

cd kaldi-serve/python/scripts
ln -s ../kaldi-serve kaldi-serve

echo "probably you need russian locale for centos7. please read comments in script"
# !!! русифицировать консоль centos7:
# http://dedicatesupport.com/content/nastroika-lokali-v-konsoli-v-centos
# не забыть chmod a+x /etc/чототам/i18n
# возможно export LANG ru_RU.UTF-8 надо в консольке
python3 example_client.py --lang=ru test.wav
