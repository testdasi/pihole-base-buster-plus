#!/bin/bash

# install stubby
sudo apt-get -y install stubby

# clean stubby config
mkdir -p /etc/stubby \
    && rm -f /etc/stubby/stubby.yml

# install cloudflared
# partially done in Dockerfile due to platform difference
useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared
    
# clean cloudflared config
mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml
