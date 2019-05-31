# Installing Docker, Minikube and Kubernetes in Vagrant

## Vagrant

Available Vagrant Boxes for VirtualBox (and Ubuntu).
[https://app.vagrantup.com/boxes/search]

```vagrant init ubuntu/xenial64```

This initializes the current directory to be a Vagrant environment by creating an initial Vagrantfile if one does not already exist.
[https://www.vagrantup.com/docs/cli/init.html]

Please see [https://www.vagrantup.com/docs/vagrantfile/machine_settings.html] for information about Vagrantfile. Below is the explanation of the configuration options of Vagrantfile:

- config.vm.box
  - This configures what box the machine will be brought up against. The value here should be the name of an installed box or a shorthand name of a box in HashiCorp’s Vagrant Cloud.
- config.vm.network
  - Configures networks on the machine. Please see the networking page for more information.
- config.vm.provider
  - Configures provider-specific configuration, which is used to modify settings which are specific to a certain provider. If the provider we are configuring does not exist or is not setup on the system of the person who runs vagrant up, Vagrant will ignore this configuration block. This allows a Vagrantfile that is configured for many providers to be shared among a group of people who may not have all the same providers installed.
- config.vm.provision
  - Configures provisioners on the machine, so that software can be automatically installed and configured when the machine is created. Please see the page on provisioners for more information on how this setting works.

## Minikube

Minikube is a tool that makes it easy to run Kubernetes locally. Minikube runs a single-node Kubernetes cluster for users looking to try out Kubernetes or develop with it day-to-day.
[https://kubernetes.io/docs/setup/minikube/]

## Docker

Docker Community Edition (CE) is ideal for individual developers and small teams looking to get started with Docker and experimenting with container-based apps.

Docker Enterprise Edition (EE) is designed for enterprise development and IT teams who build, ship, and run business critical applications in production at scale.
[https://docs.docker.com/install/overview/]

> Minikube –vm-driver=none option requires Docker CE, version 18.06.

[https://docs.docker.com/install/linux/docker-ce/ubuntu/]

## Kubectl

The minikube start command creates a kubectl context called “minikube”. This context contains the configuration to communicate with our Minikube cluster.
[https://kubernetes.io/docs/setup/minikube/#kubectl]

## Kubernetes Dashboard

To access the Kubernetes Dashboard, run this command in a shell after starting Minikube to get the address: minikube dashboard
[https://kubernetes.io/docs/setup/minikube/#dashboard]

## Interact with the Cluster via the Dashboard

We can access Dashboard using the kubectl command-line tool by running the following command:

```kubectl proxy```

Kubectl will make Dashboard available at:

http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/.

The UI can only be accessed from the machine where the command is executed. See kubectl proxy –help for more options.
[https://kubernetes.io/docs/tasks/access-application-cluster/web-ui-dashboard/]

Because kubectl will make the Dashboard available at:
[http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/]

and we wanted to use a Web Browser, so we need to use the forwarded_port configuration option, to forward port 8001 on our host (Mac) to port 8001 on our guest (Ubuntu).

Vagrant forwarded ports allow us to access a port on our host machine and have all data forwarded to a port on the guest machine, over either TCP or UDP.
[https://www.vagrantup.com/docs/networking/forwarded_ports.html]

## Minikube Dashboard URL Issue

When we used the following commands in the end part of the minikube.sh file in order to get the dashboard URL, in the output we will get the error, see below.

### Start a Cluster

``` sh
echo "**** Begin starting a Cluster"

minikube start --vm-driver=none
echo "Dashboard UI: "
minikube dashboard --url

echo "**** End starting a Cluster"
```

```log
Error:
ubuntu_minikube: Dashboard UI:
ubuntu_minikube: ========================================
ubuntu_minikube: kubectl could not be found on your path. kubectl is a requirement for using minikube
ubuntu_minikube: To install kubectl, please run the following:
ubuntu_minikube:
ubuntu_minikube: curl -Lo kubectl https://storage.googleapis.com/kubernetes-release/release/v1.12.4/bin/linux/amd64/kubectl && chmod +x kubectl && sudo cp kubectl /usr/local/bin/ && rm kubectl
ubuntu_minikube:
ubuntu_minikube: To disable this message, run the following:
ubuntu_minikube:
ubuntu_minikube: minikube config set WantKubectlDownloadMsg false
ubuntu_minikube: ========================================
ubuntu_minikube: F0208 10:59:29.351260 5606 dashboard.go:77] kubectl proxy: kubectl not found in PATH: exec: “kubectl”: executable file not found in $PATH
```

The minikube dashboard command needs kubectl, and that wasn’t installed, because minikube needed to be installed first (see before).

When I used the following commands in the end part of the kubectl.sh file in order to get the dashboard URL, in the output I could see the script wasn’t executed till the last command.
The –url flag means: Display dashboard URL instead of opening a browser

```sh
echo "**** Begin preparing dashboard"

echo "Dashboard UI: "
minikube dashboard --url
kubectl proxy

echo "**** End preparing dashboard"
```

```log
Output:

ubuntu_minikube: **** End installing kubectl
ubuntu_minikube: **** Begin preparing dashboard
ubuntu_minikube: Dashboard UI:
ubuntu_minikube: http://127.0.0.1:42796/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/
```

On the Internet I found others had the same problem, but it seems to be done intentionally as a security precaution.
[https://github.com/kubernetes/minikube/issues/3236]

So, I removed the minikube dashboard –url command, because from the documentation and the output we know by now the dashboard URL.

In a Web Browser I entered the URL:
[http://127.0.0.1:8001/api/v1/namespaces/kube-system/services/http:kubernetes-dashboard:/proxy/]

And got an error message: This site can’t be reached.

So again, a had to find a solution. I search on the Internet and found a solution that worked for me.
[https://stackoverflow.com/questions/47173463/how-to-access-local-kubernetes-minikube-dashboard-remotely/47585628]

In the scripts directory I changed file kubectl.sh to the following content:

```sh
#!/bin/bash
echo "**** Begin installing kubectl"

#Install kubectl binary
sudo apt-get update && sudo apt-get install -y apt-transport-https
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee -a /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
```

### Check the kubectl configuration

`kubectl cluster-info`

### Make kubectl work for our non-root user named vagrant

```sh
mkdir -p /home/vagrant/.kube
sudo cp -i /etc/kubernetes/admin.conf /home/vagrant/.kube/config
sudo chown vagrant:vagrant /home/vagrant/.kube/config

echo "**** End installing kubectl"

echo "**** Begin preparing dashboard"

kubectl proxy --address='0.0.0.0'

echo "**** End preparing dashboard"
```

> We can also use the following command:
`kubectl proxy –address=’0.0.0.0′ –port=8001`

## Common Issues

Linux Command Prompt: kubectl get nodes

With the following output:
The connection to the server localhost:8080 was refused – did we specify the right host or port?

Again, we get the message we have seen before.

The connection to the server <server-name:port> was refused – did we specify the right host or port?

If we see a message similar to the following, kubectl is not correctly configured or not able to connect to a Kubernetes cluster.
[https://kubernetes.io/docs/tasks/tools/install-kubectl/#check-the-kubectl-configuration]

Earlier we fixed the connection to the Kubernetes cluster, so now let’s focus on having the correct configuration.

By default, kubectl looks for a file named config in the $HOME/.kube directory. We can specify other kubeconfig files by setting the KUBECONFIG environment variable or by setting the –kubeconfig flag.
[https://kubernetes.io/docs/concepts/configuration/organize-cluster-access-kubeconfig/]

To make kubectl work for our non-root user, run these commands, which are also part of the kubeadm init output:

```sh
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

Alternatively, if we are the root user, we can run:

`export KUBECONFIG=/etc/kubernetes/admin.conf`

[https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/]

Until now all the commands via the Vagrantfile (and provisioning scripts) are via Vagrant executed as user root with /root as $HOME.

However, via de Linux Command Prompt (ssh), the user named vagrant is executing the kubectl commands. This user does not have a file named config in the $HOME/.kube directory.