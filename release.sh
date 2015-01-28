#!/bin/bash

ver="$1"
args="$2"

if [[ $args == '' ]]; then
    echo "Press 'a' for alpha, 'b' for Beta"
    read -n 1 r
    echo ""
    if [[ $r == 'a' ]]; then
        args="alpha"
    else
        args="beta"
    fi
fi

if [[ $ver == '' ]]; then
    echo "Enter version number"
    read ver
    echo ""
fi

mkdir -v tmp
cp -f -v www/index.html tmp/index.html
node release.js ${args} ${ver}
cordova build android --release
unzip platforms/android/ant-build/Scrollback-release-unsigned.apk assets/www/* -d tmp/
rm -f -r -v cordova-plugins/${ver}
mkdir -v cordova-plugins/${ver}
mv -f -v tmp/assets/www/cordova.js cordova-plugins/${ver}/cordova.js
mv -f -v tmp/assets/www/cordova_plugins.js cordova-plugins/${ver}/cordova-plugins.js
mv -f -v tmp/assets/www/plugins cordova-plugins/${ver}/
cp -f -v tmp/index.html www/index.html
rm -r -v tmp

git add cordova-plugins/${ver}/
echo "New version files added to git, please commit"

jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore scrollback.keystore platforms/android/ant-build/Scrollback-release-unsigned.apk scrollback.io

$ANDROID_HOME/build-tools/21.0.0/zipalign -f -v 4 platforms/android/ant-build/Scrollback-release-unsigned.apk platforms/android/ant-build/app-release.apk

