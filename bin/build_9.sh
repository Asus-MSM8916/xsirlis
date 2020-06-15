#!/bin/bash

source build/envsetup.sh
export LC_ALL=C
export WITHOUT_CHECK_API=true
lunch
make installclean -j $(nproc --all)
brunch $TARGET_PRODUCT-$TARGET_BUILD_VARIANT -j $(nproc --all)
