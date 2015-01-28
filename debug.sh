#!/bin/bash
cordova build android
unzip platforms/android/ant-build/Scrollback-debug.apk assets/www/* -d tmp/
rm -rf cordova-plugins/defaults
mkdir cordova-plugins/defaults
mv -v tmp/assets/www/cordova.js cordova-plugins/defaults/cordova.js
mv -v tmp/assets/www/cordova_plugins.js cordova-plugins/defaults/cordova_plugins.js
mv -f -v tmp/assets/www/plugins cordova-plugins/defaults/
rm -r -v tmp
scp -C -r ./cordova-plugins/defaults scrollback@stage.scrollback.io:~/scrollback/public/s/phonegap/cordova-plugins/
cordova run android