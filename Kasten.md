Setup Kasten in Worker NOde
--------------------------------

Create a New Namespace named (kasten-io)
```
kubectl create ns kasten-io
```

install KASTEN in our new namespace (kasten-io) using following command
```
helm install k10 kasten/k10 --namespace=kasten-io
```





