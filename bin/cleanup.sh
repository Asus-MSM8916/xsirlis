#!/bin/bash

source build/envsetup.sh
make clean -j $(nproc --all)
