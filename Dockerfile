#FROM testdasi/pihole-base-buster:latest-amd64
#COPY ./install.sh /
# install cloudflared and run install script
#RUN cd /tmp \
#    && wget https://bin.equinox.io/c/VdrWdbjqyF/cloudflared-stable-linux-amd64.deb \
#    && apt install ./cloudflared-stable-linux-amd64.deb \
#    && rm -f ./cloudflared-stable-linux-amd64.deb \
#    && /bin/bash /install.sh \
#    && rm -f /install.sh

ARG TAG=latest
#ENV TAG "${TAG}"
FROM pihole/pihole:master-buster

COPY ./install.sh /

# Install some small required packages
RUN apt-get -y update \
    && apt-get -y dist-upgrade \
    && apt-get -y install sudo bash nano \
    && /bin/bash /install.sh \
    && rm -f /install.sh

RUN echo "$(date "+%d.%m.%Y %T") ${TAG}" >> /build_date.info
