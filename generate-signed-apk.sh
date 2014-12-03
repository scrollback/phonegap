#!/bin/sh
cordova build android --release
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore scrollback.keystore platforms/android/ant-build/Scrollback-release-unsigned.apk scrollback.io
$ANDROID_HOME/build-tools/android-4.4W/zipalign -f -v 4 platforms/android/ant-build/Scrollback-release-unsigned.apk platforms/android/ant-build/app-release.apk
