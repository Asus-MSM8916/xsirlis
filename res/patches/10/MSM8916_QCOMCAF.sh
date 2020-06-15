#!/bin/bash

sed -i "s/zd/ld/g" hardware/qcom-caf/msm8916/display/libhdmi/hdmi.cpp
sed -i "s/zd/ld/g" hardware/qcom-caf/msm8916/display/libqdutils/idle_invalidator.cpp
sed -i "s/zd/ld/g" hardware/qcom-caf/msm8916/audio/hal/audio_hw.c
