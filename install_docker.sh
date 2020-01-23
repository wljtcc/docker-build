#!/bin/bash

echo "Install Git"
apt install git -y

echo "Install Docker - Latest Version"
wget -qO- https://get.docker.com/ | sh

echo "Install DockerCompose - Latest Version"
COMPOSE_VERSION=`git ls-remote https://github.com/docker/compose | grep refs/tags | grep -oP "[0-9]+\.[0-9][0-9]+\.[0-9]+$" | tail -n 1`
sudo sh -c "curl -L https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose"
sudo chmod +x /usr/local/bin/docker-compose
sudo sh -c "curl -L https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose"

echo "Install Docker Cleanup - Clean Trash Docker"
cd /tmp
git clone https://gist.github.com/76b450a0c986e576e98b.git
cd 76b450a0c986e576e98b
sudo mv docker-cleanup /usr/local/bin/docker-cleanup
sudo chmod +x /usr/local/bin/docker-cleanup

# RedHat8 / Cenots8

UNAME=`uname -a | awk '{print $2}'`

dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf clean packages
yum update

yum remove podman
dnf install docker-ce --nobest -y

systemctl start docker
systemctl enable docker
docker ps -a
