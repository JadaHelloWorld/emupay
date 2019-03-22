FROM ubuntu:18.04
MAINTAINER Jada Jin



# Update image and install required packages
# Install.
RUN apt-get -y update && \
apt-get -y upgrade && \
apt update && \
apt-get install -y openjdk-8-jdk unzip nano vim screen wget autossh git curl sudo npm

#Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash - \
&& apt-get install -y nodejs

#Gradle
RUN wget https://services.gradle.org/distributions/gradle-5.1-bin.zip -P /tmp
RUN unzip -d /opt/gradle /tmp/gradle-5.1-bin.zip

WORKDIR /
RUN git clone https://github.com/JadaHelloWorld/emupay.git

#setup gradle
COPY /emupay/android_docker/gradle.sh /etc/profile.d/gradle.sh
RUN source /etc/profile.d/gradle.sh

#install android SDK
RUN apt update && sudo apt install android-sdk
RUN wget http://dl.google.com/android/android-sdk_r24.2-linux.tgz
RUN tar -xvf android-sdk_r24.2-linux.tgz
RUN echo "export PATH=${PATH}:$HOME/android-sdk-linux/platform-tools:$HOME/android-sdk-linux/tools:$HOME/android-sdk-linux/build-tools
RUN export ANDROID_SDK_ROOT=$HOME/Library/Android/sdk
RUN reboot


WORKDIR /emupay
RUN rm -rf package-lock.json
RUN npm install
RUN npm run apply:copay

# android
RUN ionic cordova platform add android
RUN ionic cordova build android
# RUN npm run ionic:build --prod

EXPOSE 8100
WORKDIR /emupay
CMD npm run ionic:serve
# Make port 8100 available to the world outside this container
