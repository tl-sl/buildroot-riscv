FROM debian:bookworm

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Docker
# RUN apt-get update && apt-get install -y --no-install-recommends \
#         apt-transport-https \
#         ca-certificates \
#         curl \
#         gpg-agent \
#         gpg \
#         dirmngr \
#         software-properties-common \
#     && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg \
#     && echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker.gpg] \
#         https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list \
#     && apt-get update && apt-get install -y --no-install-recommends \
#         docker-ce \
#     && rm -rf /var/lib/apt/lists/*

# Build tools
RUN apt-get update && apt-get install -y --no-install-recommends \
    android-sdk-libsparse-utils \
    autoconf \
    automake \
    bash \
    bc \
    binutils \
    bison \
    build-essential \
    bzip2 \
    cmake \
    cpio \
    curl \
    device-tree-compiler \
    dosfstools \
    expect \
    fakeroot \
    file \
    flex \
    gcc \
    genext2fs \
    git \
    git \
    graphviz \
    jq \
    libncurses5-dev \
    libssl-dev \
    libtool \
    make \
    mtools \
    ncurses-dev \
    ninja-build \
    openssh-client \
    parallel \
    patch \
    perl \
    pkg-config \
    python3 \
    python3-dev \
    python3-distutils \
    python3-matplotlib \
    python3-pip \
    python-is-python3 \
    qemu-utils \
    rsync \
    scons \
    skopeo \
    slib \
    squashfs-tools \
    ssh \
    sudo \
    tcl \
    tree \
    unzip \
    vim \
    wget \
    zip \
    && rm -rf /var/lib/apt/lists/*

# Install toolchain
# https://smlight.tech/tmp/host-tools.tar.gz
# https://sophon-file.sophon.cn/sophon-prod-s3/drive/23/03/07/16/host-tools.tar.gz
# RUN \
#     mkdir -p /opt/sophgo \
#     && wget https://smlight.tech/tmp/host-tools.tar.gz \
#     && tar -xz -C /opt/sophgo -f host-tools.tar.gz \
#     && rm host-tools.tar.gz

# ENV PATH="$PATH:/opt/sophgo/host-tools/gcc/riscv64-linux-x86_64/bin"
# Init entry
COPY scripts/entry.sh /usr/sbin/
ENTRYPOINT ["/usr/sbin/entry.sh"]

# Get buildroot
WORKDIR /build
