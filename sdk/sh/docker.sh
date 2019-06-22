#!/usr/bin/env bash

# Allow apt to use repo over HTTPS
echo "install docker default tools"
sudo apt-get install -yqq \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

# Add Docker’s official GPG key
echo "download docker"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

# Set up the stable repo
echo "add docker repo"
sudo add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) \
    stable"

# Update the packages
echo "update package"
sudo apt-get update -yqq

# Install docker-ce
echo "install docker-ce"
sudo apt-get install -yqq docker-ce > /dev/null 2>&1
sudo apt-get install docker-compose -yqq > /dev/null 2>&1

# Access docker w/o sudo
echo "add docker usermod"
sudo usermod -aG docker ubuntu
sudo usermod -aG docker vagrant