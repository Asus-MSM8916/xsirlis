#!/bin/bash

clear
echo -e "${CL_HEAD} Choose a new project ${CL_DEFA}"
echo ""
ARRAY_ROMLIST=($(ls -1 res/rom))
for IT in ${!ARRAY_ROMLIST[@]}; do
    if [ ! -d src/${ARRAY_ROMLIST[$IT]} ]; then
        echo "${IT} - ${ARRAY_ROMLIST[$IT]}"
    fi
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_ROMLIST[$XIN]}" ] && [ ! -d src/${ARRAY_ROMLIST[$XIN]} ]; then
    G_PROJ=${ARRAY_ROMLIST[$XIN]}
    G_ARRAY_ROMDATA=($(cat res/rom/$G_PROJ))
    mkdir src/$G_PROJ
    cd src/$G_PROJ
    repo init --depth=1 -u ${G_ARRAY_ROMDATA[2]} -b ${G_ARRAY_ROMDATA[3]}
    mkdir xsirlis
    touch xsirlis/devicelist
    if [ ${G_ARRAY_ROMDATA[0]} == ROM ]; then
        touch xsirlis/gapps
        echo "None" > xsirlis/gapps
        touch xsirlis/ota
        echo "None" > xsirlis/ota
    fi
    cd $G_PATH_LOCAL
    source bin/sync.sh
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
