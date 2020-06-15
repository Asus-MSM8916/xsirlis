#!/bin/bash

cd src/$G_PROJ

clear
echo -e "${CL_HEAD} Choose sync variant ${CL_DEFA}"
echo ""
echo "d - Forced"
echo "f - Fast"
echo "s - Slow"
echo ""
echo -e "${CL_WAIT} Press chosen key ${CL_DEFA}"
echo ""
read -n 1 -s XIN
case $XIN in
    d)
        repo sync -f -c -q -j $(nproc) --no-tags --force-sync --no-clone-bundle
        SYNCV=RESYNC
        ;;
    f)
        repo sync -f -c -q -j $(nproc) --no-tags
        SYNCV=SYNC
        ;;
    s)
        repo sync -f -c -q -j 4 --no-tags
        SYNCV=SYNC
        ;;
    *)
        clear
        echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
        echo ""
        exit
        ;;
esac

while read LINE; do
    while read -a MFL; do
        if [ ! -d ${MFL[2]} ]; then
            git clone --depth 1 --no-tags ${MFL[0]} -b ${MFL[1]} ${MFL[2]}
        elif [ $SYNCV == RESYNC ]; then
            rm -rf ${MFL[2]}
            git clone --depth 1 --no-tags ${MFL[0]} -b ${MFL[1]} ${MFL[2]}
        else
            cd ${MFL[2]}
            git pull
            cd $G_PATH_LOCAL/src/$G_PROJ
        fi
    done < $G_PATH_LOCAL/res/device/$LINE/$G_PROJ/manifest
done < xsirlis/devicelist

if [ ${G_ARRAY_ROMDATA[0]} == ROM ] && [ $(cat xsirlis/gapps) != None ]; then
    while read -a MFL; do
        if [ ! -d ${MFL[2]} ]; then
            git clone --depth 1 --no-tags ${MFL[0]} -b ${MFL[1]} ${MFL[2]}
        elif [ $SYNCV == RESYNC ]; then
            rm -rf ${MFL[2]}
            git clone --depth 1 --no-tags ${MFL[0]} -b ${MFL[1]} ${MFL[2]}
        else
            cd ${MFL[2]}
            git pull
            cd $G_PATH_LOCAL/src/$G_PROJ
        fi
        cd ${MFL[2]}
        git lfs pull
        cd $G_PATH_LOCAL/src/$G_PROJ
    done < $G_PATH_LOCAL/res/gapps/${G_ARRAY_ROMDATA[1]}/$(cat xsirlis/gapps)
fi

for PATCH in $G_PATH_LOCAL/res/patches/${G_ARRAY_ROMDATA[1]}/*; do
    echo "Applying ${PATCH}"
    $PATCH
done

if [ ${G_ARRAY_ROMDATA[0]} == ROM ] && [ $(cat xsirlis/ota) != None ]; then
    sed -i "s#${G_ARRAY_ROMDATA[4]}#$(cat $G_PATH_LOCAL/res/device/$(cat $G_PATH_LOCAL/src/${G_PROJ}/xsirlis/ota)/${G_PROJ}/ota)#" packages/apps/Updater/res/values/strings.xml
fi

cd $G_PATH_LOCAL
