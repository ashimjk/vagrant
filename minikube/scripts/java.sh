#!/bin/bash
echo "**** Begin Java Download"

# Update package
apt-get update -y

# Install Git
apt-get install -y git

#Install Java
add-apt-repository ppa:webupd8team/java -y
apt-get update

/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections

apt-get install -y oracle-java8-installer > /dev/null 2>&1

# Install maven
apt-get install -y maven

echo "**** End Java Download"