#!/bin/bash

if [ -d /etc/apt ]; then
    clear
    echo -e "${CL_HEAD} Install/update build packages? ${CL_DEFA}"
    echo ""
    echo -e "${CL_WAIT} Press \"y\" to accept ${CL_DEFA}"
    echo ""
    read -n 1 -s XIN
    if [ -n "$XIN" ] && [ $XIN == y ]; then
        sudo apt update
        sudo apt -y upgrade
        sudo apt -y install git-core gnupg flex bison gperf build-essential zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev libxml2-utils xsltproc unzip
        sudo apt -y install git-lfs imagemagick libncurses5 libssl-dev maven openjdk-8-jdk python zram-config
        sudo apt -y install ghex meld
        sudo apt -y autoremove
        curl https://storage.googleapis.com/git-repo-downloads/repo > repo
        chmod +x repo
        sudo mv repo /bin/repo
    fi
else
    clear
    echo -e "${CL_WARN} WARNING: APT not found. You need to install build packages manually. ${CL_DEFA}"
    echo ""
    read -n 1 -s
fi
