FROM ghcr.io/neggles/actions-runners/actions-runner:debian-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -yq update \
    && sudo apt-get -yq upgrade

# vmdb2 & kernel dependencies etc.
RUN sudo apt-get -yq install \
        apt-utils \
        build-essential \
        crossbuild-essential-arm64 \
        device-tree-compiler \
        curl

RUN sudo apt-get -yq install \
        autoconf \
        bc \
        bison \
        flex \
        cpio \
        dkms \
        kmod \
        fakeroot \
        quilt \
        rsync \
        dh-exec \
        genisoimage \
        myrepos

RUN sudo apt-get -yq install \
        libssl-dev \
        libncurses-dev \
        libelf-dev \
        libudev-dev \
        libpci-dev \
        libiberty-dev

# debos dependencies
RUN sudo apt-get -yq install \
        gdisk \
        fdisk \
        parted \
        pkg-config \
        qemu-system-x86 \
        qemu-user-static \
        qemu-utils \
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
