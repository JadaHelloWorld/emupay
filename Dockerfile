FROM ubuntu:18.04
MAINTAINER Jada Jin



# Update image and install required packages
# Install.
RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get install -y nano vim screen wget autossh git curl sudo npm

#Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN nodejs -v
RUN  npm --version
RUN git clone https://github.com/JadaHelloWorld/emupay.git

WORKDIR /emupay
RUN rm -rf package-lock.json
RUN npm install
RUN npm run apply:copay
RUN npm run ionic:build --prod
RUN npm run ionic:server
# Make port 8100 available to the world outside this container
EXPOSE 8100