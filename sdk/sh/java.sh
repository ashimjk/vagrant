#!/bin/bash

# Java
echo "add java repo"
sudo add-apt-repository ppa:webupd8team/java -y

echo "update package"
sudo apt-get update -yqq

/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections

echo "install java"
sudo apt-get install -yqq oracle-java8-installer > /dev/null 2>&1

# Maven
echo "install maven"
sudo apt-get install -yqq maven > /dev/null 2>&1