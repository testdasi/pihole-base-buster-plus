FROM testdasi/pihole-base-buster:latest-amd64

COPY ./install.sh /

# install cloudflared and run install script
RUN cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb \
    && /bin/bash /install.sh \
    && rm -f /install.sh
