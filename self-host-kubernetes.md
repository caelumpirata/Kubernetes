How to self host kubernetes NOTES  :+)
Tutorial used
```
https://www.digitalocean.com/community/tutorials/how-to-create-a-kubernetes-cluster-using-kubeadm-on-ubuntu-20-04
```
NOTES
```
Create your droplet in Digital Ocean (or any Service cloud provider) and make sure to set SSH for accessing your machine.
```

```
Add your (id_rsa) and its (id_rsa.pub) in ur LOCAL MACHINES'S  root's home directory
>> .ssh folder might be hidden in your case, But the folder does exits there.
>> so just navigate cd .ssh and add both files (id_rsa and id_rsa.pub) inside.
```

# Add new Node to existing(self managed) cluster
```
https://www.learnitguide.net/2020/03/add-new-worker-node-kubernetes-cluster.html
```

# Labeling Node - so that you can use NODE-SELECTOR
```
kubectl label node ocean newnode=woker-node-3
```

# Ingress-nginx
custom ingress-nginx for self manged kuberntes 
```
https://platform9.com/learn/v1.0/tutorials/nodeport-ingress
```
apply this
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```
# ingress.yaml -2 hosts - tested using (nodeport)
```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: hello-world
  namespace: default
  annotations:
spec:
  ingressClassName: nginx
  rules:
  - host: "nred.example.com"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: nodered-node-red
            port:
              number: 1880
  - host: "g.example.com"
    http:
      paths:
      - pathType: Prefix
        path: "/"
        backend:
          service:
            name: grafana
            port:
              number: 80
```

# Troubleshoot Links
```
https://stackoverflow.com/questions/52119985/kubeadm-init-shows-kubelet-isnt-running-or-healthy
```
```
https://redplug.tistory.com/835
```
```
https://www.edureka.co/community/63389/fileavailable-kubernetes-kubernetes-fileavailable-kubernetes#:~:text=You%27re%20getting%20the%20following,execute%20then%20join%20command%20again.
```
```
https://stackoverflow.com/questions/49721708/how-to-install-specific-version-of-kubernetes
```
```
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
```

```
https://www.ibm.com/docs/en/control-desk/7.6.1.x?topic=kubernetes-installing-kubeadm-kubelet-kubectl
```

```
https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/
```
