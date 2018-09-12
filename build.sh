#!/bin/bash

#############################################################
## This build script will export proper paths to toolchain ##
## and correct ARCH for device. Modify these values to fit ##
## your environment and run it before building.            ##
#############################################################

export CCACHE= ccache

make O=out clean && make O=out mrproper
make O=out ARCH=arm64 elixir_wahoo_defconfig

export CLANG_TC=~/Android/Toolchains/clang-7.0/bin/clang
export KBUILD_COMPILER_STRING=$(${CLANG_TC} --version | head -n 1 | perl -pe 's/\(http.*?\)//gs' | sed -e 's/  */ /g' -e 's/[[:space:]]*$//')

make -j$(nproc --all) O=out \
                      ARCH=arm64 \
                      CC="${CCACHE} ${CLANG_TC}" \
                      HOSTCC="${CCACHE} ${CLANG_TC}" \
                      HOSTCC="${CCACHE} ${CLANG_TC}" \
                      CLANG_TRIPLE=aarch64-linux-gnu- \
                      CROSS_COMPILE_ARM32=~/Android/Toolchains/arm-linux-androideabi-4.9/bin/arm-linux-androideabi- \
                      CROSS_COMPILE=~/Android/Toolchains/aarch64-linux-android-4.9/bin/aarch64-linux-android-
