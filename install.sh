#!/bin/bash

if [ $# -lt 2 ]
then 
    echo 'Please pass Facebook APP_ID and APP_NAME as params 1 and 2 respectively.'
    exit 1
fi

./cordova-plugins.sh $1 $2
cordova platform add android
