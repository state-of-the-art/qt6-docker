#!/bin/sh -xe
# Script to get android sdk & ndk

[ "$SDK_URL" ]    || SDK_URL="https://dl.google.com/android/repository/commandlinetools-linux-7583922_latest.zip"
[ "$SDK_SHA256" ] || SDK_SHA256=124f2d5115eee365df6cf3228ffbca6fc3911d16f8025bebd5b1c6e2fcfa7faf

[ "$SDK_PATH" ] || SDK_PATH=/opt/android-sdk

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

apt install -y curl unzip openjdk-11-jdk-headless

echo "$SDK_SHA256 -" > sum.txt && curl -fLs "$SDK_URL" | tee /tmp/sdk-tools.zip | sha256sum -c sum.txt
unzip -q /tmp/sdk-tools.zip -d /tmp
rm -f /tmp/sdk-tools.zip
yes | /tmp/cmdline-tools/bin/sdkmanager --install --verbose --sdk_root="$SDK_PATH" "cmdline-tools;${SDK_CMDTOOLS_VERSION}"
rm -rf /tmp/cmdline-tools
sdkmanager --install --verbose "platforms;${SDK_PLATFORM}" "ndk;${NDK_VERSION}" "build-tools;${SDK_BUILD_TOOLS}" ${SDK_PACKAGES}

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
