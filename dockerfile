#!/usr/bin/env docker build --compress -t pvtmert/proxysql -f

FROM debian

WORKDIR /data

RUN apt update && apt install -y \
	build-essential zlib1g-dev libssl-dev openssl git cmake gawk

ENV DEBUG      1
ENV PROXYDEBUG 1

COPY ./deps            ./deps
RUN make -j$(nproc) -C ./deps

COPY ./tools           ./tools
RUN make -j$(nproc) -C ./tools

COPY ./ ./
#RUN ln -sf mariadb-connector-c-3.1.3-src ./deps/mariadb-client-library/mariadb_client

#COPY ./include         ./include
#RUN make -j$(nproc) -C ./include

#COPY ./lib             ./lib
#RUN make -j$(nproc) -C ./lib

#COPY ./src             ./src
#RUN make -j$(nproc) -C ./src

#COPY ./test            ./test
#RUN make -j$(nproc) -C ./test

RUN make -j$(nproc) && make -j$(nproc) debug install || true

CMD proxysql -f -D /var/lib/proxysql
