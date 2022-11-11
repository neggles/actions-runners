FROM ghcr.io/neggles/actions-runners/actions-runner:debian-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -yq update \
    && sudo apt-get -yq upgrade

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

RUN sudo rm -rf /var/lib/apt/lists/*
