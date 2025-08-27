#!/bin/sh

CWD=`pwd`
export PATH=${CWD}/rust-staged/bin:$PATH
export ZIREN_ZKM_CC=mipsel-zkm-zkvm-elf-gcc 
cargo --version
rustc --version

## FAIL due to ring 0.16.20 too old
#cd $CWD
#cd zkm/prover/examples/keccak
#cargo clean
#RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

## FAIL due to ring 0.16.20 too old
#cd $CWD
#cd zkm/prover/examples/prove-large-seg
#cargo clean
#RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/prove-seg
cargo clean
RUST_LOG=info SEG_FILE_DIR=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/revme/host
cargo clean
RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/sha2-rust/host
cargo clean
ARGS="711e9609339e92b03ddc0a211827dba421f38f9ed8b9d806e1ffdd8c15ffa03d world!" RUST_LOG=info SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/sha2-composition/host
cargo clean
RUST_LOG=info PRECOMPILE_PATH=../../sha2-rust/guest/elf/mips-zkm-zkvm-elf SEG_OUTPUT=/tmp/output cargo run --release

cd $CWD
cd zkm/prover/examples/split-seg
cargo clean
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_SIZE=65536 ARGS="" cargo run --release
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_START_ID=0 SEG_NUM=1 SEG_SIZE=65536 cargo run --release
BASEDIR=../../../emulator/test-vectors RUST_LOG=info ELF_PATH=../../../emulator/test-vectors/minigeth BLOCK_NO=13284491 SEG_OUTPUT=/tmp/output SEG_START_ID=0 SEG_NUM=299 SEG_SIZE=65536 cargo run --release



cd $CWD
cd Ziren/examples/aggregation/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/bitcoin/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/bn254/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/chess/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/cycle-tracking/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/fibonacci/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
#cd Ziren/examples/fibonacci_c_lib/host
#cargo clean
#RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/groth16/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/groth16/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/is-prime/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/json/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD # FAILED: assertion `left == right` failed
#cd Ziren/examples/keccak-precompile/host
#cargo clean
#RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/plonk/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/regex/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/rsa/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/ssz-withdrawals/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/tendermint/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd Ziren/examples/unconstrained/host
cargo clean
RUST_LOG=info cargo run --release

cd $CWD
cd zkvm-benchmarks/ziren
cargo clean
RUSTFLAGS="-C target-cpu=native" cargo run -r --bin modpow

cd $CWD
cd zkvm-benchmarks/ziren
cargo clean
RUSTFLAGS="-C target-cpu=native" cargo run -r --bin sha3

cd $CWD
cd reth-processor
cargo clean
cargo run -r --bin host -- --block-number 18884864 --chain-id 1 --cache-dir ./bin/host
