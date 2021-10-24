FROM ubuntu:latest

WORKDIR /fibos

RUN echo deb http://security.ubuntu.com/ubuntu xenial-security main >> /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -y curl sudo wget libusb-1.0-0 libcurl3-gnutls libncurses5 libssl1.0.0

RUN curl -s https://fibos.io/download/installer.sh?v1.7.1.12 | sh 

ADD genesis.json .
ADD start.js .
ADD p2p.json .
ADD start.sh .

ENTRYPOINT ["bash", "/fibos/start.sh"]
