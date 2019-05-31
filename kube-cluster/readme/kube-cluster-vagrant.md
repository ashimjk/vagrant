# Kube Cluster Using Vagrant

## Install VirtualBox and Vagrant

| TOOL  |  LINK |
|---|---|
| VirtualBox  |   https://www.virtualbox.org/wiki/Downloads |
| Vagrant  | https://www.vagrantup.com/downloads.html   |  


## Provisioning Vagrant Nodes

Clone repo if not already

```
git clone https://github.com/schoolofdevops/lab-setup.git
```

Launch environments with Vagrant

```
cd lab-setup/kubernetes/vagrant-kube-cluster

vagrant up
```

Login to nodes

Open three different terminals to login to 3 nodes created with above command

**Terminal 1**
```
vagrant ssh kube-01
sudo su
```
**Terminal 2**

```
vagrant ssh kube-02
sudo su
```

**Terminal 3**

```
vagrant ssh kube-03
sudo su
```

## Validating the Setup
```
docker version
kubectl version
kubeadm version
```