#!/bin/bash
# dependencies: autoconf automake build-essential git-core libass-dev libgpac-dev libsdl1.2-dev libtheora-dev libtool libvdpau-dev libvorbis-dev libx11-dev libxext-dev libxfixes-dev pkg-config texi2html zlib1g-dev libmp3lame-dev nasm gcc yasm 
set -e
set -o xtrace
echo test
START_DIR=/build
mkdir -p "$START_DIR/ffmpeg_sources" "$START_DIR/bin"

cd $START_DIR/ffmpeg_sources && \
  git clone --depth 1 https://github.com/mstorsjo/fdk-aac.git && \
  cd fdk-aac && \
  autoreconf -fiv && \
  ./configure --disable-shared && \
  make && \
  make install && \
  make distclean

cd $START_DIR/ffmpeg_sources && \
    wget http://downloads.sourceforge.net/project/lame/lame/3.99/lame-3.99.5.tar.gz && \
  tar xfzv lame-3.99.5.tar.gz && \
  cd lame-3.99.5 && \
  ./configure --enable-nasm --disable-shared && \
  make && \
  make install && \
  make distclean

cd $START_DIR/ffmpeg_sources && \
  git clone --depth 1 git://source.ffmpeg.org/ffmpeg && \
  cd ffmpeg && \
  ./configure --bindir="$START_DIR/bin" --extra-libs="-ldl" --enable-gpl --enable-libass --enable-libfdk-aac \
    --enable-libmp3lame --enable-nonfree && \
  make && \
  make install && \
  make distclean

$START_DIR/bin/ffmpeg 2>&1 | head -n1

