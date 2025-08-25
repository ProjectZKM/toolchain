#!/bin/sh

. "$HOME/.cargo/env"
CWD=`pwd`
TARGET=`rustc -vV | sed -n 's|host: ||p'`

rm -rf $CWD/rust-staged

cd $CWD/rust-workspace
for i in `ls -d build/* | grep -v '^build/cache'`;do
        rm -rf $i
done
./x build library
./x build --stage 2 compiler/rustc
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x build --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf
BOOTSTRAP_SKIP_TARGET_SANITY=1 ./x install --target ${TARGET},mips-zkm-zkvm-elf,mipsel-zkm-zkvm-elf
cp -f /usr/lib64/libcrypto.so.3* /usr/lib64/libssl.so.3* $CWD/rust-staged/lib
cp -rf ./build/${TARGET}/stage2/lib/rustlib/${TARGET}/lib/* $CWD/rust-staged/lib/rustlib/${TARGET}/lib

cp -rf ./build/${TARGET}/llvm/lib/clang $CWD/rust-staged/lib
cp -f ./build/${TARGET}/llvm/bin/clang $CWD/rust-staged/bin
ln -sf clang $CWD/rust-staged/bin/clang++


cd $CWD
cp -f toolchain/gcc-wrapper/mips*-gcc $CWD/rust-staged/bin
sh -x toolchain/build-binutils.sh
sh -x toolchain/build-newlib.sh

cd $CWD
rm -f $CWD/rust-staged/buildinfo
echo "Rustc:" >> $CWD/rust-staged/buildinfo
git -C rust-workspace log -1 >> $CWD/rust-staged/buildinfo
echo >> $CWD/rust-staged/buildinfo

cat $CWD/rust-staged/buildinfo
