#!/bin/sh -e
# Script to get emscripten sdk

[ "$SDK_VERSION" ] || SDK_VERSION=2.0.30
[ "$SDK_URL" ]    || SDK_URL="https://github.com/emscripten-core/emsdk/archive/refs/tags/$SDK_VERSION.tar.gz"
[ "$SDK_SHA256" ] || SDK_SHA256=69050d76c8907a58f99b08831e8cb7a4fba857efec6037d5e59df4b73111ba36

[ "$SDK_PATH" ] || SDK_PATH=/opt/emsdk

root_dir=$PWD
[ "$root_dir" != '/' ] || root_dir=""

# Init the package system
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install Android SDK & NDK'
echo

apt install -y curl python-is-python3

echo "$SDK_SHA256 -" > sum.txt && curl -fLs "$SDK_URL" | tee /tmp/emsdk.tar.gz | sha256sum -c sum.txt
mkdir -p "$SDK_PATH"
tar --strip-components 1 -C "$SDK_PATH" -xf /tmp/emsdk.tar.gz
rm -f /tmp/emsdk.tar.gz
emsdk install "$SDK_VERSION"
emsdk activate "$SDK_VERSION"

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
