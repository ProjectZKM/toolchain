FROM rockylinux/rockylinux:9 AS fetcher

RUN \
  useradd --create-home -u 50000 -G 100 jenkins
RUN \
  dnf install -y 'dnf-command(config-manager)' && \
  dnf config-manager --set-enabled crb && \
  dnf install -y epel-release
RUN \
  dnf install -y git gcc-c++ cmake ninja-build openssl-devel zstd xz patchelf zlib-devel \
		protobuf-compiler golang clang-devel ccache texinfo bison flex lld

USER jenkins

RUN \
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs -o /tmp/rustup.sh && \
  sh /tmp/rustup.sh -y && \
  . "$HOME/.cargo/env" && \
  rustup toolchain install nightly && \
  rustup default nightly


WORKDIR /directory

CMD ["bash"]

