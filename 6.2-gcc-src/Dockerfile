# Image: stateoftheartio/qt6:6.2-gcc-src

FROM ubuntu:20.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

#TODO: ARG QT_URL=https://download.qt.io/official_releases/qt/6.2/6.2.0/single/qt-everywhere-src-6.2.0.tar.xz
ARG QT_URL=https://download.qt.io/development_releases/qt/6.2/6.2.0-rc2/single/qt-everywhere-src-6.2.0-rc2.tar.xz
ARG QT_SHA256=3900cd2897b195c187fb2971c447d5bfab9b6f2f2e4d6f384eae4d5efff82b34
ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates build-essential curl ninja-build python3 locales"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_PATH=${QT_PATH} \
    QT_GCC_64=${QT_PATH}/${QT_VERSION}/gcc_64 \
    PATH=${QT_PATH}/bin:$PATH

COPY build_cmake.sh build_qt.sh install_packages.sh /tmp/

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
