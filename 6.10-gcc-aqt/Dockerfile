# Image: stateoftheartio/qt6:6.10-gcc-aqt

FROM ubuntu:24.04
MAINTAINER State Of The Art <docker@state-of-the-art.io> (@stateoftheartio)

# PIP requirement like "aqtinstall==2.0.6" or url with egg file
ARG AQT_VERSION="aqtinstall==3.3.0"

ARG QT_VERSION=6.10.3

# LINUXDEPLOY_COMMIT Nov 7, 2025
ARG LINUXDEPLOY_COMMIT=cc7b86472c3caa3fd729b9dc502fd2aa78394257
# LINUXDEPLOY_QT_COMMIT Nov 7, 2025
ARG LINUXDEPLOY_QT_COMMIT=d15373bdd30c6a14ff2e06aa7a09866f190965c3
# LINUXDEPLOY_APPIMAGE_COMMIT Oct 28, 2025
ARG LINUXDEPLOY_APPIMAGE_COMMIT=f62e84fb1b444c43dd954e2a485357290fb91566

ARG APPIMAGETOOL_VERSION=1.9.1
ARG APPIMAGETOOL_SHA256=ed4ce84f0d9caff66f50bcca6ff6f35aae54ce8135408b3fa33abfc3cb384eb0

ARG QT_PATH=/opt/Qt

ARG ADDITIONAL_PACKAGES="sudo git openssh-client ca-certificates build-essential curl python3 locales patchelf"

ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true \
    QT_VERSION=${QT_VERSION} \
    AQT_VERSION=${AQT_VERSION} \
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
RUN echo 'ALL ALL=NOPASSWD: ALL' > /etc/sudoers.d/user
