#!/bin/bash
cordova build android
unzip platforms/android/ant-build/Scrollback-debug.apk assets/www/* -d tmp/
mv tmp/assets/www/cordova.js cordova-plugins/defaults/
mv tmp/assets/www/cordova_plugins.js cordova-plugins/defaults/
mv -r tmp/assets/www/plugins/ cordova-plugins/defaults/
rm -r tmp
scp -C -r ./cordova-plugins scrollback@stage.scrollback.io:~/scrollback/public/phonegap/
cordova run android