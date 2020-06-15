#!/bin/bash

clear
echo -e "${CL_HEAD} Choose a project ${CL_DEFA}"
echo ""
echo "n - New project"
ARRAY_PROJECT=($(ls -1 src))
for IT in ${!ARRAY_PROJECT[@]}; do
    echo "${IT} - ${ARRAY_PROJECT[$IT]}"
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == n ]; then
    source bin/init.sh
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_PROJECT[$XIN]}" ]; then
    G_PROJ=${ARRAY_PROJECT[$XIN]}
    G_ARRAY_ROMDATA=($(cat res/rom/$G_PROJ))
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
