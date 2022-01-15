#!/bin/sh -e
# Script to build Qt 6 in docker container

[ "$QT_URL" ] || exit 1
[ "$QT_SHA256" ] || exit 1

[ "$QT_PATH" ] || QT_PATH=/opt/Qt
[ "$QT_BUILD_PACKAGES" ] || QT_BUILD_PACKAGES='ninja-build python2 python-is-python2 gperf bison flex pkg-config libicu-dev libmysqlclient-dev libpq-dev ^libxcb.*-dev libx11-dev libx11-xcb-dev libxcomposite-dev libxrandr-dev libxcursor-dev libxshmfence-dev libgl1-mesa-dev libglu1-mesa-dev libxrender-dev libxi-dev libxkbcommon-dev libxkbcommon-x11-dev libxkbfile-dev libfontconfig1-dev libxfixes-dev libxext-dev libxdamage-dev x11proto-record-dev libxtst-dev libatspi2.0-dev libatk-bridge2.0-dev libnss3-dev libdbus-1-dev libxslt-dev libxml2-dev libzstd-dev libsystemd-dev libproxy-dev libdrm-dev libgbm-dev libinput-dev libmtdev-dev libcups2-dev unixodbc-dev libmng-dev liblttng-ust-dev libvulkan-dev libasound-dev libavcodec-dev libavformat-dev libgstreamer1.0-dev libpulse-dev libwmf-dev libbluetooth-dev clang-12 libclang*-dev llvm-12-dev libudev-dev libhunspell-dev libwayland-dev wayland-scanner++ libsnappy-dev nodejs libts-dev libdirectfb-dev'

root_dir=$PWD
[ "$root_dir" != '/' ] || root_dir=""

# Init the package system
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install & build the required packages to build Qt'
echo

apt install -y curl build-essential libssl-dev
apt install -y --no-install-suggests --no-install-recommends $QT_BUILD_PACKAGES

echo
echo '--> Download & unpack the Qt source code'
echo

mkdir -p $root_dir/build/qt-src ; cd $root_dir/build/qt-src
echo "$QT_SHA256 -" > sum.txt && curl -fLs "$QT_URL" | tee /tmp/qt.tar.xz | sha256sum -c sum.txt
tar --strip-components 1 -xf /tmp/qt.tar.xz
rm -f /tmp/qt.tar.xz

echo
echo '--> Build the Qt source code'
echo

mkdir -p $root_dir/build/qt-build ; cd $root_dir/build/qt-build
# Config options useful doc: https://doc-snapshots.qt.io/qt6-dev/configure-options.html
../qt-src/configure -prefix "$QT_GCC_64" -nomake examples -nomake tests \
    -no-feature-linguist -no-feature-designer \
    -eventfd -inotify -qt-zlib -qt-libjpeg -qt-libpng -qt-freetype -qt-pcre -qt-harfbuzz 
cmake --build . --parallel
ninja -j 16 install/strip

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
