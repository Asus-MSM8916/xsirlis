#!/bin/bash

source build/envsetup.sh
export LC_ALL=C
export WITHOUT_CHECK_API=true
lunch
make installclean -j $(nproc --all)
mka api-stubs-docs -j $(nproc --all)
mka hiddenapi-lists-docs -j $(nproc --all)
mka system-api-stubs-docs -j $(nproc --all)
mka test-api-stubs-docs -j $(nproc --all)
brunch $TARGET_PRODUCT-$TARGET_BUILD_VARIANT -j $(nproc --all)
