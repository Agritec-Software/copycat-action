# FROM golang:alpine3.14 as gh-build
# RUN apk add --no-cache make git
# RUN git clone https://github.com/cli/cli.git gh-cli
# RUN cd gh-cli && make && \
#     mv ./bin/gh /usr/local/bin/


FROM alpine/git:v2.30.2
RUN apk add --no-cache bash

RUN mkdir /ghcli && cd  /ghcli && \
    wget https://github.com/cli/cli/releases/download/v2.0.0/gh_2.0.0_linux_386.tar.gz -O ghcli.tar.gz && \
    tar --strip-components=1 -xf ghcli.tar.gz && \
    mv bin/gh /bin/gh  && \
    cd .. && rm -r ghcli


COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]