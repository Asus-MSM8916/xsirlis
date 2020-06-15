#!/bin/bash

while :; do
    clear
    echo -e "${CL_HEAD} MAIN MENU - ${G_PROJ} ${CL_DEFA}"
    echo ""
    if [ ${G_ARRAY_ROMDATA[0]} == ROM ]; then
        echo "Gapps: $(cat src/$G_PROJ/xsirlis/gapps)"
        echo "OTA: $(cat src/$G_PROJ/xsirlis/ota)"
    fi
    echo "Devicelist:"
    cat src/$G_PROJ/xsirlis/devicelist
    echo ""
    if [ ! -d src/$G_PROJ/build ]; then
        echo -e "${CL_WARN} WARNING: ${G_PROJ} is not synced. ${CL_DEFA}"
        echo ""
    fi
    echo -e "${CL_HEAD} Actions ${CL_DEFA}"
    echo ""
    echo "a - Add device"
    echo "r - Remove device"
    echo "g - Choose gapps"
    echo "o - OTA settings"
    echo "s - Sync/Update sources"
    echo "b - Build"
    echo "j - Generate json file"
    echo "c - Cleanup"
    echo "d - Remove ${G_PROJ}"
    echo "q - Quit"
    echo ""
    echo -e "${CL_WAIT} Press chosen key ${CL_DEFA}"
    echo ""
    read -n 1 -s XIN
    case $XIN in
        a)
            source bin/deviceadd.sh
            ;;
        r)
            source bin/deviceremove.sh
            ;;
        g)
            source bin/gapps.sh
            ;;
        o)
            source bin/ota.sh
            ;;
        s)
            source bin/sync.sh
            ;;
        b)
            cd src/$G_PROJ
            $G_PATH_LOCAL/bin/build_${G_ARRAY_ROMDATA[1]}.sh
            cd $G_PATH_LOCAL
            ;;
        j)
            source bin/release.sh
            ;;
        c)
            clear
            echo -e "${CL_WARN} WARNING: This will remove built files. ${CL_DEFA}"
            echo ""
            echo -e "${CL_WAIT} Press \"y\" to accept ${CL_DEFA}"
            echo ""
            read -n 1 -s XIN
            if [ -n "$XIN" ] && [ $XIN == y ]; then
                cd src/$G_PROJ
                $G_PATH_LOCAL/bin/cleanup.sh
                cd $G_PATH_LOCAL
            fi
            ;;
        d)
            clear
            echo -e "${CL_WARN} WARNING: This will remove ${G_PROJ}. ${CL_DEFA}"
            echo ""
            echo -e "${CL_WAIT} Press \"y\" to accept ${CL_DEFA}"
            echo ""
            read -n 1 -s XIN
            if [ -n "$XIN" ] && [ $XIN == y ]; then
                sudo rm -rf src/$G_PROJ
                clear
                echo -e "${CL_DONE} EXIT 0x0 ${CL_DEFA}"
                echo ""
                exit
            fi
            ;;
        q)
            clear
            echo -e "${CL_DONE} EXIT 0x0 ${CL_DEFA}"
            echo ""
            exit
            ;;
        *)
            clear
            echo -e "${CL_ERRO} ERROR: INPUT ${CL_DEFA}"
            echo ""
            exit
            ;;
    esac
done
