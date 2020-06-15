#!/bin/bash

clear
echo -e "${CL_HEAD} Choose OTA ${CL_DEFA}"
echo ""
echo "c - Cancel"
echo "n - None"
ARRAY_DEVICELIST=($(cat src/$G_PROJ/xsirlis/devicelist))
for IT in ${!ARRAY_DEVICELIST[@]}; do
    echo "${IT} - ${ARRAY_DEVICELIST[$IT]}"
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == c ]; then
    return
elif [ -n "$XIN" ] && [ $XIN == n ]; then
    if [ $(cat src/$G_PROJ/xsirlis/ota) != None ]; then
        sed -i "s#$(cat res/device/$(cat src/${G_PROJ}/xsirlis/ota)/${G_PROJ}/ota)#${G_ARRAY_ROMDATA[4]}#" src/$G_PROJ/packages/apps/Updater/res/values/strings.xml
        echo "None" > src/$G_PROJ/xsirlis/ota
    fi
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_DEVICELIST[$XIN]}" ]; then
    if [ $(cat src/$G_PROJ/xsirlis/ota) == None ]; then
        sed -i "s#${G_ARRAY_ROMDATA[4]}#$(cat res/device/${ARRAY_DEVICELIST[$XIN]}/${G_PROJ}/ota)#" src/$G_PROJ/packages/apps/Updater/res/values/strings.xml
    else
        sed -i "s#$(cat res/device/$(cat src/${G_PROJ}/xsirlis/ota)/${G_PROJ}/ota)#$(cat res/device/${ARRAY_DEVICELIST[$XIN]}/${G_PROJ}/ota)#" src/$G_PROJ/packages/apps/Updater/res/values/strings.xml
    fi
    echo ${ARRAY_DEVICELIST[$XIN]} > src/$G_PROJ/xsirlis/ota
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
