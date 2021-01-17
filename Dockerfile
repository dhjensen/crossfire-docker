# curl -LOJ https://github.com/crypto-com/chain-main/releases/download/v0.8.0-crossfire/chain-main_0.8.0-crossfire_Linux_x86_64.tar.gz
# tar -zxvf chain-main_0.8.0-crossfire_Linux_x86_64.tar.gz

ARG VERSION=0.8.0-crossfire
ARG ARCHIVE_PATH=/tmp/chain-maind.tar.gz

FROM debian:buster AS unpacker

ARG VERSION
ARG ARCHIVE_PATH

ADD https://github.com/crypto-com/chain-main/releases/download/v${VERSION}/chain-main_${VERSION}_Linux_x86_64.tar.gz ${ARCHIVE_PATH}
RUN tar -xf ${ARCHIVE_PATH} -C /usr/bin chain-maind

FROM debian:buster-slim

RUN apt-get update \
      && apt-get install -y jq=1.5+dfsg-2+b1 --no-install-recommends \
      && apt-get clean \
      && rm -rf /var/lib/apt/lists/*

ENV CHAIN_MAIN /chain-main

RUN addgroup chain-main && \
  adduser --system --home "$CHAIN_MAIN" --uid 1000 --gid 1000 chain-main

USER chain-main

WORKDIR $CHAIN_MAIN

COPY --from=unpacker /usr/bin/chain-maind /usr/bin/chain-maind

# P2P port
EXPOSE 26656/tcp

# Need to map user homedir to host
VOLUME ${CHAIN_MAIN}

CMD ["chain-maind"]