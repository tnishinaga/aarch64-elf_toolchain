FROM ubuntu:disco
LABEL Toshifumi NISHINAGA <tnishinaga.dev@gmail.com>

# install curl first to install aarch64-toolchain
# bacause this download takes long time
RUN apt-get update \
    && apt-get -y install \
        curl \
        xz-utils \
        libtinfo5 \
        libncursesw5 \
        libpython2.7 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# get aarch64 baremetal toolchain
RUN mkdir -p /opt/ \
    && curl -SL https://armkeil.blob.core.windows.net/developer/Files/downloads/gnu-a/8.3-2019.03/binrel/gcc-arm-8.3-2019.03-x86_64-aarch64-elf.tar.xz | tar -JxC /opt/ \
    && ln -s /opt/gcc-arm-8.3-2019.03-x86_64-aarch64-elf /opt/aarch64-elf
ENV PATH $PATH:/opt/aarch64-elf/bin

RUN apt-get update \
    && apt-get -y install \
        build-essential \
        cmake \
        ninja-build \
        emacs-nox \
        vim \
        less \
        qemu-system-arm \
        tmux \
        iputils-ping \
        git \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /home/work
WORKDIR /home/work

CMD ["/bin/bash"]
