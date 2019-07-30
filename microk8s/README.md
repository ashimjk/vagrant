# microk8s

Vagrant machine running [MicroK8s](https://microk8s.io/).

## Install prerequisites:

    brew cask install vagrant virtualbox virtualbox-extension-pack

## Guide
- Start the VM:
    ```
    vagrant up
    ```
- Show Kubernetes version:
    ```
    ./microk8s kubectl version
    ```
- Show Istio version:
    ```
    ./microk8s istioctl version
    ```
- Optional: Set environment variables to use `kubectl` on the host:
    ```
    source enable_microk8s.sh
    ```
- Unset environment variables configured by `source enable_microk8s.sh`:
    ```
    source disable_microk8s.sh
    ```
- Stop the VM:
    ```
    vagrant halt
    ```
- Destroy the VM:
    ```
    vagrant destroy -f
    ```

## Enable Dashboard
Proxy redirection
```
microk8s.kubectl proxy --accept-hosts=.* --address=0.0.0.0 &

http://192.168.56.101:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/
```

If RBAC is not enabled access the dashboard using the default token retrieved with:

```
token=$(microk8s.kubectl -n kube-system get secret | grep default-token | cut -d " " -f1)
microk8s.kubectl -n kube-system describe secret $token
```

In an RBAC enabled setup (microk8s.enable RBAC) you need to create a user with restricted
permissions as shown in https://github.com/kubernetes/dashboard/wiki/Creating-sample-user

- [Dashboard URL](http://localhost:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/service/kube-system/monitoring-grafana?namespace=kube-system)

## Checkout
- [Remote monitoring at the edge with MicroK8s](https://ubuntu.com/blog/monitoring-at-the-edge-with-microk8s)
- [Creating sample user](https://github.com/kubernetes/dashboard/wiki/Creating-sample-user)
- [Microk8s Dashboard Issue](https://github.com/ubuntu/microk8s/issues/292)
- [Accessing Dashboard](https://github.com/kubernetes/dashboard/wiki/Accessing-Dashboard---1.7.X-and-above)
- [Distributed kubernetes cluster](https://medium.com/@jimmysongio/setting-up-a-kubernetes-cluster-with-vagrant-and-virtualbox-3bb854017b60)