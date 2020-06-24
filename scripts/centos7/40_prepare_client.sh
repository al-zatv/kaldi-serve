#!/bin/bash 
# shell safe code (https://sipb.mit.edu/doc/safe-shell/)
set -eu -o pipefail ; shopt -s failglob


# ============= to run client
yum install python3-devel 
yum install epel-release
yum install portaudio-devel 
pip3 install docopt pydub grpcio protobuf pyaudio

cd kaldi-serve/python/scripts
ln -s ../kaldi_serve kaldi_serve

echo "1) you may need to install ffmpeg (not necessary, but something may fail). please read https://linuxize.com/post/how-to-install-ffmpeg-on-centos-7/ for directions"
echo "2) probably you need russian locale for centos7. please read comments in script"
# !!! русифицировать консоль centos7:
# http://dedicatesupport.com/content/nastroika-lokali-v-konsoli-v-centos
# не забыть chmod a+x /etc/чототам/i18n
# возможно export LANG=ru_RU.UTF-8 надо в консольке

# вариант руссификации,который сработал у меня. Придётся не забывать каждый раз делать export LANG=ru_RU.UTF-8 перед запуском
localedef  -i ru_RU -f UTF-8 ru_RU.UTF-8
export LANG=ru_RU.UTF-8 

python3 example_client.py --lang=ru test.wav
