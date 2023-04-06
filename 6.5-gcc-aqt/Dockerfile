# Image: stateoftheartio/qt6:6.5-gcc-aqt

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# PIP requirement like "aqtinstall==2.0.6" or url with egg file
ARG AQT_VERSION="aqtinstall==3.1.4"

ARG QT_VERSION=6.5.0
ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates build-essential curl python3 locales patchelf"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_PATH=${QT_PATH} \
    QT_GCC=${QT_PATH}/${QT_VERSION}/gcc_64 \
    PATH=${QT_PATH}/Tools/CMake/bin:${QT_PATH}/Tools/Ninja:${QT_PATH}/${QT_VERSION}/gcc_64/bin:$PATH

COPY get_qt.sh get_linuxdeploy.sh install_packages.sh /tmp/

# Get Qt binaries with aqt
RUN /tmp/get_qt.sh

# Get linuxdeploy and build it
RUN /tmp/get_linuxdeploy.sh

# Install the required packages
RUN /tmp/install_packages.sh

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure locales

# Add group & user + sudo
RUN groupadd -r user && useradd --create-home --gid user user && echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

USER user
WORKDIR /home/user
ENV HOME /home/user
