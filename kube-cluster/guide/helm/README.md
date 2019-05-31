# Helm Permission Issue

kubectl --namespace kube-system create serviceaccount tiller

kubectl create clusterrolebinding tiller-cluster-rule \
 --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

kubectl --namespace kube-system patch deploy tiller-deploy \
 -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}' 
Console output:

serviceaccount "tiller" created
clusterrolebinding "tiller-cluster-rule" created
deployment "tiller-deploy" patched
Then run command below to check it :

helm list
helm repo update
helm install --name nginx-ingress stable/nginx-ingress
