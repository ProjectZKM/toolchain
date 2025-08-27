#!/bin/sh

origin_dir=`pwd`
mkdir -p ~/.zkm-toolchain/bin
cd ~/.zkm-toolchain
curl https://raw.githubusercontent.com/ProjectZKM/toolchain/refs/heads/main/zkmup -o bin/zkmup
chmod +x ~/.zkm-toolchain/bin/zkmup 
cd $origin_dir
~/.zkm-toolchain/bin/zkmup install
~/.zkm-toolchain/bin/zkmup setup
