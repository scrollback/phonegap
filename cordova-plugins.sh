#!/bin/sh

if [ $# -lt 2 ]
then 
    echo 'Please pass Facebook APP_ID and APP_NAME as params 1 and 2 respectively.'
    exit 1
fi

cordova plugin add org.apache.cordova.inappbrowser
cordova plugin add https://github.com/phonegap-build/PushPlugin.git
cordova plugin add https://github.com/Paldom/UniqueDeviceID.git
cordova plugin add org.apache.cordova.device
cordova plugin add org.apache.cordova.file
cordova plugin add https://github.com/joaomak/LaunchMyApp-PhoneGap-Plugin --variable URL_SCHEME=https --variable HTTP_HOST=scrollback.io --variable HTTP_PATHPREFIX="" --variable HTTPS_HOST=scrollback.io --variable HTTPS_PATHPREFIX=""
cordova plugin add org.apache.cordova.network-information
cordova -d plugin add https://github.com/Wizcorp/phonegap-facebook-plugin.git --variable APP_ID=$1 --variable APP_NAME=$2
cordova plugin add https://github.com/scrollback/cordova-plugin-googleplus.git
