# Image: stateoftheartio/qt6:6.8-android-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# PIP requirement like "aqtinstall==2.0.6" or url with egg file
ARG AQT_VERSION="aqtinstall==3.1.18"

ARG QT_VERSION=6.8.0
ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates curl python3 openjdk-17-jdk-headless locales"

ARG ANDROID_NATIVE_API_LEVEL=34
ARG SDK_PLATFORM=android-${ANDROID_NATIVE_API_LEVEL}
ARG SDK_PATH=/opt/android-sdk
ARG SDK_BUILD_TOOLS=${ANDROID_NATIVE_API_LEVEL}.0.0
ARG SDK_PACKAGES="platform-tools"
ARG NDK_VERSION=26.1.10909125
ARG SDK_CMDTOOLS_VERSION=10.0

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_VERSION=${QT_VERSION} \
    AQT_VERSION=${AQT_VERSION} \
    QT_PATH=${QT_PATH} \
    QT_ANDROID=${QT_PATH}/${QT_VERSION}/android_arm64_v8a \
    ANDROID_HOME=${SDK_PATH} \
    ANDROID_SDK_ROOT=${SDK_PATH} \
    ANDROID_SDK_BUILD_TOOLS=${SDK_BUILD_TOOLS} \
    ANDROID_NDK_ROOT=${SDK_PATH}/ndk/${NDK_VERSION} \
    ANDROID_NDK_HOST=linux-x86_64 \
    ANDROID_NDK_PLATFORM=${SDK_PLATFORM} \
    ANDROID_NATIVE_API_LEVEL=${ANDROID_NATIVE_API_LEVEL} \
    PATH=$PATH:${QT_PATH}/Tools/CMake/bin:${QT_PATH}/Tools/Ninja:${QT_PATH}/${QT_VERSION}/android_arm64_v8a/bin:${SDK_PATH}/cmdline-tools/${SDK_CMDTOOLS_VERSION}/bin:${SDK_PATH}/platform-tools

COPY get_android.sh get_qt.sh install_packages.sh /tmp/

# Get android sdk & ndk
RUN /tmp/get_android.sh

# Get Qt binaries with aqt
RUN /tmp/get_qt.sh

# Install the required packages
RUN /tmp/install_packages.sh

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Add group & user + sudo
RUN groupadd -r user && useradd --create-home --gid user user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
ENV HOME /home/user
