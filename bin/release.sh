#!/bin/bash

clear
echo -e "${CL_HEAD} Choose device to generate json file ${CL_DEFA}"
echo ""
echo "c - Cancel"
ARRAY_BUILT=($(ls -1 src/$G_PROJ/out/target/product))
for IT in ${!ARRAY_BUILT[@]}; do
    if [ -n "$(ls -1 src/$G_PROJ/out/target/product/${ARRAY_BUILT[$IT]} | grep zip | grep -v md5sum | grep -v ota)" ]; then
        echo "${IT} - ${ARRAY_BUILT[$IT]}"
    fi
done
echo ""
echo -e "${CL_WAIT} Enter your choice... ${CL_DEFA}"
echo ""
read XIN
if [ -n "$XIN" ] && [ $XIN == c ]; then
    return
elif [ -n "$XIN" ] && [[ $XIN =~ ^[0-9]+$ ]] && [ -n "${ARRAY_BUILT[$XIN]}" ] && [ -n "$(ls src/$G_PROJ/out/target/product/${ARRAY_BUILT[$XIN]} | grep zip | grep -v md5sum | grep -v ota)" ]; then
    ARRAY_OTADATA=($(cat res/device/${ARRAY_BUILT[$XIN]}/$G_PROJ/json))
    JSON_DATETIME=$(cat src/$G_PROJ/out/target/product/${ARRAY_BUILT[$XIN]}/system/build.prop | grep ro.build.date.utc=)
    JSON_DATETIME=${JSON_DATETIME:18}
    JSON_FNAME=$(ls -1 src/$G_PROJ/out/target/product/${ARRAY_BUILT[$XIN]} | grep zip | grep -v md5sum | grep -v ota)
    JSON_ID=$(md5sum src/$G_PROJ/out/target/product/${ARRAY_BUILT[$XIN]}/$JSON_FNAME)
    JSON_ID=${JSON_ID%% *}
    JSON_SIZE=$(stat -c%s src/$G_PROJ/out/target/product/${ARRAY_BUILT[$XIN]}/$JSON_FNAME)
    
    if [ -f ${ARRAY_OTADATA[0]} ]; then
        rm -rf ${ARRAY_OTADATA[0]}
    fi
    echo "{" >> ${ARRAY_OTADATA[0]}
    echo "  \"response\": [" >> ${ARRAY_OTADATA[0]}
    echo "    {" >> ${ARRAY_OTADATA[0]}
    echo "      \"datetime\": ${JSON_DATETIME}," >> ${ARRAY_OTADATA[0]}
    echo "      \"filename\": \"${JSON_FNAME}\"," >> ${ARRAY_OTADATA[0]}
    echo "      \"id\": \"${JSON_ID}\"," >> ${ARRAY_OTADATA[0]}
    echo "      \"romtype\": \"${ARRAY_OTADATA[3]}\"," >> ${ARRAY_OTADATA[0]}
    echo "      \"size\": ${JSON_SIZE}," >> ${ARRAY_OTADATA[0]}
    echo "      \"url\": \"${ARRAY_OTADATA[1]}${ARRAY_OTADATA[2]}SUBVER/${JSON_FNAME}\"," >> ${ARRAY_OTADATA[0]}
    echo "      \"version\": \"${ARRAY_OTADATA[4]}\"" >> ${ARRAY_OTADATA[0]}
    echo "    }" >> ${ARRAY_OTADATA[0]}
    echo "  ]" >> ${ARRAY_OTADATA[0]}
    echo "}" >> ${ARRAY_OTADATA[0]}
else
    clear
    echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
    echo ""
    exit
fi
