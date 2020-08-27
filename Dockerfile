FROM testdasi/pihole-base-buster:latest

# install stubby
RUN sudo apt-get -y install stubby
# clean stubby config
RUN mkdir -p /etc/stubby \
    && rm -f /etc/stubby/stubby.yml

# install cloudflared
RUN cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && useradd -s /usr/sbin/nologin -r -M cloudflared \
    && chown cloudflared:cloudflared /usr/local/bin/cloudflared
# clean cloudflared config
RUN mkdir -p /etc/cloudflared \
    && rm -f /etc/cloudflared/config.yml
