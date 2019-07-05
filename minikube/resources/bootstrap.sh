#!/bin/bash

echo "**** Begin Setup"

echo "**** Switch mirror to ntc.net.np"
sudo sed -i 's|http://archive.ubuntu.com/ubuntu|http://ubuntu.ntc.net.np/ubuntu/|g' /etc/apt/sources.list

echo "**** Update package"
sudo apt-get update > /dev/null 2>&1 && sudo apt-get clean

echo "**** Copying Host"
sudo sh -c 'echo "192.168.56.101  minikube-local" >> /etc/hosts'

echo "**** Install git"
sudo apt-get install git -y > /dev/null 2>&1

echo "**** Install zip, unzip"
sudo apt-get install zip unzip -y > /dev/null 2>&1

echo "**** End Setup"