#################################################################
#                                                               #
# Copyright (c) 2025-2026 DnaSoft B.V. and/or its subsidiaries. #
# All rights reserved.                                          #
#                                                               #
#   This source code contains the intellectual property         #
#   of its copyright holder(s), and is made available           #
#   under a license.  If you do not know the terms of           #
#   the license, please stop and do not read further.           #
#                                                               #
#################################################################

FROM yottadb/yottadb:latest

RUN apt-get update && apt-get install -y wget  git make cmake gcc \
			libssl-dev libconfig-dev libgcrypt-dev libgpgme-dev \
			libicu-dev libsodium-dev curl libcurl4-openssl-dev libnss3-tools

# Install Encryption Plugin
WORKDIR /tmp
ENV ydb_dist="/opt/yottadb/current"
ENV ydb_icu_version="70"

ENV ydb_xc_libcurl="/opt/yottadb/current/plugin/libcurl.xc"

ENV gtm_lct_stdnull=1
ENV gtm_lvnullsubs=2

# Create dir structure and copy files
RUN mkdir -p /opt/mind/m /opt/mind/test /opt/mind/test/m /opt/mind/o $ydb_dist/plugin/etc/mind $ydb_dist/plugin/etc/mind/uApi

# Set-up TLS Config
# Create Certificates
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.4/mkcert-v1.4.4-linux-amd64 -O /usr/bin/mkcert && chmod 755 /usr/bin/mkcert
RUN mkdir -p $HOME/.pki/nssdb
RUN certutil -d sql:$HOME/.pki/nssdb -N --empty-password
RUN mkcert -install -key-file /opt/yottadb/current/plugin/etc/mind/mind.key -cert-file /opt/yottadb/current/plugin/etc/mind/mind.pem localhost

# Install MIND
ENV a=qs332aa
RUN cd /tmp && git clone -b v0.20.0 --single-branch https://github.com/mind4yottadb/mind-server.git && cd mind-server && mkdir build && cd build && cmake .. && make && make install


RUN cp -r /tmp/mind-server/test/uApi/client-test/* $ydb_dist/plugin/etc/mind/uApi

# create globals for testing
#RUN mkdir /opt/mind /opt/mind/test
#RUN chmod 777 /tmp/mind-server/test/mind-test-globals.zwr
RUN cp /tmp/mind-server/test/mind-test-globals.zwr /opt/mind/test/
RUN cp /tmp/mind-server/test/mindTestGlobals.zwr /opt/mind/test/
RUN echo "Importing test globals..."
RUN . $ydb_dist/ydb_env_set && $ydb_dist/mupip load -ignorechset /opt/mind/test/mindTestGlobals.zwr
RUN . $ydb_dist/ydb_env_set && $ydb_dist/mupip load -ignorechset /opt/mind/test/mind-test-globals.zwr
RUN echo "Test globals imported!"

# to be removed from tests later...
RUN mkdir /tmp/stef
RUN echo "tst file" > /tmp/stef/a





# Initialize files for working directory
WORKDIR $ydb_dist/plugin/etc/mind/uApi

EXPOSE 10000
ENTRYPOINT ["sleep", "infinity"]

# to build the image
# docker image build  --progress=plain -t mind-server .

# docker run -d --init -p 10000:10000 --name=mind-server mind-server

# docker exec -it mind-server bash

#-p 10000:10000
