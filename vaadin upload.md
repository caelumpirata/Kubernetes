# upload file in vaadin upload more than 1 mb

add this in spring boot `application.properties`
```
spring.servlet.multipart.max-file-size=10MB
spring.servlet.multipart.max-request-size=10MB
```

and if you are using `ingress controller` then add these  in `ingress.yaml`
```
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 10m
````
