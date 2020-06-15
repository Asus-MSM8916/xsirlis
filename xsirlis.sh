#!/bin/bash

CL_HEAD='\033[1;36;40m'
CL_WAIT='\033[1;33;40m'
CL_ERRO='\033[1;37;41m'
CL_DONE='\033[1;37;42m'
CL_WARN='\033[1;37;43m'
CL_DEFA='\033[0m'

G_PROJ=NULL
G_ARRAY_ROMDATA=()
G_PATH_LOCAL=NULL

cd $(dirname $0)
G_PATH_LOCAL=$(pwd)
if [ ! -d src ]; then
    mkdir src
fi
chmod +x bin/*
chmod +x res/patches/*/*

source bin/setup.sh
source bin/choose.sh
source bin/menu.sh
