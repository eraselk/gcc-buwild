#!/usr/bin/env bash

echo "*****************************************"
echo "*        Download GCC & Binutils        *"
echo "*****************************************"

download() {
        git clone --depth=1 -b master git://sourceware.org/git/binutils-gdb.git binutils
        git clone --depth=1 -b master git://gcc.gnu.org/git/gcc.git gcc
        git clone --depth=1 -b dev https://github.com/facebook/zstd zstd
        cd gcc
        git apply -3 \
        ../patches/0001* \
        ../patches/0002* \
        ../patches/0003* ||
        (echo " * Failed to apply patches * " && exit 1)
        
    ./contrib/download_prerequisites
    mkdir -p ../kernel
    cd ../kernel
    git init .
    git remote add origin https://github.com/mengkernel/kernel_xiaomi_sm8250.git
    cd ..
    sed -i '/^development=/s/true/false/' binutils/bfd/development.sh
}

download
