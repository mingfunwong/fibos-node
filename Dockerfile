FROM ubuntu:24.04

WORKDIR /app

RUN apt-get update -y \
  && apt-get install -y curl sudo wget libusb-1.0-0 libcurl3-gnutls \
  && wget "http://security.ubuntu.com/ubuntu/pool/main/n/ncurses/libtinfo5_6.1-1ubuntu1_amd64.deb" \
  && dpkg -i libtinfo5_6.1-1ubuntu1_amd64.deb \
  && rm libtinfo5_6.1-1ubuntu1_amd64.deb \
  && wget "http://security.ubuntu.com/ubuntu/pool/main/o/openssl1.0/libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb" \
  && dpkg -i libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb \
  && rm libssl1.0.0_1.0.2n-1ubuntu5_amd64.deb \
  && wget "http://security.ubuntu.com/ubuntu/pool/main/i/icu/libicu55_55.1-7_amd64.deb" \
  && dpkg -i libicu55_55.1-7_amd64.deb \
  && rm libicu55_55.1-7_amd64.deb

RUN curl -s https://fibos.io/download/installer.sh?v1.7.1.13 | sh 

ADD genesis.json .
ADD start.js .
ADD p2p.json .
ADD start.sh .

EXPOSE 8080

ENTRYPOINT ["bash", "/app/start.sh"]
