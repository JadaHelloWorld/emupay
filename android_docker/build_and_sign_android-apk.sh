#!/usr/bin/env bash

cd /emupay
# build android apk
ionic cordova build android --release

# sign apk
cp /emupay/platforms/android/app/build/outputs/apk/release/app-release-unsigned.apk /root/apks
cd /root/apks
printf '123456' | jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore app-release-unsigned.apk alias_name
jarsigner -verify app-release-unsigned.apk

# zip & rename
VERSION_STRING=$(date +"%m-%d-%Y")
zipalign -f -v 4 app-release-unsigned.apk app-release-signed-$VERSION_STRING.apk
rm -f app-release-unsigned.apk

# add new apk to www
sed  -i "3 a\\<a href=app-release-signed-$VERSION_STRING.apk download> Download and install app-release-signed-$VERSION_STRING.apk</a></br>" /root/www/index.html
cp app-release-signed-$VERSION_STRING.apk /root/www/
cp app-release-signed-$VERSION_STRING.apk /root/www/html

rm -rf /emupay/www
cp -r /root/www /emupay

