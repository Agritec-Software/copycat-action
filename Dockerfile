FROM golang:alpine3.14 as gh-build
RUN apk add make
RUN git clone https://github.com/cli/cli.git gh-cli && \
    cd gh-cli
RUN make && \
    mv ./bin/gh /usr/local/bin/


FROM alpine:3.14

RUN apk add --no-cache bash
RUN apk add --no-cache git

COPY --from=gh-build /usr/local/bin/gh /usr/local/bin/gh 
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/bin/bash", "-c", "/entrypoint.sh"]
