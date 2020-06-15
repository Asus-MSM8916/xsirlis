#!/bin/bash

clear
echo -e "${CL_HEAD} Choose a device to remove ${CL_DEFA}"
echo ""
echo "c - Cancel"
ARRAY_DEVICERMLIST=($(cat src/$G_PROJ/xsirlis/devicelist))
for IT in ${!ARRAY_DEVICERMLIST[@]}; do
    echo "${IT} - ${ARRAY_DEVICERMLIST[$IT]}"
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == c ]; then
    return
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_DEVICERMLIST[$XIN]}" ]; then
    while read -a MFL; do
        if [ -d ${MFL[2]} ]; then
            rm -rf ${MFL[2]}
        fi
    done < res/device/${ARRAY_DEVICERMLIST[$XIN]}/$G_PROJ/manifest
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
source bin/sync.sh
