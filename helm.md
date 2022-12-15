# Helm - 

### deploy *Ingress* + *Application* using HELM

### install *Ingress*
---------------------

Visit: https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
```
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

install it using : 
```
helm install ingress-nginx ingress-nginx/ingress-nginx
```

### install *Application*
-------------------------
install & upgrade
```
helm install <any_custom_name> chart_name
&
helm upgrade <custom_name> chart_name
```
here, the chart_name is mainly the folder name which consists all you yaml Files & Folders like, values.yaml, templete etc......


Assign name to Deployed Nodes
-----------------------------
```
kubectl label nodes <your_node> kubernetes.io/role=<your_label>
```


Helm install :  --nodeSelector
-------------------------------
```
helm install <any_custom_name> chart_name --set nodeSelector."kubernetes\.io/role"=<your_custom_role>
```







