#!/bin/sh -xe
# Script to install linuxdeploy with qt plugin

[ "$LINUXDEPLOY_GIT" ] || LINUXDEPLOY_GIT="https://github.com/linuxdeploy/linuxdeploy.git"
[ "$LINUXDEPLOY_COMMIT" ] || LINUXDEPLOY_COMMIT="17ca786a2523a375617a8b274f70cef9c7189373" # Jul 13, 2023
[ "$LINUXDEPLOY_QT_GIT" ] || LINUXDEPLOY_QT_GIT="https://github.com/linuxdeploy/linuxdeploy-plugin-qt.git"
[ "$LINUXDEPLOY_QT_COMMIT" ] || LINUXDEPLOY_QT_COMMIT="9a388d32b1e95d8b69e201356f050137eb6c0aa3" # May 25, 2023

# Init the package system
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install the required packages to install linuxdeploy'
echo

apt install -y git libboost-filesystem-dev libboost-regex-dev cimg-dev wget patchelf nlohmann-json3-dev build-essential

echo
echo '--> Download & install the linuxdeploy'
echo

git clone "$LINUXDEPLOY_GIT" /tmp/linuxdeploy
git -C /tmp/linuxdeploy checkout "$LINUXDEPLOY_COMMIT"
git -C /tmp/linuxdeploy submodule update --init --recursive
git clone "$LINUXDEPLOY_QT_GIT" /tmp/linuxdeploy-plugin-qt
git -C /tmp/linuxdeploy-plugin-qt checkout "$LINUXDEPLOY_QT_COMMIT"
git -C /tmp/linuxdeploy-plugin-qt submodule update --init --recursive

cmake /tmp/linuxdeploy -B /tmp/linuxdeploy-build -G Ninja -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DUSE_CCACHE=OFF
cmake --build /tmp/linuxdeploy-build

cmake /tmp/linuxdeploy-plugin-qt -B /tmp/linuxdeploy-plugin-qt-build -G Ninja -DCMAKE_INSTALL_PREFIX=/usr/local -DCMAKE_BUILD_TYPE=Release -DUSE_CCACHE=OFF
cmake --build /tmp/linuxdeploy-plugin-qt-build

mkdir -p /usr/local/bin
mv /tmp/linuxdeploy-build/bin/linuxdeploy /usr/local/bin
mv /tmp/linuxdeploy-plugin-qt-build/bin/linuxdeploy-plugin-qt /usr/local/bin

echo
echo '--> Restore the packages list to the original state'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_curr.lst
grep -Fxv -f /tmp/packages_orig.lst /tmp/packages_curr.lst | xargs apt remove -y --purge

# Complete the cleaning

apt -qq clean
rm -rf /var/lib/apt/lists/* /tmp/linuxdeploy*
