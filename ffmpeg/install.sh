#!/bin/bash
# dependencies: autoconf automake build-essential git-core libass-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev libmp3lame-dev nasm gcc yasm 
set -e
set -o xtrace
START_DIR=/build
rm -rf "$START_DIR/ffmpeg_sources" "$START_DIR/ffmpeg_build" "$START_DIR/bin"
mkdir -p "$START_DIR/ffmpeg_sources" "$START_DIR/ffmpeg_build"

cd $START_DIR/ffmpeg_sources && \
  git clone --depth 1 git://github.com/mstorsjo/fdk-aac.git && \
  cd fdk-aac && \
  autoreconf -fiv && \
  ./configure --prefix="$START_DIR/ffmpeg_build" --disable-shared && \
  make && \
  make install && \
  make distclean

cd $START_DIR/ffmpeg_sources && \
  wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && \
  tar xzvf lame-3.99.5.tar.gz && \
  cd lame-3.99.5 && \
  ./configure --prefix="$START_DIR/ffmpeg_build" --enable-nasm --disable-shared && \
  make && \
  make install && \
  make distclean

cd $START_DIR/ffmpeg_sources && \
  git clone --depth 1 git://source.ffmpeg.org/ffmpeg && \
  cd ffmpeg && \
  PKG_CONFIG_PATH="$START_DIR/ffmpeg_build/lib/pkgconfig" && \
  export PKG_CONFIG_PATH && \
  ./configure --prefix="$START_DIR/ffmpeg_build" \
    --extra-cflags="-I$START_DIR/ffmpeg_build/include" --extra-ldflags="-L$START_DIR/ffmpeg_build/lib" \
    --bindir="$START_DIR/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
    --enable-libmp3lame --enable-nonfree && \
  make && \
  make install && \
  make distclean

$START_DIR/bin/ffmpeg 2>&1 | head -n1

cd /build/bin && \
    docker build -t ffmpeg .
