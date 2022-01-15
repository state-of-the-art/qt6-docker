#!/bin/sh -e
# Script to install Qt 6 in docker container

[ "$AQT_VERSION" ] || AQT_VERSION=2.0.0rc5
[ "$AQT_URL" ] || AQT_URL="https://github.com/miurahr/aqtinstall/releases/download/v$AQT_VERSION/aqt.exe"
[ "$AQT_SHA256" ] || AQT_SHA256=363942878801155b9741be4b5cf1b5c8a0d248a657ce4900489de896cd7e165b
[ "$QT_VERSION" ] || exit 1

[ "$QT_PATH" ] || QT_PATH=C:\\Qt

root_dir=$PWD
[ "$root_dir" != '/' ] || root_dir=""

# Init the package system
dpkg --add-architecture i386
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install the required packages to install Qt'
echo

apt install -y --no-install-suggests --no-install-recommends curl wine64 wine32
echo "$AQT_SHA256 -" > sum.txt && curl -fLs "$AQT_URL" | tee /tmp/aqt.exe | sha256sum -c sum.txt

echo
echo '--> Download & install the Qt library using aqt'
echo

wine /tmp/aqt.exe install-qt -O "$QT_PATH" windows desktop "$QT_VERSION" win64_mingw81
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_cmake
wine /tmp/aqt.exe install-tool -O "$QT_PATH" windows desktop tools_ninja

echo
echo '--> Restore the packages list to the original state'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_curr.lst
grep -Fxv -f /tmp/packages_orig.lst /tmp/packages_curr.lst | xargs apt remove -y --purge

# Complete the cleaning

apt -qq clean
rm -rf /var/lib/apt/lists/*
