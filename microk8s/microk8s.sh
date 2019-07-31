#!/bin/sh

sed -i 's|http://archive.ubuntu.com/ubuntu|http://ubuntu.ntc.net.np/ubuntu/|g' /etc/apt/sources.list

echo "Copying Host"
sudo cp /vagrant/hosts /etc/hosts

apt-get update
apt-get -y upgrade
apt-get clean
# apt-get -y install apt-transport-https

snap install docker --classic
sudo snap install helm --classic
# snap install knctl --classic
# snap install kubectl --classic

snap install microk8s --classic
microk8s.status --wait-ready
ufw allow in on cbr0
ufw allow out on cbr0
ufw default allow routed

microk8s.enable dns
microk8s.enable ingress
microk8s.enable dashboard
# microk8s.enable fluentd
# echo N | microk8s.enable istio
# microk8s.enable jaeger
# microk8s.enable metrics-server
# microk8s.enable prometheus
# microk8s.enable registry
# microk8s.enable storage

microk8s.kubectl config view --raw > $HOME/.kube/config
# microk8s.kubectl config view --raw > /vagrant/.kube-config

snap alias microk8s.istioctl istioctl
snap alias microk8s.kubectl kubectl
