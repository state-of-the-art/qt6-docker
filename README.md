# Qt 6 docker containers for CI

The unified way to build your Qt application. This is a collection of the linux docker containers
for your CI. Supports native, Android, Windows and MacOS. Primarily it's aimed for Qt, but you can
use it with any cmake project and cross-compile anything you want in a number of easy steps.

Uses great AQT tool to simplify the installation process of Qt libs: https://github.com/miurahr/aqtinstall

Dockerhub: https://hub.docker.com/r/stateoftheartio/qt6

* [6.8-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.8-gcc-aqt) - Linux GCC 64
* [6.8-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.8-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch

* [6.7-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.7-gcc-aqt) - Linux GCC 64
* [6.7-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.7-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.7-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.7-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.7-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.7-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64

* [6.6-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.6-gcc-aqt) - Linux GCC 64
* [6.6-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.6-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.6-wasm-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.6-wasm-aqt) - WebAssembly toolchain
* [6.6-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.6-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.6-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.6-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64

* [6.5-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.5-gcc-aqt) - Linux GCC 64
* [6.5-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.5-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.5-wasm-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.5-wasm-aqt) - WebAssembly toolchain
* [6.5-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.5-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.5-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.5-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64

* [6.4-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.4-gcc-aqt) - Linux GCC 64
* [6.4-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.4-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.4-wasm-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.4-wasm-aqt) - WebAssembly toolchain
* [6.4-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.4-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.4-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.4-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64

* [6.3-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.3-gcc-aqt) - Linux GCC 64
* [6.3-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.3-android-aqt) - Android Clang multiarch toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.3-wasm-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.3-wasm-aqt) - WebAssembly toolchain
* [6.3-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.3-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.3-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.3-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64

* [6.2-gcc-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-gcc-aqt) - Linux GCC 64
* [6.2-android-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-android-aqt) - Android Clang toolkit for x86_64, x86, armv7 and arm64_v8a arch
* [6.2-wasm-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-wasm-aqt) - WebAssembly toolchain
* [6.2-mingw-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-mingw-aqt) - Windows (wine) 64 MinGW toolchain
* [6.2-macos-aqt](https://hub.docker.com/r/stateoftheartio/qt6/tags?page=1&name=6.2-macos-aqt) - MacOS X osxcross toolchain for x86_64, aarch64
* 6.2-gcc-src - Linux GCC 64 built from sources (not ready)
* 6.2-android-src - Android Clang toolkit for x86_64, x86, armv7 and arm64_v8a built from sources (not ready)

## How to build the image

Just go into the required directory and run:
```
docker build --pull --force-rm=true -t stateoftheartio/qt6:$(basename "${PWD}") .
```

### How to test

You can test the particular image or all of them using `test/test.sh` script - it will run the
defined commands to make sure the image works as expected on a number of sample Qt projects.

## How to use

The images are not containing the dev libraries, so if the project needs some of such dependencies,
you can build a new image on top of the base one or install the deps dynamically during the build.

In case you want to build in user dir - create it and mount as `-v "${PWD}/build:/home/user/build:rw"`.

### Linux GCC:

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-gcc-aqt \
    sh -c 'sudo apt update; sudo apt install -y libgl-dev libvulkan-dev;
           qt-cmake ./project -G Ninja -B ./build; cmake --build ./build;
           linuxdeploy --plugin qt -e "$(find ./build -maxdepth 1 -type f -executable)" --appdir ./build/deploy'
```

For deploy it uses linuxdeploy and linuxdeploy-plugin-qt, so you can check their capabilities on
their github pages:
* https://github.com/linuxdeploy/linuxdeploy
* https://github.com/linuxdeploy/linuxdeploy-plugin-qt

### Android clang:

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-android-aqt \
    sh -c 'qt-cmake ./project -G Ninja -B ./build; cmake --build ./build'
```

You can use `BUILD_ARCH=arm64_v8a` (default), `=armv7`, `=x86` or `=x86_64` during run of qt-cmake
to produce binaries for specific architecture.

Since Qt 6.3 android supports multi-abi, please check how to use it, but in general you can:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-android-aqt \
    sh -c 'qt-cmake ./project -G Ninja -B ./build -DQT_ANDROID_ABIS="armeabi-v7a;arm64-v8a"; \
           cmake --build ./build'
```
Or to build all the available ABIs use `-DQT_ANDROID_BUILD_ALL_ABIS=ON`.

### WebAssembly emsdk:

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-wasm-aqt \
    sh -c 'qt-cmake ./src -G Ninja -B ./build; cmake --build ./build'
```

You can run it with `python3 -m http.server` in the build directory - at least widgets sample is
running well.

### Windows MinGW (wine):

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-mingw-aqt \
    sh -c 'qt-cmake ./src -G Ninja -B ./build; cmake --build ./build;
           windeployqt --qmldir ./src --dir build/deploy --libdir build/deploy/libs --plugindir build/deploy/plugins build/*.exe'
```

You can use your own applications, but know that by default there is no wine32 so you can run only
64 bit apps or install wine32 if you really need it.

### MacOSX clang (osxcross):

In the project directory run:
```
$ docker run -it --rm -v "${PWD}:/home/user/project:ro" stateoftheartio/qt6:6.3-macos-aqt \
    sh -c 'qt-cmake ./project -G Ninja -B ./build; cmake --build ./build;
           macdeployqt ./build/*.app -verbose=1 -dmg -qmldir=./project'
```

Uses osxcross project, which actually can be built with apple clang to support `arm64e`. But for
now it uses the regular ubuntu clang.
* https://github.com/tpoechtrager/osxcross

You can use `BUILD_ARCH=aarch64` or `BUILD_ARCH=x86_64` (default) during run of qt-cmake to produce
binaries for specific architecture.

The `macdeployqt` application is not completely functional:
* The `-dmg` option uses `hdiutil` which was substituted poorly by shell script, which is using
`genisoimage` - and creates ISO, which somehow is useful.
* There is no `codesign` app, could be probably ported [from the sources](https://opensource.apple.com/source/security_systemkeychain/security_systemkeychain-55191/src/)
