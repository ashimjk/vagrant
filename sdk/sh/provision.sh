#!/bin/bash

# sudo echo "Europe/Berlin" | sudo tee /etc/timezone
# sudo dpkg-reconfigure -f noninteractive tzdata

sudo apt-get update -y
sudo apt-get install -y build-essential curl git libssl-dev man

# Java
echo -e "-- Installing JAVA packages\n"

sudo add-apt-repository ppa:webupd8team/java -y
sudo apt-get update -qq

/bin/echo debconf shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
/bin/echo debconf shared/accepted-oracle-license-v1-1 seen true | /usr/bin/debconf-set-selections

sudo apt-get install -y oracle-java8-installer > /dev/null 2>&1

# Maven
echo -e "-- Installing MAVEN packages\n"
sudo apt-get install -y maven

# git clone https://github.com/creationix/nvm.git ~/.nvm && cd ~/.nvm && git checkout `git describe --abbrev=0 --tags`
# echo "source ~/.nvm/nvm.sh" >> ~/.profile
# source ~/.profile

# nvm install 0.10
# nvm alias default 0.10

# npm install -g dredd

# echo "cd ~/projects" >> ~/.profile

# echo ""
# echo "Everything done, have a nice day :-)!"
