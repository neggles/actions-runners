FROM ghcr.io/neggles/actions-runners/actions-runner:debian-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -yq update \
    && sudo apt-get -yq upgrade

# kernel and u-boot build dependencies
RUN sudo apt-get -yq install \
        apt-utils \
        build-essential \
        crossbuild-essential-arm64 \
        device-tree-compiler \
        curl

RUN sudo apt-get -yq install \
        apt-transport-https \
        autoconf \
        bc \
        bison \
        flex \
        cpio \
        dkms \
        kmod \
        pkg-config \
        quilt \
        rsync

RUN sudo apt-get -yq install \
        libssl-dev \
        libncurses-dev \
        libelf-dev \
        libudev-dev \
        libpci-dev \
        libiberty-dev

# debos dependencies
RUN sudo apt-get -yq install \
        bmap-tools \
        gdisk \
        fdisk \
        parted \
        binfmt-support \
        qemu-system-x86 \
        qemu-user-static \
        qemu-utils \
        fakeroot \
        dh-exec \
        genisoimage \
        myrepos \
        pigz \
        bzip2 \
        xz-utils \
        u-boot-tools \
        equivs \
        e2fsprogs \
        xfsprogs \
        f2fs-tools

RUN sudo rm -rf /var/lib/apt/lists/*

# debian's qemu-user-static package no longer registers binfmts
# if running inside a virtualmachine; dockerhub builds are inside a vm
RUN for arch in aarch64 arm armeb mips mips64 mips64el mipsel mipsn32 mipsn32el ppc ppc64 ppc64le riscv32 riscv64; do \
      update-binfmts --import qemu-$arch; \
    done
