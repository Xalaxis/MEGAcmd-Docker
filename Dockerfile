FROM ubuntu:bionic


# Make sure package lists are fresh
RUN apt-get update

# https://github.com/meganz/MEGAcmd#requirements
RUN apt-get install autoconf libtool g++ libcrypto++-dev libz-dev libsqlite3-dev \
libssl-dev libcurl4-gnutls-dev libreadline-dev libpcre++-dev libsodium-dev \
libc-ares-dev libfreeimage-dev libavcodec-dev libavutil-dev libavformat-dev \
libswscale-dev libmediainfo-dev libzen-dev libuv1-dev -y

# Collect the source
# We need Git to do that
RUN apt-get install git -y

RUN git clone https://github.com/meganz/MEGAcmd.git
WORKDIR /MEGAcmd
RUN git submodule update --init --recursive

# Compile

RUN apt-get install make autoconf automake -y

RUN ./autogen.sh
RUN ./configure
RUN make
RUN make install
RUN ldconfig

LABEL REPO="https://github.com/Xalaxis/MEGAcmd-Docker"

ENTRYPOINT [ "mega-cmd" ]