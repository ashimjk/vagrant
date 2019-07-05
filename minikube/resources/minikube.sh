#!/bin/bash
echo "**** Begin downloading minikube"

echo "*** Download a static binary"
curl -Lo minikube https://storage.googleapis.com/minikube/releases/v0.32.0/minikube-linux-amd64 > /dev/null 2>&1
chmod +x minikube

echo "**** Add the Minikube executable to your path"
cp minikube /usr/local/bin/
rm minikube

echo "**** End downloading minikube"

echo "**** Begin starting a Cluster"

echo "**** Start a Cluster"
minikube start --vm-driver=none

echo "**** End starting a Cluster"
