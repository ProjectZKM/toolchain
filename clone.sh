#!/bin/sh

CWD=`pwd`

. "$HOME/.cargo/env"
RUSTUP_PERMIT_COPY_RENAME=true rustup toolchain install nightly
RUSTUP_PERMIT_COPY_RENAME=true rustup default nightly

if [ -d rust-workspace ];then
	rm -rf rust-workspace/library/stdarch
	git -C rust-workspace checkout .
	git -C rust-workspace pull --rebase
else
	git clone https://github.com/ProjectZKM/rust-workspace.git
fi

#sed -i 's@rust-lang/llvm-project.git@ProjectZKM/llvm-project.git@' rust-workspace/.gitmodules
#sed -i 's@= rustc/20.1-2025-02-13@= zkm-rustc/20.1-2025-02-13@' rust-workspace/.gitmodules
git -C rust-workspace checkout Triple_mips-zkm-zkvm-elf
git -C rust-workspace submodule update --init --recursive

#sed -i 's/mips2/mips32r2/g' rust-workspace/compiler/rustc_target/src/spec/targets/mips*_zkm_zkvm_elf.rs
#sed -i 's/+mips32r2,/+mips32r2,+inst-same-cost,/g' rust-workspace/compiler/rustc_target/src/spec/targets/mips*_zkm_zkvm_elf.rs

#sed -i 's@^cc =.*@cc = { git = "https://github.com/ProjectZKM/cc-rs.git", branch = "Triple_mips-zkm-zkvm-elf" }@' rust-workspace/src/bootstrap/Cargo.toml
cp -f rust-workspace/bootstrap.example.toml rust-workspace/bootstrap.toml
sed -i.backup "s@#install.prefix = .*@install.prefix = \"$CWD/rust-staged\"@" rust-workspace/bootstrap.toml
sed -i.backup 's@#install.sysconfdir = .*@install.sysconfdir = "etc"@' rust-workspace/bootstrap.toml
sed -i.backup 's@#build.docs = .*@build.docs = false@' rust-workspace/bootstrap.toml
sed -i.backup 's@#rust.lld = .*@rust.lld = true@' rust-workspace/bootstrap.toml
sed -i.backup 's@#llvm.download-ci-llvm = .*@llvm.download-ci-llvm = false@' rust-workspace/bootstrap.toml
sed -i.backup 's@#llvm.clang = .*@llvm.clang = true@' rust-workspace/bootstrap.toml
sed -i.backup 's@#build.extended = .*@build.extended = true@' rust-workspace/bootstrap.toml


if [ -d cargo ];then
	git -C cargo checkout .
	git -C cargo clean -fdx
	git -C cargo pull --rebase
else
	git clone https://github.com/rust-lang/cargo.git
fi

if [ -d rust-clippy ];then
	git -C rust-clippy checkout .
	git -C rust-clippy clean -fdx
	git -C rust-clippy pull --rebase
else
	git clone https://github.com/rust-lang/rust-clippy.git
fi

if [ -d zkm ];then
	git -C zkm checkout .
	git -C zkm clean -fdx
	git -C zkm pull --rebase
else
	git clone https://github.com/ProjectZKM/zkm.git
fi

if [ -d Ziren ];then
	git -C Ziren checkout .
	git -C Ziren clean -fdx
	git -C Ziren pull --rebase
else
	git clone https://github.com/ProjectZKM/Ziren.git
fi

if [ -d zkvm-benchmarks ];then
	git -C zkvm-benchmarks checkout .
	git -C zkvm-benchmarks clean -fdx
	git -C zkvm-benchmarks pull --rebase
else
	git clone https://github.com/ProjectZKM/zkvm-benchmarks.git
fi
