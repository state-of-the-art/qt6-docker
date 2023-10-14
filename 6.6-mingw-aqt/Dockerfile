# Image: stateoftheartio/qt6:6.6-mingw-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# Just version "v2.0.6" for example
ARG AQT_VERSION=3.1.7
ARG AQT_SHA256=b6ca0afb5e54e692b63a24e3db98bbac34927545e867c51ba71a4ea84eeae446

ARG QT_VERSION=6.6.0
ARG QT_PATH=C:\\Qt

ARG ADDITIONAL_PACKAGES="git openssh-client curl ca-certificates wine64"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
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
