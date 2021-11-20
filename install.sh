#!/bin/bash

# install basic packages
apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install sudo bash nano
    
# install stubby
apt-get -y update \
    && apt-get -y install stubby

# clean stubby config
mkdir -p /etc/stubby \
    && rm -f /etc/stubby/stubby.yml

# install cloudflared

# get latest cloudflared-linux-arm assetid
cloudflared_arm=$(curl -sSL https://api.github.com/repos/cloudflare/cloudflared/releases | grep -B 2 "\"name\": \"cloudflared-linux-arm\"" | head -1 | sed 's/.*"id": \(.*\),/\1/')

# get latest cloudflared-linux-amd64.deb assetid
cloudflared_amd64=$(curl -sSL https://api.github.com/repos/cloudflare/cloudflared/releases | grep -B 2 "\"name\": \"cloudflared-linux-amd64.deb\"" | head -1 | sed 's/.*"id": \(.*\),/\1/')

if [[ ${TARGETPLATFORM} =~ "arm" ]]
then 
    cd /tmp \
    && curl -L https://api.github.com/repos/cloudflare/cloudflared/releases/assets/${cloudflared_arm} -o cloudflared -H 'Accept: application/octet-stream'
    && mv ./cloudflared /usr/local/bin \
    && echo "Cloudflared installed for arm due to tag ${TAG}"
else 
    cd /tmp \
    && curl -L https://api.github.com/repos/cloudflare/cloudflared/releases/assets/${cloudflared_amd64} -o cloudflared-linux-amd64.deb -H 'Accept: application/octet-stream'
    && dpkg -i ./cloudflared-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && echo "Cloudflared installed for amd64 due to tag ${TAG}"
fi
useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared
    
# clean cloudflared config
mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml

# clean up
apt-get -y autoremove \
    && apt-get -y autoclean \
    && apt-get -y clean \
    && rm -fr /tmp/* /var/tmp/* /var/lib/apt/lists/*
