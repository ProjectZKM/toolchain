#!/bin/sh

CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p'`

export PATH=$CWD/rust-workspace/build/$TARGET/llvm/bin:$PATH
CLANG_RESOURCE_DIR=`clang --print-resource-dir`
export ac_cv_path_RANLIB_FOR_TARGET=llvm-ranlib
export ac_cv_path_AR_FOR_TARGET=llvm-ar
export CC_FOR_TARGET=clang

cd $CWD/newlib
rm -rf build-mipsel && mkdir build-mipsel && cd build-mipsel
export CFLAGS_FOR_TARGET="--target=mipsel-mti-elf -msoft-float -nostdinc -I${CLANG_RESOURCE_DIR}/include -no-integrated-as -B ${CWD}/binutils-gdb/build/dest/mipsel-mti-elf/bin"
../configure --target=mipsel-zkm-elf --prefix=$CWD/newlib/build-mipsel/dest
make -j
make install
rm -rf $CWD/rust-staged/lib/mipsel-zkm-elf
cp -r $CWD/newlib/build-mipsel/dest/mipsel-zkm-elf $CWD/rust-staged/lib

cd $CWD/newlib
rm -rf build-mips && mkdir build-mips && cd build-mips
export CFLAGS_FOR_TARGET="--target=mips-mti-elf -msoft-float -nostdinc -I${CLANG_RESOURCE_DIR}/include -no-integrated-as -B ${CWD}/binutils-gdb/build/dest/mipsel-mti-elf/bin"
../configure --target=mips-zkm-elf --prefix=$CWD/newlib/build-mips/dest
make -j
make install
rm -rf $CWD/rust-staged/lib/mips-zkm-elf
cp -r $CWD/newlib/build-mips/dest/mips-zkm-elf $CWD/rust-staged/lib
