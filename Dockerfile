FROM buildpack-deps:jessie
MAINTAINER Levi Smith <levi@fynx.me>

# Install dependencies
RUN apt-get update && apt-get install -y \
    git \
    gconf2 \
    gconf-service \
    gvfs-bin \
    libasound2 \
    libgconf-2-4 \
    libgnome-keyring-dev \
    libgtk2.0-0 \
    libnotify4 \
    libnss3 \
    libxtst6 \
    xdg-utils \
    --no-install-recommends && \
    mkdir -p /project  && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV ATOM_VERSION 1.9.8

# Install ATOM
RUN set -x \
    && curl -sSL https://github.com/atom/atom/releases/download/v${ATOM_VERSION}/atom-amd64.deb -o /tmp/atom-amd64.deb \
    && dpkg -i /tmp/atom-amd64.deb \
    && rm -rf /tmp/*.deb

VOLUME /project
WORKDIR /project

CMD [ "atom", "--foreground" ]
