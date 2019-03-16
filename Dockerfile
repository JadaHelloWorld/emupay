FROM ubuntu:18.04
MAINTAINER temple


# Update image and install required packages
# Install.
RUN apt-get -y update && \
apt-get -y upgrade && \
apt-get install -y software-properties-common && \
apt-get install -y nano vim screen wget autossh git curl sudo

#Nodejs
RUN curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
RUN apt-get install -y nodejs
RUN git clone https://github.com/BlueWallet/BlueWallet.git
#RUN cd BlueWallet
#RUN npm install
#RUN npm start android