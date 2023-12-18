# Image: stateoftheartio/qt6:6.6-macos-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# PIP requirement like "aqtinstall==2.0.6" or url with egg file
ARG AQT_VERSION="aqtinstall==3.1.7"
ARG OSXCROSS_URL=https://github.com/tpoechtrager/osxcross/archive/50e86ebca7d14372febd0af8cd098705049161b9.tar.gz
ARG OSXCROSS_SHA256=d0496d5874a3252c4df7ce24bd724e453f85c513505b970e039fd01638fc1ff7

ARG QT_VERSION=6.6.1
ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates curl python3 locales clang genisoimage"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_VERSION=${QT_VERSION} \
    AQT_VERSION=${AQT_VERSION} \
    QT_PATH=${QT_PATH} \
    QT_MACOS=${QT_PATH}/${QT_VERSION}/macos \
    PATH=$PATH:${QT_PATH}/Tools/CMake/bin:${QT_PATH}/Tools/Ninja:${QT_PATH}/${QT_VERSION}/macos/bin:/opt/osxcross/bin

COPY get_qt.sh get_osxcross.sh install_packages.sh /tmp/

# Get Qt binaries with aqt
RUN /tmp/get_qt.sh

# Get osxcross
RUN /tmp/get_osxcross.sh

# Install the required packages
RUN /tmp/install_packages.sh

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Add group & user + sudo
RUN groupadd -r user && useradd --create-home --gid user user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
ENV HOME /home/user
