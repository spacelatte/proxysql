#!/usr/bin/env docker build --compress -t pvtmert/proxysql -f

FROM debian

WORKDIR /data

RUN apt update && apt install -y build-essential libssl-dev openssl git

COPY ./ ./

RUN make -j$(nproc) install
