#!/bin/sh

CWD=`pwd`
cd $CWD/binutils-gdb
rm -rf build && mkdir build
cd build
CFLAGS="-g -O3 -Wno-strict-prototypes -Wno-sign-compare" \
   ../configure --target=mipsel-mti-elf --prefix=$CWD/binutils-gdb/build/dest --disable-gdb --disable-sim
make -j
make install
