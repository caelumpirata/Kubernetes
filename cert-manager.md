# THIS IS HOW YOU ADD CERT-MANAGER TO YOUR PROJECT: 👈 
---------------------------------------------------

Video Reference:
        https://www.youtube.com/watch?v=MpovOI5eK58&t=1829s
        
Github Link: 
        https://github.com/digitalocean/Kubernetes-Starter-Kit-Developers/tree/main/03-setup-ingress-controller/assets
        

 after your application is accessible through ingress,
 
 Visit : https://artifacthub.io/packages/helm/cert-manager/cert-manager
 ```
        kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.10.0/cert-manager.crds.yaml
        
         helm repo add jetstack https://charts.jetstack.io
         
         kubectl create ns cert-manager
         
         helm install cert-manager --namespace cert-manager --version v1.10.0 jetstack/cert-manager     
 ```   
         
         
## Create a file named : issuer.yaml  👈 
```
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: letsencrypt-nginx
spec:
  acme:
    email: <your email address here>  👈 
    server: https://acme-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: letsencrypt-nginx-private-key
    solvers:
      # Use the HTTP-01 challenge provider
      - http01:
          ingress:
            class: nginx
```           
run:
```
kubectl create -f issuer.yaml
```
            
## Add following annotations line in ingress.yaml file  👈 

```
apiVersion: networking.k8s.io/v1
   
kind: Ingress
   
metadata:
   
  name: example-service-ingress
  
   
  annotations:
  
    cert-manager.io/issuer: letsencrypt-nginx  👈 
   
    nginx.ingress.kubernetes.io/rewrite-target: /$1

   
spec:
  tls:  👈 
    - hosts:  👈 
      - <hostname.com>  👈 
      secretName: letsencrypt-nginx  👈 
      .......
      ..
      .
      ..
      ......
      
``` 

upgrade your ingress deployment
```
helm upgrade <deployment_name> char_name
```



🤴🏾👧🏾👧🏾👧🏾👧🏾👧🏾👧🏾👧🏾👦🏾👦🏾👦🏾👦🏾👦🏾👵🏾

Bit more refined version of the above example
--------------------------------------------
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world
  namespace: <your_namespace>
  annotations:
    cert-manager.io/issuer: letsencrypt-nginx
spec:
  tls:
    - hosts:
      - "hello1.domain.com"
      - "hello2.domain.com"
      secretName: letsencrypt-nginx
  ingressClassName: nginx
  rules:
  - host: "hello1.domain1.com"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: <service_1>
            port:
              number: 1880
  - host: "hello2.domain.com"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: <service_2>
            port:
              number: 80



```

      
      
      
