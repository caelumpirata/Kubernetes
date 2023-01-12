Install Kubernetes-dashboard in self managed kuberntes.
-------------------------------------------------------

### Add kubernetes-dashboard repository
```
helm repo add kubernetes-dashboard https://kubernetes.github.io/dashboard/
```
### Deploy a Helm Release named "kubernetes-dashboard" using the kubernetes-dashboard chart
```
helm install kubernetes-dashboard kubernetes-dashboard/kubernetes-dashboard
```

### Change the "kubernetes-dashboard" service from ClusterIP ->> NodePort
```
kubectl edit svc <kubernetes-dashboard>
```
>> in case, you are not familiar with vim,
>> press i to enable inser mode,
>> save and exit using :wq!
>> exit without editing :q!
>> you can access ur dashboard using, 
```
https://<ur_machine_ip_address> : <ur_dashboard_svc_nodeport> /#/login
```
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
>> >> usually starts with kubernetes-dashboard-token-xxxxx
```
kubectl get secret <dashboard-token-xxxxxxx> -o yaml
```
>> copy the TOKEN and decode it using base64 and paste it while signing into kubenetes dashboard
