FROM ubuntu:latest

ENV LC_ALL C.UTF-8
ENV DEBIAN_FRONTEND=noninteractive

# Install SSH server
RUN apt update && \
    apt install -y --no-install-recommends openssh-server sudo git && \
    rm -rf /var/lib/apt/lists/* && \
    echo "root:root" | chpasswd && \
    sed -i "s/#PermitRootLogin prohibit-password/PermitRootLogin yes/" /etc/ssh/sshd_config && \
    sed -i "s/#PubkeyAuthentication yes/PubkeyAuthentication yes/" /etc/ssh/sshd_config

# Install Python
RUN apt update && \
    apt install -y --no-install-recommends python3 python3-pip python3-dnf

# Set Time Zone
RUN apt update && \
    apt install -y --no-install-recommends tzdata && \
    ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime

# Register public key
ADD id_rsa.pub /root/.ssh/
RUN mv /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \
    chmod 700 /root/.ssh && \
    chmod 600 /root/.ssh/authorized_keys

CMD service ssh start && /bin/bash