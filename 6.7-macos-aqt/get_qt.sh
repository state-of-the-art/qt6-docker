#!/bin/sh -xe
# Script to install Qt 6 in docker container

[ "$AQT_VERSION" ] || AQT_VERSION=aqtinstall
[ "$QT_VERSION" ] || exit 1

[ "$QT_PATH" ] || QT_PATH=/opt/Qt

root_dir=$PWD
[ "$root_dir" != '/' ] || root_dir=""

# Init the package system
apt update

echo
echo '--> Save the original installed packages list'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_orig.lst

echo
echo '--> Install the required packages to install Qt'
echo

apt install -y git python3-pip libglib2.0-0
pip3 install --no-cache-dir "$AQT_VERSION"

echo
echo '--> Download & install the Qt library using aqt'
echo

aqt install-qt -O "$QT_PATH" mac desktop "$QT_VERSION"

# Installing tools to execute cross-platform
aqt install-qt -O "$QT_PATH" linux desktop "$QT_VERSION" linux_gcc_64
aqt install-tool -O "$QT_PATH" linux desktop tools_cmake
aqt install-tool -O "$QT_PATH" linux desktop tools_ninja

pip3 freeze | xargs pip3 uninstall -y

echo
echo '--> Preparing cross-tools'
echo

apt install -y libclang-dev curl

# Download & unpack sources to build macdeployqt
curl -Lo /tmp/qtbase-src.tar.xz "https://download.qt.io/official_releases/qt/$(echo $QT_VERSION | cut -d. -f 1-2)/${QT_VERSION}/submodules/qtbase-everywhere-src-${QT_VERSION}.tar.xz"
tar -C /tmp -xf /tmp/qtbase-src.tar.xz
rm -f /tmp/qtbase-src.tar.xz

# Patch the macdeployqt tool
cat - <<\EOF | patch -p 1 "/tmp/qtbase-everywhere-src-${QT_VERSION}/src/tools/macdeployqt/shared/shared.cpp"
--- a/src/tools/macdeployqt/shared/shared.cpp
+++ b/src/tools/macdeployqt/shared/shared.cpp
@@ -414,6 +414,10 @@
         CFRelease(bundle);
     }
     CFRelease(bundleURL);
+#else
+    // Cross-compilation on other systems uses static path to the binary
+    QString binName = QFileInfo(appBundlePath).completeBaseName();
+    binaryPath = QDir(appBundlePath).filePath(QString("Contents/MacOS/").append(binName));
 #endif

     if (QFile::exists(binaryPath))
EOF

# Building macdeployqt tool
cmake -S "/tmp/qtbase-everywhere-src-${QT_VERSION}" -G Ninja -B /tmp/macdeployqt-build \
    -DQT_FEATURE_macdeployqt=ON -DQT_FEATURE_network=OFF -DQT_FEATURE_gui=OFF \
    -DQT_FEATURE_concurrent=OFF -DQT_FEATURE_sql=OFF -DQT_FEATURE_dbus=OFF \
    -DQT_FEATURE_testlib=OFF -DQT_FEATURE_printsupport=OFF -DQT_FEATURE_androiddeployqt=OFF \
    -DBUILD_SHARED_LIBS=OFF
cmake --build /tmp/macdeployqt-build

# Copy macdeployqt to the qt macos bin directory
cp -a /tmp/macdeployqt-build/bin/macdeployqt "$QT_MACOS/bin"
rm -rf /tmp/macdeployqt-build /tmp/qtbase-everywhere-src-${QT_VERSION}

# Creating the required scripts for macdeployqt
mkdir -p /usr/local/bin
cat - <<\EOF > /usr/local/bin/hdiutil
#!/bin/sh -e
# Tool to use in macdeployqt
# Will just pack the srcdir to the ISO 9660 dmg archive

OPERATION=$1
OUTPUT=$2
SRCFOLDER=unset
VOLNAME=unset

[ "x$OPERATION" = "xcreate" ] || exit 1

PARSED_ARGUMENTS=$(getopt -a -n hdiutil --long srcfolder:,volname:,format:,fs: -- "$@")
eval set -- "$PARSED_ARGUMENTS"
while :
do
  case "$1" in
    --srcfolder) SRCFOLDER="$2" ; shift 2 ;;
    --volname)   VOLNAME="$2"   ; shift 2 ;;
    --format)    echo "WARN: format parameter '$2' is not supported, will use UDRO" ; shift 2 ;;
    --fs)        echo "WARN: fs parameter '$2' is not supported, will use ISO 9660" ; shift 2 ;;
    --)          shift; break ;;
    *)           echo "Unexpected option: $1 - not supported." ;;
  esac
done

mkdir -p "$SRCFOLDER.iso"
mv "$SRCFOLDER" "$SRCFOLDER.iso"
genisoimage -D -V "$VOLNAME" -no-pad -r -apple -o "$OUTPUT" "$SRCFOLDER.iso"
mv "$SRCFOLDER.iso"/$(basename "$SRCFOLDER") "$SRCFOLDER"
rmdir "$SRCFOLDER.iso"
EOF

chmod +x /usr/local/bin/*

# Copying bin and libexec to macos directory to use Qt UI and other compilers
cp -a "$QT_MACOS/../gcc_64/bin" "$QT_MACOS/"
cp -a "$QT_MACOS/../gcc_64/libexec" "$QT_MACOS/"
# Libs required by libexec
cp -a "$QT_MACOS/../gcc_64/lib"/libQt6Core.so* "$QT_MACOS/../gcc_64/lib"/libQt6Qml.so* \
    "$QT_MACOS/../gcc_64/lib"/libQt6QmlCompiler.so* \
    "$QT_MACOS/../gcc_64/lib"/libQt6Network.so* "$QT_MACOS/../gcc_64/lib"/libicu* /usr/local/lib/

# Cleaning not needed anymore qt gcc & src
rm -rf "$QT_MACOS/../gcc_64" "$QT_MACOS/../Src"

echo
echo '--> Restore the packages list to the original state'
echo

dpkg --get-selections | cut -f 1 > /tmp/packages_curr.lst
grep -Fxv -f /tmp/packages_orig.lst /tmp/packages_curr.lst | xargs apt remove -y --purge

# Complete the cleaning

apt -qq clean
rm -rf /var/lib/apt/lists/*
