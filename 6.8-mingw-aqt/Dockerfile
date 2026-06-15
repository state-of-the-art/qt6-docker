# Image: stateoftheartio/qt6:6.8-mingw-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# Just version "2.0.6" for example
ARG AQT_VERSION=3.2.0
ARG AQT_SHA256=08fee2cf6d984257f95741a4ecc6919739dd37ecc55883771db6ed31887b3c6e

ARG QT_VERSION=6.8.3
ARG QT_PATH=C:\\Qt

ARG ADDITIONAL_PACKAGES="git openssh-client curl ca-certificates wine64"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_VERSION=${QT_VERSION} \
    AQT_VERSION=${AQT_VERSION} \
    AQT_SHA256=${AQT_SHA256} \
    QT_PATH=${QT_PATH} \
    WINEDEBUG=-all

COPY get_qt.sh install_packages.sh /tmp/

# Install required packages, add group & user + sudo
RUN apt update && apt install -y --no-install-suggests --no-install-recommends locales sudo && \
    sudo apt -qq clean && rm -rf /var/lib/apt/lists/* && \
    groupadd -r user && useradd -m -g user user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

USER user
WORKDIR /home/user
ENV HOME /home/user

# Get Qt binaries with aqt
RUN /tmp/get_qt.sh

# Install the required packages
RUN /tmp/install_packages.sh
