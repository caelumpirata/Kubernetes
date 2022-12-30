Install Kubernetes-dashboard in self managed kuberntes.
-------------------------------------------------------

### Add kubernetes-dashboard repository
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
### Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard

-----------------------------------------------------------------------------

### Create SERVICEACCOUNT
```
kubectl create serviceaccount dashboard -n default
```

### Create Cluster role binding
```
kubectl create clusterrolebinding dashboard-admin -n default --clusterrole=cluster-admin --serviceaccount=default:dashboard
```

### Get your secret for signing in in your dashboard
>> you find it in default namespace
```
kubectl get secret <dashboard-token-xxxxxxx> -o yaml
```
>> copy the TOKEN and decode it using base64 and paste it while signing into kubenetes dashboard
