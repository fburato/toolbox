FROM ubuntu:xenial

# Install dependencies
RUN apt-get update && \
    apt-get install -y autoconf automake build-essential git-core libass-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev libmp3lame-dev nasm gcc yasm curl && \
    rm -rf /var/lib/apt/lists/*

# Install docker client
RUN curl -fsSL get.docker.com -o get-docker.sh && \
    chmod a+x get-docker.sh && \
    ./get-docker.sh && \
    rm -rf /var/lib/apt/lists/* get-docker.sh

RUN mkdir /build
ADD install.sh /build/install.sh
RUN chmod a+x /build/install.sh

WORKDIR /build

RUN ./install.sh

ADD Dockerfile-internal /build/bin/Dockerfile

RUN cd /build/bin && \
    docker build -t ffmpeg .
