FROM archlinux:latest

ARG ELM_VERSION
ARG ELM_DISTRIBUTION
ARG NODEJS_VERSION
ARG NODEJS_DISTRIBUTION

USER root

WORKDIR /root

ENV PATH=/usr/local/lib/nodejs/node-v$NODEJS_VERSION-$NODEJS_DISTRIBUTION/bin:$PATH

RUN pacman -Syy --noconfirm curl tar xz git \
  && mkdir -p /usr/local/lib/nodejs \
  && curl -LO https://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION-$NODEJS_DISTRIBUTION.tar.xz \
  && tar xJvf node-v$NODEJS_VERSION-$NODEJS_DISTRIBUTION.tar.xz -C /usr/local/lib/nodejs \
  && node --version \
  && npx --version \
  && npm --version \
  && useradd --create-home elm \
  && curl -Lo elm.gz https://github.com/elm/compiler/releases/download/$ELM_VERSION/binary-for-$ELM_DISTRIBUTION.gz \
  && gunzip elm.gz \
  && chmod +x elm \
  && mv elm /usr/local/bin \
  && elm --version \
  && npm install --global uglify-js@3.17.4

USER elm

WORKDIR /home/elm

ENTRYPOINT ["elm"]

CMD ["--version"]
