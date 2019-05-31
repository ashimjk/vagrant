#!/bin/bash

curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
helm --version
helm version
nano rbac_helm.yaml
kubectl apply -f rbac_helm.yaml 
helm init --service-account tiller 
kubectl --namespace kube-system get pods
helm search mongodb

# rbac_helm.yaml file
apiVersion: v1
kind: ServiceAccount
metadata:
  name: tiller
  namespace: kube-system
---
apiVersion: rbac.authorization.k8s.io/v1beta1
kind: ClusterRoleBinding
metadata:
  name: tiller
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
  - kind: ServiceAccount
    name: tiller
    namespace: kube-system

  - kind: User
    name: "admin"
    apiGroup: rbac.authorization.k8s.io

  - kind: User
    name: "kubelet"
    apiGroup: rbac.authorization.k8s.io

  - kind: Group
    name: system:serviceaccounts
    apiGroup: rbac.authorization.k8s.io