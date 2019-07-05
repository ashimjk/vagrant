#!/bin/bash

echo "**** Begin Setup"

echo "**** Switch mirror to ntc.net.np"
sudo sed -i 's|http://archive.ubuntu.com/ubuntu|http://ubuntu.ntc.net.np/ubuntu/|g' /etc/apt/sources.list

echo "**** Update package"
sudo apt-get update > /dev/null 2>&1 && apt-get clean

echo "**** Copying Host"
sudo sh -c 'echo "192.168.56.101  kube-dev" >> /etc/hosts'

echo "**** Adding Google Cloud Key"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - > /dev/null 2>&1

echo "**** Copying Kubernetes List"
sudo sh -c 'echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" >> /etc/apt/sources.list.d/kubernetes.list'

echo "**** Update package"
sudo apt-get update > /dev/null 2>&1 && apt-get clean

echo "**** Install Docker, Kubelet, Kubeadm, Kubectl, Kubernetes CNI"
sudo apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni > /dev/null 2>&1

echo "**** Clean Up"
sudo rm -rf /var/lib/kubelet/*

echo "**** Turning off Swap"
sudo swapoff -a

echo "**** Joining NFS..."
sudo apt-get install nfs-common -y > /dev/null 2>&1

echo "**** Docker Usermod"
sudo usermod -aG docker vagrant

echo "**** End Setup"