#!/usr/bin/env bash

# For more details see https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

# Import the public key used by the package management system
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5

# Create a list file for MongoDB
echo "download mongodb"
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list

# Reload local package database
echo "update package"
sudo apt-get update -yqq

# Install the MongoDB packages
echo "install mongodb"
sudo apt-get install -yqq mongodb-org

# Enable MongoDB to start on boot
echo "enable mongodb service"
sudo systemctl enable mongod.service

# Start MongoDB
sudo service mongod start