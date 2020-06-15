#!/bin/bash

clear
echo -e "${CL_HEAD} Choose Gapps ${CL_DEFA}"
echo ""
echo "c - Cancel"
echo "n - None"
ARRAY_GAPPSLIST=($(ls -1 res/gapps/${G_ARRAY_ROMDATA[1]}))
for IT in ${!ARRAY_GAPPSLIST[@]}; do
    echo "${IT} - ${ARRAY_GAPPSLIST[$IT]}"
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == c ]; then
    return
elif [ -n "$XIN" ] && [ $XIN == n ]; then
    if [ $(cat src/$G_PROJ/xsirlis/gapps) != None ]; then
        while read -a MFL; do
            if [ -d ${MFL[2]} ]; then
                rm -rf ${MFL[2]}
            fi
        done < res/gapps/${G_ARRAY_ROMDATA[1]}/$(cat src/$G_PROJ/xsirlis/gapps)
        echo "None" > src/$G_PROJ/xsirlis/gapps
    fi
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_GAPPSLIST[$XIN]}" ]; then
    if [ $(cat src/$G_PROJ/xsirlis/gapps) != None ]; then
        while read -a MFL; do
            if [ -d ${MFL[2]} ]; then
                rm -rf ${MFL[2]}
            fi
        done < res/gapps/${G_ARRAY_ROMDATA[1]}/$(cat src/$G_PROJ/xsirlis/gapps)
    fi
    echo "${ARRAY_GAPPSLIST[$XIN]}" > src/$G_PROJ/xsirlis/gapps
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi

source bin/sync.sh
