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
>> id_rsa (assigning only READ Premission)
```
chmod 400 ~/.ssh/id_rsa
```
from link 
```
https://stackoverflow.com/questions/9270734/ssh-permissions-are-too-open
```

# Add new Node to existing(self managed) cluster
>> try connecting using above method by adding one more worker ndoe in the ansible playbook HOSTS file
>> Kubeadm join will fail, or if it wont show error , copy the kubeadm join syntax and run that manuall in the worker node (i did on vultr - different cloud provider from the master node on which it resides)
```
https://www.learnitguide.net/2020/03/add-new-worker-node-kubernetes-cluster.html
```
```
https://www.youtube.com/watch?v=mAaSZwPfKA0&ab_channel=LearnITGuideTutorials
```

# Labeling Node - so that you can use NODE-SELECTOR
```
kubectl label node ocean newnode=woker-node-3
```

# Ingress-nginx
custom ingress-nginx for self manged kuberntes, reference link
```
https://platform9.com/learn/v1.0/tutorials/nodeport-ingress
```
>> helm install blah..blah are for the cloud deploy, but
we are using BareMEtal so ,
apply this
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.1.1/deploy/static/provider/baremetal/deploy.yaml
```
## you must schedule ingress-pod on master node

label master node.
```
kubectl label nodes master1 ingress-nginx-controller=true
```
add this  in ingress controller deployment
```yaml
      nodeSelector:
        ingress-nginx-controller: "true"
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: ingress-nginx-controller
                operator: In
                values:
                - "true"
      tolerations:
      - key: node-role.kubernetes.io/master
        operator: Exists
        effect: NoSchedule
```
make sure your master node has enough cpu availlable or just remove the request from the depliyment of ingress controller
---
other ways of installing,
```
https://github.com/kubernetes/ingress-nginx/blob/main/docs/deploy/index.md#quick-start
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
# Using Digital Ocean LoadBalancer- $12/month
Before this:
>> Your application must be accessed through NodePort through Ingress eg.. http://your_domain.com : <ingress_controller_nodport> /

for this
```
https://docs.digitalocean.com/products/networking/load-balancers/how-to/create/
```

-------------------------------

Step 1: 
>> Connect your applications(node-port or grafana etc..) using Ingress

Step 2:
>> Expose your Ingress Controller using NopePort Service

Step 3: 
>> Inside your Digital Ocean LoadBalancer, Connect the droplet(the droplet which has ingress controller deployed in) 
>> or you can say
>> the droplet whose external ip is seen in ingress (after deploying ingress.yaml) 

Step 4: 
>> Inside the Digital Ocean Load Balancer setting
>> 
>>  GO to FORWARDING RULES
>>  
>>  Set Forwarding rules for TCP 80 --> TCP (INgress Controller Noedeport for TCP 80)
>>  Set Forwarding rules for TCP 443 --> TCP (INgress Controller Noedeport for TCP 443)
>>  
>>  and
>>  for health Check in next option below forwarding rules
>>  
>>  Choose TCP and for the port choose (INgress Controller Nodeport for TCP 80)
>>  
>>  SAVE !
>>  
>>  and 
>>  Inside the domain Configuration of Digital ocean Dashboard,
>> now Edit all the Ingress Application host and direct them to this **new LoadBalancer IP** .


# Troubleshoot Links and Methods
if worker node fails which you connected from different Cloud Provider :  (NOt Ready)
>> disabling swapoff might help :)
```
sudo swapoff -a
```
.
.
.

more troubleshoot links
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

>> aws instance no ping issue with public ip
```
https://arcadian.cloud/aws/2022/07/01/4-reasons-you-cannot-ping-your-aws-ec2-instance-and-how-to-fix-them/#:~:text=Quick%20Fix%3A%20The%20most%20common,inbound%20in%20your%20security%20group.
```
