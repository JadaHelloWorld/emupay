FROM ubuntu:18.04
MAINTAINER Jada Jin



# Update image and install required packages
# Install.
RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get install -y  iputils-ping openjdk-8-jre openjdk-8-jdk unzip nano vim screen wget autossh git curl sudo npm

#Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash - \
&& apt-get install -y nodejs

#Gradle
RUN wget https://services.gradle.org/distributions/gradle-5.1-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-5.1-bin.zip


WORKDIR /
RUN git clone https://github.com/chunlee1991/emupay.git
#https://github.com/JadaHelloWorld/emupay.git

#setup gradle
# COPY /emupay/android_docker/gradle.sh /etc/profile.d/gradle.sh
# RUN source /etc/profile.d/gradle.sh

# install android studio
#RUN wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip


#install android SDK
#RUN wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
#RUN tar -xvf android-sdk_r24.2-linux.tgz
#RUN /android-sdk-linux/tools/android update sdk -u -a -t 2,4,68
#RUN export ANDROID_HOME=/android-sdk-linux
#RUN export PATH=${PATH}:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
#RUN export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
#RUN export GRADLE_HOME="/opt/gradle/gradle-5.1/bin"
#RUN export PATH="$PATH:$ANDROID_HOME:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$GRADLE_HOME"
# RUN reboot

RUN npm install -g ionic

WORKDIR /emupay
RUN rm -rf package-lock.json
RUN npm install
RUN npm install -g cordova
RUN npm run apply:copay
RUN npm run ionic:build --prod



ARG sdk_version=sdk-tools-linux-3859397.zip
ARG android_home=/opt/android/sdk
ARG gradle_home=/opt/gradle/gradle-5.1/bin

# SHA-256 444e22ce8ca0f67353bda4b85175ed3731cae3ffa695ca18119cbacef1c1bea0

RUN sudo apt-get update && \
    sudo apt-get install --yes xvfb gcc-multilib lib32z1 lib32stdc++6 build-essential libcurl4-openssl-dev

ENV ANDROID_HOME ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}
ENV GRADLE_HOME ${gradle_home}
ENV PATH=${PATH}:${ANDROID_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${GRADLE_HOME}


# Download and install Android SDK
RUN sudo mkdir -p ${android_home} && \
    curl --silent --show-error --location --fail --retry 3 --output /tmp/${sdk_version} https://dl.google.com/android/repository/${sdk_version} && \
    unzip -q /tmp/${sdk_version} -d ${android_home} && \
    rm /tmp/${sdk_version}

# Set environmental variables


RUN mkdir ~/.android && echo '### User Sources for Android SDK Manager' > ~/.android/repositories.cfg

RUN sdkmanager --update && yes | sdkmanager --licenses

# Update SDK manager and install system image, platform and build tools
RUN sdkmanager \
  "tools" \
  "platform-tools" \
  "emulator" \
  "extras;android;m2repository" \
  "extras;google;m2repository" \
  "extras;google;google_play_services"


RUN sdkmanager \
  "platform-tools" \
  "platforms;android-25" \
  "system-images;android-25;google_apis;x86_64" \
  "system-images;android-25;google_apis_playstore;x86" \
  "build-tools;28.0.3" \
  "sources;android-25" \
  "system-images;android-25;default;x86_64"


#RUN android update sdk -u -a -t 1,2,4

# setup PATH

ENV ANDROID_HOME ${android_home}
ENV ADB_INSTALL_TIMEOUT 120
ENV PATH=${ANDROID_HOME}/emulator:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}
ENV GRADLE_HOME ${gradle_home}
ENV PATH=${PATH}:${ANDROID_HOME}:${ANDROID_HOME}/tools:${ANDROID_HOME}/platform-tools:${GRADLE_HOME}


# BUILD android APK
# RUN cordova platform add android --verbose
## A. add "https://github.com/danielsogl/cordova-plugin-useragent.git" to package.json -> cordova.plugin -> "im.ltdev.cordova.UserAgent"
# RUN cordova prepare android
## remove A. from package.json file
# RUN cordova prepare android # run this again
# COPY google-services.json platforms/android/app/
# RUN ionic cordova build android --release

WORKDIR /emupay


# keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
# jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore my-release-key.keystore my_application.apk alias_name
