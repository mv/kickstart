#!/bin/bash
#
# Install devel packages
#
# ferreira.mv[ at ]gmail.com
# 2011/11

usage() {

    echo
    echo "Usage: $0 -i|-r"
    echo
    echo "    $0 -i: install devel packages"
    echo "    $0 -r: remove  devel packages"
    echo
    exit 2
}

case "$1" in
    "-i") cmd="yum install -y"
          ;;
    "-r") cmd="yum remove -y"
          ;;
    *) usage
        ;;
esac

pre_req="
    curl-devel
    expat-devel
    freetype-devel.x86_64
    gdbm-devel
    gettext-devel
    glibc-devel
    glibc-headers
    kernel-devel
    kernel-headers
    libevent-devel
    libgcrypt-devel
    libncurses-devel
    libxml2-devel
    libxslt-devel
    openssl-devel
    readline-devel
    rpm-devel
    zlib-devel"

tools="make patch gcc gcc-c++ bison rpm-build"

$cmd $tools $pre_req

# vim:ft=sh

