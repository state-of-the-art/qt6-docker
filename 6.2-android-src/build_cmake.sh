#!/bin/sh -e
# Script to build cmake in docker container

[ "$CMAKE_VERSION" ] || CMAKE_VERSION=3.21.3
[ "$CMAKE_URL" ] || CMAKE_URL="https://github.com/Kitware/CMake/releases/download/v$CMAKE_VERSION/cmake-$CMAKE_VERSION.tar.gz"
[ "$CMAKE_SHA256" ] || CMAKE_SHA256=d14d06df4265134ee42c4d50f5a60cb8b471b7b6a47da8e5d914d49dd783794f

root_dir=$PWD
[ "$root_dir" != '/' ] || root_dir=""

# Init the package system
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install the required packages to build CMake'
echo

apt install -y curl build-essential libssl-dev

# Build fresh CMake, Qt 6.2 requires at least 2.19

echo "$CMAKE_SHA256 -" > sum.txt && curl -fLs "$CMAKE_URL" | tee /tmp/cmake.tar.gz | sha256sum -c sum.txt
mkdir -p $root_dir/build/cmake-build ; cd $root_dir/build/cmake-build
tar --strip-components 1 -xf /tmp/cmake.tar.gz
rm -f /tmp/cmake.tar.gz
./bootstrap --parallel=16
make -j 16
make install

echo
echo '--> Restore the packages list to the original state'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_curr.lst
grep -Fxv -f /tmp/packages_orig.lst /tmp/packages_curr.lst | xargs apt remove -y --purge

# Complete the cleaning

cd /tmp
rm -rf $root_dir/build
apt -qq clean
rm -rf /var/lib/apt/lists/*
