#!/bin/sh
# Script runs the containers to test them over example projects

test_dir="$(dirname "$0")"
IMAGES="$@"
[ "$IMAGES" ] || IMAGES=$(find "$test_dir/.." -name '6.2-*-aqt' -printf "%f\n")

echo 'Running tests for:'
echo "$IMAGES"
echo

errors=0

for image in $IMAGES; do
    for src in $(find "$(cd "$test_dir"; pwd)/sample_projects" -mindepth 1 -maxdepth 1 -type d); do
        project="$(basename "$src")"

        cmd=

        # Install deps for non-console apps on gcc
        if [ "$(echo "$image" | grep 'gcc-')" -a -z "$(echo "$project" | grep 'console')" ]; then
            cmd='sudo apt update ; sudo apt install -y libgl-dev;'
        fi
        cmd="$cmd qt-cmake ./project -G Ninja -B ./build; cmake --build ./build;"

        archs=
        if echo "$image" | grep -q 'gcc-'; then
            cmd="$cmd "'linuxdeploy --plugin qt -e "$(find ./build -maxdepth 1 -type f -executable)" --appdir ./build/deploy;'
        fi
        if echo "$image" | grep -q 'android-'; then
            # Skip console build for android
            [ "x$(echo "$project" | grep 'console')" = 'x' ] || continue
            archs="armv7 x86 x86_64"
        fi
        if echo "$image" | grep -q 'mingw-'; then
            cmd="$cmd windeployqt --qmldir ./project --dir build/deploy --libdir build/deploy/libs --plugindir build/deploy/plugins build/*.exe;"
        fi
        if echo "$image" | grep -q 'macos-'; then
            # Deploy only GUI apps since there will be no .app bundle for console project
            if [ "x$(echo "$project" | grep 'console')" = 'x' ]; then
                cmd="$cmd macdeployqt ./build/*.app -verbose=1 -dmg -qmldir=./project;"
            fi
            archs="aarch64"
        fi
        cmd="$cmd ls -alh build;"

        for arch in '' $archs; do
            logfile="$test_dir/logs/${image}_${project}_$arch.log"
            mkdir -p $(dirname "$logfile")
            echo -n "Running $image $project $arch...\t"
            docker run -it --rm -v "$src:/home/user/project:ro" stateoftheartio/qt6:$image \
                sh -xec "BUILD_ARCH=$arch $cmd" > "$logfile" 2>&1
            if [ "$?" -eq 0 ]; then
                echo "SUCCESS"
            else
                echo "FAIL - $logfile"
                errors=$(($errors+1))
            fi
        done
    done
done

exit $errors
