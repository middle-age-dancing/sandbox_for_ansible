FROM ubuntu:20.04

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install Utilities
RUN apt autoclean && \
    apt clean all && \
    apt update && \
    apt install -y sudo git software-properties-common gpg-agent curl init systemd

# Install SSH server
RUN apt update && \
    apt install -y openssh-server && \
    rm -rf /var/lib/apt/lists/* && \
    echo "root:root" | chpasswd && \
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config

# Install Python
RUN apt update && \
    apt install -y python3 python3-pip

# Install PHP
RUN apt update && \
    apt install -y php

# Install Go
RUN add-apt-repository ppa:longsleep/golang-backports && \
    apt update && \
    apt install -y golang-go

# Set Time Zone
RUN apt update && \
    apt install -y tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Register public key
ADD id_rsa.pub /root/.ssh/
RUN mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys

# CMD service ssh start && /bin/bash
# NOTE: systemctl動かしたいのでinitをPID1で動かす必要がある。
CMD ["sh","-c","exec /usr/sbin/init && systemctl restart sshd.service"]