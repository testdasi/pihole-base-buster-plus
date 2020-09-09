FROM testdasi/pihole-base-buster:latest-amd64

# install cloudflared
RUN cd /tmp \
    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
    && apt install ./cloudflared-stable-linux-amd64.deb \
    && rm -f ./cloudflared-stable-linux-amd64.deb

COPY ./install.sh /
RUN /bin/bash /install.sh \
    && rm -f /install.sh
