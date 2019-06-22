#!/usr/bin/env bash

MYSQL_ROOT_PASSWORD=root

debconf-set-selections <<< "mysql-server mysql-server/root_password password ${MYSQL_ROOT_PASSWORD}"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password ${MYSQL_ROOT_PASSWORD}"

echo "install mysql"
sudo apt-get -yqq install mysql-server