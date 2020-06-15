#!/bin/bash

clear
echo -e "${CL_HEAD} Choose a device to add ${CL_DEFA}"
echo ""
echo "c - Cancel"
ARRAY_DEVICEADDLIST=($(ls -1 res/device))
for IT in ${!ARRAY_DEVICEADDLIST[@]}; do
    if [ -d res/device/${ARRAY_DEVICEADDLIST[$IT]}/$G_PROJ ] && [ -z "$(grep -x ${ARRAY_DEVICEADDLIST[$IT]} src/$G_PROJ/xsirlis/devicelist)" ]; then
        echo "${IT} - ${ARRAY_DEVICEADDLIST[$IT]}"
    fi
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == c ]; then
    return
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_DEVICEADDLIST[$XIN]}" ] && [ -d res/device/${ARRAY_DEVICEADDLIST[$IT]}/$G_PROJ ] && [ -z "$(grep -x ${ARRAY_DEVICEADDLIST[$IT]} src/$G_PROJ/xsirlis/devicelist)" ]; then
    echo ${ARRAY_DEVICEADDLIST[$XIN]} >> src/$G_PROJ/xsirlis/devicelist
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
source bin/sync.sh
