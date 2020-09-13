#FROM testdasi/pihole-base-buster:latest-amd64
#COPY ./install.sh /
# install cloudflared and run install script
#RUN cd /tmp \
#    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
#    && apt install ./cloudflared-stable-linux-amd64.deb \
#    && rm -f ./cloudflared-stable-linux-amd64.deb \
#    && /bin/bash /install.sh \
#    && rm -f /install.sh

ARG FRM='pihole/pihole:master-buster'
ARG TAG='latest'
FROM ${FRM}
ARG FRM
ARG TAG

COPY ./install.sh /

RUN /bin/bash /install.sh \
    && rm -f /install.sh

RUN echo "$(date "+%d.%m.%Y %T") Built from ${FRM} with tag ${TAG}" >> /build_date.info
