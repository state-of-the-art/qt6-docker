# Qt 6.2 docker containers for CI

Dockerhub: https://hub.docker.com/r/stateoftheartio/qt6

* [6.2-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-gcc-aqt) - Linux GCC 64 installed via AQT https://github.com/miurahr/aqtinstall
* [6.2-gcc-src]() - Linux GCC 64 built from sources
* [6.2-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-android-aqt) - Android Clang toolkit for x86_64, x86, armv7 and arm64_v8a arch installed via AQT
* [6.2-android-src]() - Android Clang toolkit for x86_64, x86, armv7 and arm64_v8a built from sources
* TODO: 6.2-mingw-aqt

## How to build

Just go into the required directory and run:
```
docker build --pull --rm=true -t stateoftheartio/qt6:$(basename "${PWD}") .
```

## How to use

The images are not containing the dev libraries, so if the project needs some of such dependencies,
you can build a new image on top of the base one or install the deps dynamically during the build.

In case you want to build in user dir - create it mount as `-v "${PWD}/build:/home/user/build:rw"`.

### GCC:

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.2-gcc-aqt \
    sh -c 'sudo apt update; sudo apt install -y libgl-dev libvulkan-dev libtool; qt-cmake -G Ninja -S ./project -B ./build; cmake --build ./build'
```

### Android:

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.2-gcc-aqt \
    sh -c 'qt-cmake -DANDROID_SDK_ROOT=${ANDROID_SDK_ROOT} -DANDROID_NDK_ROOT=${ANDROID_NDK_ROOT} -S ./project -B ./build; cmake --build ./build'
```
