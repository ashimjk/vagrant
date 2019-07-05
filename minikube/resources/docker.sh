#!/bin/bash
echo "**** Begin installing Docker CE"

echo "**** Install packages to allow apt to use a repository over HTTPS"
apt-get install apt-transport-https -y
apt-get install ca-certificates -y
apt-get install curl -y
apt-get install gnupg-agent -y
apt-get install software-properties-common -y > /dev/null 2>&1

echo "**** Add Docker’s official GPG key"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -

echo "**** Set up the stable repository"
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

echo "**** Update the apt package index"
apt-get update > /dev/null 2>&1 && apt-get clean && apt-get autoclean

echo "**** Install a specific version of Docker CE "
apt-get install -y docker-ce=18.06.1~ce~3-0~ubuntu > /dev/null 2>&1

echo "**** use Docker as a non-root user"
usermod -aG docker vagrant

echo "**** Install docker compose"
curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

echo "**** End installing Docker CE"