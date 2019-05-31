#!/bin/bash

echo "Begin Setup"

echo "Update to Fast Mirror"
sudo sed 's@archive.ubuntu.com@ubuntu.ntc.net.np@' -i /etc/apt/sources.list > /dev/null 2>&1

echo "Copying Host"
sudo cp /vagrant/resources/hosts /etc/hosts

echo "Adding Google Cloud Key"
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - > /dev/null 2>&1

echo "Copying Kubernetes List"
sudo cp /vagrant/resources/kubernetes.list /etc/apt/sources.list.d/kubernetes.list

echo "Update package"
sudo apt-get update > /dev/null 2>&1

echo "Install Docker, Kubelet, Kubeadm, Kubectl, Kubernetes CNI"
sudo apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni > /dev/null 2>&1

echo "Clean Up"
sudo rm -rf /var/lib/kubelet/*

echo "Turning off Swap"
sudo swapoff -a

echo "Joining NFS..."
sudo apt-get install nfs-common -y > /dev/null 2>&1

echo "Docker Usermod"
sudo usermod -aG docker vagrant

echo "End Setup"