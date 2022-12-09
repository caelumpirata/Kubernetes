Install Ingress controller :
	minikube addons enable ingress

*** get all components:     [ kubectl get all -n kubernetes-dashboard ]

Setup Rules for Ingress:
```

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$1
spec:
  rules:
    - host: hello-world.info
      http:
        paths:
          - path: /(.*)
            pathType: Prefix
            backend:
              service:
                name: spring-hello-service
                port:
                  number: 8080


  ```
  adding multiple hosts and getting their certificates
  ---------------------------------------------------
  ```
  
apiVersion: networking.k8s.io/v1
   
kind: Ingress
   
metadata:
   
  name: example-service-ingress
  
   
  annotations:
    cert-manager.io/issuer: letsencrypt-nginx
   
    nginx.ingress.kubernetes.io/rewrite-target: /$1

   
spec:
  tls:
    - hosts:
      - <subdomain1>.example.link
      secretName: <your secred here _any string>
    - hosts:
      - <subdomain2>.example.link
      secretName: <letsencrypt-nginx>
   
  rules:
   
    - host: <subdomain1>.example.link
   
      http:
   
        paths:
   
          - path: /(.*)
            pathType: Prefix
   
            backend:
   
              service:
   
                name: <service_name_app_1>
   
                port:
   
                  number: 80
                  
    - host: <subdomain2>.example.link
   
      http:
   
        paths:
   
          - path: /(.*)
            pathType: Prefix
   
            backend:
   
              service:
   
                name: <service_name_app_2>
   
                port:
   
                  number: 3000
                       
  ingressClassName: nginx
  

  ```

	
	

