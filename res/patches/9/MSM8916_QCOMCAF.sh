#!/bin/bash

sed -i "s/zd/ld/g" hardware/qcom/display-caf/msm8916/libhdmi/hdmi.cpp
sed -i "s/zd/ld/g" hardware/qcom/display-caf/msm8916/libqdutils/idle_invalidator.cpp
sed -i "s/zd/ld/g" hardware/qcom/audio-caf/msm8916/hal/audio_hw.c
