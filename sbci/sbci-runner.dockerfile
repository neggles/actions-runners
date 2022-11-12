FROM ghcr.io/neggles/actions-runners/actions-runner:debian-bookworm

ARG DEBIAN_FRONTEND=noninteractive

RUN sudo apt-get -yq update \
    && sudo apt-get -yq upgrade --auto-remove

# kernel and u-boot build dependencies
RUN sudo apt-get -yq install --no-install-recommends \
        apt-utils \
        build-essential \
        crossbuild-essential-arm64 \
        device-tree-compiler \
        curl

RUN sudo apt-get -yq install --no-install-recommends \
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

RUN sudo apt-get -yq install --no-install-recommends \
        libssl-dev \
        libncurses-dev \
        libelf-dev \
        libudev-dev \
        libpci-dev \
        libiberty-dev

# debos dependencies
RUN sudo apt-get -yq install --no-install-recommends \
        bmap-tools \
        gdisk \
        fdisk \
        parted \
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

# # qemu static support - not needed for now
# RUN sudo apt-get -yq install --no-install-recommends \
#         qemu-system-arm \
#         qemu-system-mips \
#         binfmt-support \
#         qemu-user-static
# # debian's qemu-user-static package no longer registers binfmts
# # if running inside a virtualmachine; dockerhub builds are inside a vm
# RUN for arch in aarch64 arm armeb mips mipsel mips64 mips64el; do \
#       sudo update-binfmts --import qemu-$arch; \
#     done

# print package disk usage summary
RUN dpkg-query -Wf '${Installed-Size}\t${Package}\n' | grep -vE '^\s' | sort -h \
        | numfmt --field=1 --from-unit=1024 --to=iec-i --suffix=B --padding=7 --round=up \
        | grep -v 'KiB'

# clear apt cache
RUN sudo rm -rf /var/lib/apt/lists/*
