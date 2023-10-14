# Image: stateoftheartio/qt6:6.6-wasm-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# PIP requirement like "aqtinstall==2.0.6" or url with egg file
ARG AQT_VERSION="aqtinstall==3.1.7"

ARG QT_VERSION=6.6.0
ARG QT_PATH=/opt/Qt

ARG SDK_PATH=/opt/emsdk
ARG SDK_VERSION=3.1.37
ARG SDK_SHA256=c3c80dfe82fb448751d1c48200e5143aeca0f0db1d021db4b63655a9d9470cd8

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates curl python3 locales"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_PATH=${QT_PATH} \
    QT_WASM=${QT_PATH}/${QT_VERSION}/wasm_singlethread \
    EMSDK=${SDK_PATH} \
    EMSDK_NODE=${SDK_PATH}/node/15.14.0_64bit/bin/node \
    PATH=$PATH:${QT_PATH}/Tools/CMake/bin:${QT_PATH}/Tools/Ninja:${QT_PATH}/${QT_VERSION}/wasm_singlethread/bin:${SDK_PATH}/upstream/bin:${SDK_PATH}/upstream/emscripten:${SDK_PATH}/node/15.14.0_64bit/bin:${SDK_PATH}

COPY get_emsdk.sh get_qt.sh install_packages.sh /tmp/

# Install emscripten
RUN /tmp/get_emsdk.sh

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
