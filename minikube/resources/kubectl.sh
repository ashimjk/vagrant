#!/bin/bash
echo "**** Begin installing kubectl"

echo "Copying Host"
sudo cp /vagrant/scripts/hosts /etc/hosts

echo "**** Install kubectl binary"
apt-get update > /dev/null 2>&1 && apt-get clean && apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | tee -a /etc/apt/sources.list.d/kubernetes.list
apt-get update > /dev/null 2>&1 && apt-get clean
apt-get install -y kubectl

echo "**** Check the kubectl configuration"
kubectl cluster-info

echo "**** Make kubectl work for your non-root user named vagrant"
mkdir -p /home/vagrant/.kube
cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
chown vagrant:vagrant /home/vagrant/.kube/config

echo "**** End installing kubectl"

echo "**** Begin preparing dashboard"

apt-get install bash-completion -y

echo 'source <(kubectl completion bash)' >> /home/vagrant/.bashrc

kubectl proxy --address='0.0.0.0'

echo "**** End preparing dashboard"
