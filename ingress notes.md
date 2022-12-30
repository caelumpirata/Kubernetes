# Install it using
```
https://artifacthub.io/packages/helm/ingress-nginx/ingress-nginx
```


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

	
	

