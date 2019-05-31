# Install Kubernetes

## Compatibility

Kubernetes is an open-source system for automating deployment, scaling, and management of containerized applications.

The below steps are applicabe for the below mentioned OS


| OS | Version | Codename |  
| --- | --- | -- |  
| **Ubuntu** | **16.04** | **Xenial** |  


## Base Setup

On all nodes which would be part of this cluster, you need to do the base setup as described here,

### Direct Install
```bash
#!/bin/bash 

apt-get update
apt-get install -y git wget

# Install Docker
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
apt-key fingerprint 0EBFCD88
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
   
apt-get update

apt-get install -yq docker-ce

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

sudo cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update -y

sudo apt-get install -y  kubelet kubeadm kubectl kubernetes-cni nfs-common

sudo sysctl net.bridge.bridge-nf-call-iptables=1
sudo swapoff -a

sudo rm -rf /var/lib/kubelet/*

sudo apt-get install nfs-common -y

```

### Create Kubernetes Repository

We need to create a repository to download Kubernetes.

```
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
```
```
cat <<EOF > /etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
```

### Installation of the packages

We should update the machines before installing so that we can update the repository.
```
apt-get update -y
```
Installing all the packages with dependencies:
```
apt-get install -y docker.io kubelet kubeadm kubectl kubernetes-cni
```
```
rm -rf /var/lib/kubelet/*
```

### Setup sysctl configs

In order for many container networks to work, the following needs to be enabled on each node.

```
sysctl net.bridge.bridge-nf-call-iptables=1
```
The above steps has to be followed in all the nodes.