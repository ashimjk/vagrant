#!/usr/bin/env bash

# Get latest version of node
echo "download nodejs"
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash - > /dev/null 2>&1

# Install node
echo "install nodejs"
sudo apt-get install -yqq nodejs > /dev/null 2>&1

echo "configure npm prefix"
mkdir /home/vagrant/.npm
sudo chown -R vagrant:vagrant /home/vagrant/.npm

echo "npm config set prefix /home/vagrant/.npm" >> /home/vagrant/.bashrc
echo "export PATH=$PATH:/home/vagrant/.npm/bin" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc

# Update npm
echo "update npm"
npm install -g npm