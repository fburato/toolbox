FROM ubuntu:xenial as builder

# Install dependencies
RUN apt-get update && \
    apt-get install -y autoconf automake build-essential git-core libass-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev libmp3lame-dev nasm gcc yasm curl wget && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir /build
COPY install.sh /build/install.sh
RUN chmod a+x /build/install.sh

WORKDIR /build

RUN /build/install.sh

FROM ubuntu:xenial

RUN apt-get update && \
    apt-get install -y libxcb1 libxcb-shape0 libxcb-xfixes0 libasound2 libass5 libmp3lame0 libvdpau1 && \
    rm -rf /var/lib/apt/lists/*

COPY --from=builder /build/bin/ffmpeg /build/bin/ffprobe /bin/

RUN mkdir -p /data
VOLUME /data
WORKDIR /data
