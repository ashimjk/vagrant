#!/bin/sh

sed -i 's|http://archive.ubuntu.com/ubuntu|http://ubuntu.ntc.net.np/ubuntu/|g' /etc/apt/sources.list

sudo cp /vagrant/common/hosts /etc/hosts

apt-get update
apt-get -y upgrade
apt-get clean
apt-get -y install apt-transport-https git curl

snap install docker
sudo snap install helm --classic

snap install microk8s --classic
microk8s.status --wait-ready

ufw allow in on cbr0
ufw allow out on cbr0
ufw default allow routed

microk8s.enable dns
microk8s.enable ingress
microk8s.enable registry
microk8s.enable storage

microk8s.kubectl config view --raw > /root/.kube/config

snap alias microk8s.istioctl istioctl
snap alias microk8s.kubectl kubectl
