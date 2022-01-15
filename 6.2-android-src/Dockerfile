# Image: stateoftheartio/qt6:6.2-android-src

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

#TODO: ARG QT_URL=https://download.qt.io/official_releases/qt/6.2/6.2.0/single/qt-everywhere-src-6.2.0.tar.xz
ARG QT_VERSION=6.2.0
ARG QT_URL=https://download.qt.io/development_releases/qt/6.2/6.2.0-rc2/single/qt-everywhere-src-6.2.0-rc2.tar.xz
ARG QT_SHA256=3900cd2897b195c187fb2971c447d5bfab9b6f2f2e4d6f384eae4d5efff82b34
ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates curl ninja-build python3 openjdk-8-jdk-headless locales"

ARG ANDROID_NATIVE_API_LEVEL=29
ARG SDK_PLATFORM=android-${ANDROID_NATIVE_API_LEVEL}
ARG SDK_PATH=/opt/android-sdk
ARG SDK_BUILD_TOOLS=${ANDROID_NATIVE_API_LEVEL}.0.3
ARG SDK_PACKAGES="tools platform-tools"
ARG NDK_VERSION=21.4.7075529

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_PATH=${QT_PATH} \
    QT_ANDROID=${QT_PATH}/${QT_VERSION}/android \
    ANDROID_HOME=${SDK_PATH} \
    ANDROID_SDK_ROOT=${SDK_PATH} \
    ANDROID_SDK_BUILD_TOOLS=${SDK_BUILD_TOOLS} \
    ANDROID_NDK_ROOT=${SDK_PATH}/ndk/${NDK_VERSION} \
    ANDROID_NDK_HOST=linux-x86_64 \
    ANDROID_NDK_PLATFORM=${SDK_PLATFORM} \
    ANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL} \
    PATH=${QT_PATH}/bin:${SDK_PATH}/cmdline-tools/latest/bin:${SDK_PATH}/platform-tools:$PATH

COPY get_android.sh build_cmake.sh build_qt.sh install_packages.sh /tmp/

# Get android sdk & ndk
RUN /tmp/get_android.sh

# Download & build CMake sources
RUN /tmp/build_cmake.sh

# Download & build Qt sources
RUN /tmp/build_qt.sh

# Install the required packages
RUN /tmp/install_packages.sh

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Add group & user + sudo
RUN groupadd -r user && useradd --create-home --gid user user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
ENV HOME /home/user
