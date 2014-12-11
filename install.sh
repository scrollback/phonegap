#!/bin/bash
./cordova-plugins.sh
cordova platform add android
cordova-android-crosswalk --target android-21

