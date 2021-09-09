FROM jrei/systemd-ubuntu:20.04
LABEL maintainer="dalmatialab"

# Install tzdata and set right timezone
ENV DEBIAN_FRONTEND="noninteractive"
RUN apt update && apt-get -y install tzdata
ENV TZ=Europe/Zagreb

# Install tools
RUN apt update && apt install apt-transport-https ca-certificates curl software-properties-common network-manager apparmor wget jq vim -y 

# Install docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg |  apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
VOLUME /var/lib/docker
RUN apt update && apt install docker-ce -y

# Add conf to override docker service start
RUN mkdir -p /etc/systemd/system/docker.service.d
ADD ./src/docker.conf /etc/systemd/system/docker.service.d/docker.conf

# Add hassio supervised script
ADD ./src/installer.sh  /usr/sbin/installer.sh
RUN chmod a+x /usr/sbin/installer.sh
ADD ./src/entrypoint.service /etc/systemd/system/entrypoint.service
RUN systemctl enable entrypoint

# Add prepull image in case new container is deployed with existing configuration
ADD ./src/prepull.py  /usr/sbin/prepull.py
ADD ./src/prepull.service /etc/systemd/system/prepull.service
RUN systemctl enable prepull