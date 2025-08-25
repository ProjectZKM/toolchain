#!/bin/sh

CWD=`pwd`
cd $CWD/binutils-gdb
rm -rf build && mkdir build
cd build
../configure --target=mipsel-mti-elf --prefix=$CWD/binutils-gdb/build/dest --disable-gdb --disable-sim
make -j
make install
