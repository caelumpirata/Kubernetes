# Multinode Kubernetes Cluster with EdgeNode Using  KubeSphere
```
https://kubesphere.io/docs/v3.3/installing-on-linux/introduction/multioverview/
```

## *Prerequisite*:
- **Kubernetes Version** : v1.21.14  
- **Node Configuration** : CPU: 4 Cores, Memory: 4GB, Disk Space: 40GB
- **Necessary Downloads before you start** :
 ![image](https://user-images.githubusercontent.com/85424262/221347868-b746ee15-dd8f-4604-b7b0-b473bb88f039.png)


## This is how load balancer should look like: (Digital Ocean)
in case you want to use LoadBalancer in Digital Ocean
![image](https://user-images.githubusercontent.com/85424262/221346621-30a2c0e4-862d-4c2d-a50e-b680fc41156e.png)
- here *31915* is NodePort of Service, you want to connect to


# Enable - *KubeEdge*
```
https://kubesphere.io/docs/v3.3/pluggable-components/kubeedge/
```
### Notes :
- advertiseAddress: <your_master_external_ip>



Now follow these steps:
```
https://kubesphere.io/zh/blogs/kubesphere-kubeedge-edgemesh/#%E7%AE%80%E4%BB%8B
```
- and
```
https://github.com/kubeedge/edgemesh/blob/7fc16ecd98a84b6d001886285c7ae47239d9114f/docs/guide/ssh.md
```


- Which ever App you want to deploy on EdgeNode, just add **toleration** in the *service*.yanl
```
spec:

  containers:

  - name: nginx

    image: nginx

    imagePullPolicy: IfNotPresent

  tolerations:

  - key: "node-role.kubernetes.io/edge"

    operator: "Exists"

    effect: "NoSchedule"

```


- In this Step


  ![image](https://user-images.githubusercontent.com/85424262/221348657-efce7e33-1de8-4655-bc31-07287e04a869.png)
  
-  Change : **nc** into **netcat**


```
Deploy Edge Mesh

helm install edgemesh --namespace kubeedge \
--set agent.psk=qVkwAwxZ2AIb5VTY97pCPkF9LX8u9Jbz3mL0bPJrTBc= \
--set agent.modules.edgeProxy.socks5Proxy.enable=true \
--set agent.relayNodes[0].nodeName=master,agent.relayNodes[0].advertiseAddress="{your_master_external_ip}" \
https://raw.githubusercontent.com/kubeedge/edgemesh/main/build/helm/edgemesh.tgz


After the deployment is complete, you need to set the node tolerance of edgemesh-agent so that it can be scheduled to the master and edge nodes.

spec:
  template:
    spec:
      # 添加如下内容
      tolerations:
        - key: node-role.kubernetes.io/edge
          operator: Exists
          effect: NoSchedule
        - key: node-role.kubernetes.io/master
          operator: Exists
          effect: NoSchedule
Finally, check the deployment results (make sure edgemesh-agent runs a Pod on each node):

$ kubectl get pod -n kubeedge -o wide
NAME                               READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
cloud-iptables-manager-q9bsx       1/1     Running   0          16h   172.20.1.12    k8s-node02     <none>           <none>
cloud-iptables-manager-vvpv8       1/1     Running   0          16h   172.20.1.11    k8s-node01     <none>           <none>
cloud-iptables-manager-zwmdg       1/1     Running   0          16h   172.20.1.10    k8s-master     <none>           <none>
cloudcore-54b7f4f699-wcpjc         1/1     Running   0          16h   10.244.0.27    k8s-node02     <none>           <none>
edgemesh-agent-2l25t               1/1     Running   0          15m   172.20.1.12    k8s-node02     <none>           <none>
edgemesh-agent-cd67c               1/1     Running   0          14m   172.20.1.11    k8s-node01     <none>           <none>
edgemesh-agent-jtl9l               1/1     Running   0          14m   192.168.1.63   edge-node-01   <none>           <none>
edgemesh-agent-vdmzc               1/1     Running   0          16m   172.20.1.10    k8s-master     <none>           <none>
edgemesh-server-65b6db88fb-stckp   1/1     Running   0          16h   172.20.1.11    k8s-node01     <none>           <none>
edgeservice-855fdd8f94-8zd8k       1/1     Running   0          16h   10.244.0.42    k8s-node02     <none>           <none>
SSH Tunnel Broker
prerequisite

Please make sure edgemesh-agent has enabled socks5Proxy.
Make sure to execute the k8s-master node to install the nc command, if not, please execute yum -y install ncto install it.
$ kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
edge-node-01   Ready    agent,edge             21h   v1.21.4-kubeedge-v1.9.2
k8s-master     Ready    control-plane,master   16d   v1.21.5
k8s-node01     Ready    <none>                 16d   v1.21.5
k8s-node02     Ready    <none>                 23h   v1.21.5
 
$ ssh -o "ProxyCommand nc --proxy-type socks5 --proxy 169.254.96.16:10800 %h %p" root@edge-node-01
The authenticity of host 'edge-node-01 (<no hostip for proxy command>)' can't be established.
ECDSA key fingerprint is SHA256:alzjCdezpa8WxcW6lZ70x6sZ4J5193wM2naFG7nNmOw.
ECDSA key fingerprint is MD5:56:b7:08:1d:79:65:2e:84:8f:92:2a:d9:48:3a:15:31.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'edge-node-01' (ECDSA) to the list of known hosts.
root@edge-node-01's password:
Last failed login: Fri Jul  1 09:33:11 CST 2022 from 192.168.1.63 on ssh:notty
There was 1 failed login attempt since the last successful login.
Last login: Fri Jul  1 09:25:01 2022 from 192.168.20.168
[root@edge-node-01 ~]#
```


# Accesssing edgenode pod externally using edgenode ip address [LOCALLY ON THE EDGE ITSELF]
reference link:
```
https://www.alibabacloud.com/help/en/container-service-for-kubernetes/latest/use-the-host-network
```
```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: edge-app
spec:
  selector:
    matchLabels:
      app: edge-app
  replicas: 1
  template:
    metadata:
      labels:
        app: edge-app
    spec:
      hostNetwork: true    # ENABLE THIS 
      containers:
        - name: edge-app
          image: <ADD_CUSTOM_IMAGE>
          imagePullPolicy: Always
          ports:
            - containerPort: <EXPOSED_PORT_OF_IMAGE>
      nodeSelector:
          kubernetes.io/hostname: <YOUR_EDGE_NODE_NAME>
      tolerations:
        - key: "node-role.kubernetes.io/edge"    # MAKING SURE THE POD MUST BE DEPLOYED ON EDGE NODE ONLY
          operator: "Exists"
          effect: "NoSchedule"

```

-----------------------------------------------------------------------------------------
# BRIEF EXPLAINATION OF ABOVE STEPS
```
Use KubeEdge and EdgeMesh to realize node communication in edge complex network scenarios

Introduction
KubeEdge is the industry's first cloud-native edge computing framework designed for edge computing scenarios and designed for edge-cloud collaboration. Based on K8s' native container orchestration and scheduling capabilities, it realizes application collaboration, resource collaboration, data collaboration, and device collaboration between edge and cloud. Collaboration and other capabilities have completely opened up the cloud, edge, and device collaboration scenarios in edge computing. Among them, the KubeEdge architecture mainly includes three parts: cloud edge end:

The cloud is a unified control plane, including native K8s management components and KubeEdge self-developed CloudCore components, which are responsible for monitoring changes in cloud resources and providing reliable and efficient cloud-side message synchronization.
The side is mainly EdgeCore components, including Edged, MetaManager, EdgeHub and other modules, which are responsible for the lifecycle management of containers by receiving messages from the cloud.
The end side is mainly device mapper and eventBus, which are responsible for the access of end-side devices.


underlying logic
KubeEdge is an extension of K8s in edge scenarios. The goal is to extend K8s' ability to orchestrate containers to the edge; KubeEdge mainly includes two components, CloudCore on the cloud and EdgeCore on the edge node, as well as a Device module for managing a large number of edge devices.



KubeEdge functional components
Edged : An agent that runs and manages containerized applications on edge nodes.
EdgeHub : Web socket client responsible for interacting with Cloud Service for edge computing (such as Edge Controller in KubeEdge architecture). This includes synchronizing cloud-side resource updates to the edge, and reporting edge-side host and device state changes to the cloud.
CloudHub : Web socket server responsible for caching information in the cloud, monitoring changes, and sending messages to EdgeHub.
EdgeController : The extension controller of kubernetes, which is used to manage the metadata of edge nodes and pods, so that the data can be located to the corresponding edge nodes.
EventBus : An MQTT client that interacts with an MQTT server (mosquitto), providing publish and subscribe functionality for other components.
DeviceTwin : responsible for storing the device state and synchronizing the device state to the cloud. It also provides a query interface for applications.
MetaManager : Message processor between Edged side and EdgeHub side. It is also responsible for storing metadata to/retrieving metadata from a lightweight database (SQLite).
KubeEdge
In order to better support KubeEdge and provide a visual interface to manage edge nodes, this document uses the KubeSphere platform to manage edge nodes, KubeSphere official document .

Configure the cloud (KubeEdge Master node)
1. Enable KubeEdge
Use the admin identity to access the KubeSphere console, enter the cluster management, click 定制资源定义, find ClusterConfiguration, edit ks-install;



Find edgeruntimeand ,kubeedge modify the value to ;enabledtrue
The edgeruntime.kubeedge.cloudCore.cloudHub.advertiseAddressmodified value is set to the public network IP address;
Click "OK" in the lower right corner when finished, and ks-installercheck the log to see the deployment status.

2. Configure public network port forwarding
After the startup is complete, use the following command to see the NodePort port of CloudCore.

$ kubectl get svc -n kubeedge -l k8s-app=kubeedge
NAME        TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)                                                                           AGE
cloudcore   NodePort   10.96.0.106   <none>        10000:30000/TCP,10001:30001/TCP,10002:30002/TCP,10003:30003/TCP,10004:30004/TCP   3m
The public network port forwarding needs to be configured according to the following ports, and ports 10000-10004 are forwarded to ports 30000-30004 of NodePort.

field	Internet port	field	Intranet port
cloudhubPort	10000	cloudhubNodePort	30000
cloudhubQuicPort	10001	cloudhubQuicNodePort	30001
cloudhubHttpsPort	10002	cloudhubHttpsNodePort	30002
cloudstreamPort	10003	cloudstreamNodePort	30003
tunnelPort	10004	tunnelNodePort	30004
If there is a cloud provider, you need to create a load balancer to forward according to the rules in the above table. If there is no cloud provider, you can use the following command to configure iptablesrules for port forwarding:

iptables -t nat -A PREROUTING -p tcp --dport 10000 -j REDIRECT --to-ports 30000
iptables -t nat -A PREROUTING -p tcp --dport 10001 -j REDIRECT --to-ports 30001
iptables -t nat -A PREROUTING -p tcp --dport 10002 -j REDIRECT --to-ports 30002
iptables -t nat -A PREROUTING -p tcp --dport 10003 -j REDIRECT --to-ports 30003
iptables -t nat -A PREROUTING -p tcp --dport 10004 -j REDIRECT --to-ports 30004
3. Configure the iptables daemon
After the deployment is complete, it is found that the DaemonSet resource iptables is not scheduled to the k8s-master node, and it needs to be configured to tolerate master stains.

$ kubectl get pod -o wide -n kubeedge
NAME                               READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
cloud-iptables-manager-q9bsx       1/1     Running   0          28m   172.20.1.12    k8s-node02     <none>           <none>
cloud-iptables-manager-vvpv8       1/1     Running   0          28m   172.20.1.11    k8s-node01     <none>           <none>
cloudcore-54b7f4f699-wcpjc         1/1     Running   0          70m   10.244.0.27    k8s-node02     <none>           <none>
edgeservice-855fdd8f94-8zd8k       1/1     Running   0          53m   10.244.0.42    k8s-node02     <none>           <none>
Find "Application Load" - "Workload" - "Daemon Process Set", edit "cloud-iptables-manager" and add the following configuration:

kind: DaemonSet
apiVersion: apps/v1
metadata:
  name: cloud-iptables-manager
  namespace: kubeedge
spec:
  template:
    spec:
      ......
      # 添加如下配置
      tolerations:
        - key: node-role.kubernetes.io/master
          operator: Exists
          effect: NoSchedule
Note: If the above configuration is not modified, the Pod of the edge node cannot view logs and execute commands on KubeSphere.

After the configuration is complete, check again whether the iptables daemon has been dispatched to all nodes.

$ kubectl get pod -o wide -n kubeedge
NAME                               READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
cloud-iptables-manager-q9bsx       1/1     Running   0          28m   172.20.1.12    k8s-node02     <none>           <none>
cloud-iptables-manager-vvpv8       1/1     Running   0          28m   172.20.1.11    k8s-node01     <none>           <none>
cloud-iptables-manager-zwmdg       1/1     Running   0          29m   172.20.1.10    k8s-master     <none>           <none>
cloudcore-54b7f4f699-wcpjc         1/1     Running   0          70m   10.244.0.27    k8s-node02     <none>           <none>
edgeservice-855fdd8f94-8zd8k       1/1     Running   0          53m   10.244.0.42    k8s-node02     <none>           <none>
Configure the edge (KubeEdge Node node)
Add edge node documentation: https://kubesphere.com.cn/docs/installing-on-linux/cluster-operation/add-edge-nodes/

KubeEdge supports multiple container runtimes, including Docker, Containerd, CRI-O, and Virtlet. See the KubeEdge documentation for more information . To ensure that KubeSphere can get Pod metrics, Docker v19.3.0 or later needs to be installed on the edge side.

Add edge node


Go to the edge and execute the command copied from KubeSphere:

arch=$(uname -m); if [[ $arch != x86_64 ]]; then arch='arm64'; fi;  curl -LO https://kubeedge.pek3b.qingstor.com/bin/v1.9.2/$arch/keadm-v1.9.2-linux-$arch.tar.gz \
 &&  tar xvf keadm-v1.9.2-linux-$arch.tar.gz \
 && chmod +x keadm && ./keadm join --kubeedge-version=1.9.2 --region=zh --cloudcore-ipport=1x.xx.xx.28:10000 --quicport 10001 --certport 10002 --tunnelport 10004 --edgenode-name edge-node-01 --edgenode-ip 192.168.1.63 --token c2d7e72e15d28aa3e2b9340b9429982595b527b334a756be919993f45b7422b1.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NTY2NDU5NDJ9.bQeNr4RFca5GByALxVEQbiQpEYTyyWNzpDQVhm39vc8 --with-edge-taint
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 52.3M  100 52.3M    0     0  1020k      0  0:00:52  0:00:52 --:--:-- 1057k
./keadm
install MQTT service successfully.
kubeedge-v1.9.2-linux-amd64.tar.gz checksum:
checksum_kubeedge-v1.9.2-linux-amd64.tar.gz.txt content:
[Run as service] start to download service file for edgecore
[Run as service] success to download service file for edgecore
kubeedge-v1.9.2-linux-amd64/
kubeedge-v1.9.2-linux-amd64/cloud/
kubeedge-v1.9.2-linux-amd64/cloud/cloudcore/
kubeedge-v1.9.2-linux-amd64/cloud/cloudcore/cloudcore
kubeedge-v1.9.2-linux-amd64/cloud/iptablesmanager/
kubeedge-v1.9.2-linux-amd64/cloud/iptablesmanager/iptablesmanager
kubeedge-v1.9.2-linux-amd64/cloud/csidriver/
kubeedge-v1.9.2-linux-amd64/cloud/csidriver/csidriver
kubeedge-v1.9.2-linux-amd64/cloud/admission/
kubeedge-v1.9.2-linux-amd64/cloud/admission/admission
kubeedge-v1.9.2-linux-amd64/edge/
kubeedge-v1.9.2-linux-amd64/edge/edgecore
kubeedge-v1.9.2-linux-amd64/version
 
KubeEdge edgecore is running, For logs visit: journalctl -u edgecore.service -b
Check whether the edge node is added successfully:

$ kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
edge-node-01   Ready    agent,edge             23h   v1.21.4-kubeedge-v1.9.2
k8s-master     Ready    control-plane,master   16d   v1.21.5
k8s-node01     Ready    <none>                 16d   v1.21.5
k8s-node02     Ready    <none>                 25h   v1.21.5


After an edge node joins the cluster, some Pods may remain in the Pending state after being scheduled to the edge node. Due to the strong tolerance of some daemon sets (for example, Calico), you need to manually Patch Pods using the following script to prevent them from being scheduled to this edge node.

#!/bin/bash
NodeSelectorPatchJson='{"spec":{"template":{"spec":{"nodeSelector":{"node-role.kubernetes.io/master": "","node-role.kubernetes.io/worker": ""}}}}}'
 
NoShedulePatchJson='{"spec":{"template":{"spec":{"affinity":{"nodeAffinity":{"requiredDuringSchedulingIgnoredDuringExecution":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"node-role.kubernetes.io/edge","operator":"DoesNotExist"}]}]}}}}}}}'
 
edgenode="edgenode"
if [ $1 ]; then
        edgenode="$1"
fi
 
namespaces=($(kubectl get pods -A -o wide |egrep -i $edgenode | awk '{print $1}' ))
pods=($(kubectl get pods -A -o wide |egrep -i $edgenode | awk '{print $2}' ))
length=${#namespaces[@]}
 
for((i=0;i<$length;i++)); 
do
        ns=${namespaces[$i]}
        pod=${pods[$i]}
        resources=$(kubectl -n $ns describe pod $pod | grep "Controlled By" |awk '{print $3}')
        echo "Patching for ns:"${namespaces[$i]}",resources:"$resources
        kubectl -n $ns patch $resources --type merge --patch "$NoShedulePatchJson"
        sleep 1
done
Collect edge node monitoring information
1. In the ClusterConfigurationof of ,ks-installer change the of of to .metrics_serverenabletrue

2. Go to the edge node to edit the vim /etc/kubeedge/config/edgecore.yamlconfiguration file and change the toedgeStreamenabletrue

edgeStream:
  enable: true
  handshakeTimeout: 30
  readDeadline: 15
  server: 1x.xx.xx.x8:10004
  tlsTunnelCAFile: /etc/kubeedge/ca/rootCA.crt
  tlsTunnelCertFile: /etc/kubeedge/certs/server.crt
  tlsTunnelPrivateKeyFile: /etc/kubeedge/certs/server.key
  writeDeadline: 15
3. Restartsystemctl restart edgecore.service



Pods deployed to edge nodes need to be configured to tolerate taints:

spec:
  containers:
  - name: nginx
    image: nginx
    imagePullPolicy: IfNotPresent
  tolerations:
  - key: "node-role.kubernetes.io/edge"
    operator: "Exists"
    effect: "NoSchedule"
Edge Mesh
Introduction
EdgeMesh is positioned as a lightweight communication component of the KubeEdge user data plane, completes the Mesh of the network between nodes, establishes a P2P channel between nodes on the edge complex network topology, and completes the management and forwarding of traffic in the edge cluster on this channel , and finally provide a service discovery and traffic forwarding experience consistent with K8s Service for container applications in the user's KubeEdge cluster.

Official website: https://edgemesh.netlify.app/zh/



The figure above shows the brief architecture of EdgeMesh. EdgeMesh includes two microservices: edgemesh-server and edgemesh-agent.

EdgeMesh-Server:

EdgeMesh-Server runs on the cloud node, has a public network IP, monitors connection requests from EdgeMesh-Agent, and assists EdgeMesh-Agents to complete UDP hole punching and establish P2P connections;
In the case of hole punching failure between EdgeMesh-Agents, it is responsible for relaying the traffic between EdgeMesh-Agents, ensuring 100% traffic transfer success rate.
EdgeMesh-Agent:

The DNS module of EdgeMesh-Agent is a built-in lightweight DNS Server, which completes the conversion from Service domain name to ClusterIP.
The Proxy module of EdgeMesh-Agent is responsible for cluster Service service discovery and ClusterIP traffic hijacking.
The Tunnel module of EdgeMesh-Agent will establish a long-term connection with EdgeMesh-Server when it is started. When the applications on the two edge nodes need to communicate, they will make UDP holes through EdgeMesh-Server and try to establish a P2P connection. Once connected After the establishment is successful, the traffic on the subsequent two edge nodes does not need to be transferred by EdgeMesh-Server, thereby reducing network delay.
How EdgeMesh works
The cloud is a standard K8s cluster, which can use any CNI network plug-in, such as Flannel and Calico, and can deploy any K8s native components, such as Kubelet and KubeProxy; at the same time, the KubeEdge cloud component CloudCore is deployed on the cloud, and the KubeEdge edge component EdgeCore is run on the edge node. Registration of edge nodes to clusters on the cloud.



core advantages:

Cross-subnet edge/edge cloud service communication: No matter whether the application is deployed on the cloud or on the edge nodes of different subnets, it can provide a consistent experience through K8s Service.
Low latency: P2P direct connection between EdgeMesh-Agents is achieved through UDP hole punching, and data communication does not need to be transferred through EdgeMesh-Server.
Lightweight: Built-in DNS Server and EdgeProxy, the edge side does not need to rely on native components such as CoreDNS, KubeProxy, and CNI plug-ins.
Non-intrusive: use native K8s Service definition, no need to customize CRD, no need to customize fields, reducing user cost.
Strong applicability: It is not necessary for the edge site to have a public network IP, and it is not required for the user to set up a VPN. It is only required that the EdgeMesh-Server deployment node has a public network IP and the edge node can access the public network.
Deploy Edge Mesh
Log in to KubeSphere as admin, click on the workbench to enter the "system-workspace" workspace, find and enter kubeedge in the kubesphere-master cluster project, create a template-based application in the application load of the project, and choose to search for it from the "app store" "edgemesh" and click Install, please confirm whether the installation location is correct before installation.



Modify the following content in the application settings and click Install:

server:
  nodeName: "k8s-node01"   # 指定edgemesh-server部署的节点
  advertiseAddress:
    - 1x.xx.xx.x8         # 指定edgemesh-server对外暴漏服务的IP列表（此处填写的是华为云ELB的公网IP）
  modules:
    tunnel:
      enable: true
      listenPort: 20004    # 需要将该端口暴漏到公网（无需修改）
agent:
  modules:
    edgeProxy:
      enable: true
      socks5Proxy:
        enable: true       # 开启SSH隧道代理
        listenPort: 10800
After the deployment is complete, you need to set the node tolerance of edgemesh-agent so that it can be scheduled to the master and edge nodes.

spec:
  template:
    spec:
      # 添加如下内容
      tolerations:
        - key: node-role.kubernetes.io/edge
          operator: Exists
          effect: NoSchedule
        - key: node-role.kubernetes.io/master
          operator: Exists
          effect: NoSchedule
Finally, check the deployment results (make sure edgemesh-agent runs a Pod on each node):

$ kubectl get pod -n kubeedge -o wide
NAME                               READY   STATUS    RESTARTS   AGE   IP             NODE           NOMINATED NODE   READINESS GATES
cloud-iptables-manager-q9bsx       1/1     Running   0          16h   172.20.1.12    k8s-node02     <none>           <none>
cloud-iptables-manager-vvpv8       1/1     Running   0          16h   172.20.1.11    k8s-node01     <none>           <none>
cloud-iptables-manager-zwmdg       1/1     Running   0          16h   172.20.1.10    k8s-master     <none>           <none>
cloudcore-54b7f4f699-wcpjc         1/1     Running   0          16h   10.244.0.27    k8s-node02     <none>           <none>
edgemesh-agent-2l25t               1/1     Running   0          15m   172.20.1.12    k8s-node02     <none>           <none>
edgemesh-agent-cd67c               1/1     Running   0          14m   172.20.1.11    k8s-node01     <none>           <none>
edgemesh-agent-jtl9l               1/1     Running   0          14m   192.168.1.63   edge-node-01   <none>           <none>
edgemesh-agent-vdmzc               1/1     Running   0          16m   172.20.1.10    k8s-master     <none>           <none>
edgemesh-server-65b6db88fb-stckp   1/1     Running   0          16h   172.20.1.11    k8s-node01     <none>           <none>
edgeservice-855fdd8f94-8zd8k       1/1     Running   0          16h   10.244.0.42    k8s-node02     <none>           <none>
SSH Tunnel Broker
prerequisite

Please make sure edgemesh-agent has enabled socks5Proxy.
Make sure to execute the k8s-master node to install the nc command, if not, please execute yum -y install ncto install it.
$ kubectl get nodes
NAME           STATUS   ROLES                  AGE   VERSION
edge-node-01   Ready    agent,edge             21h   v1.21.4-kubeedge-v1.9.2
k8s-master     Ready    control-plane,master   16d   v1.21.5
k8s-node01     Ready    <none>                 16d   v1.21.5
k8s-node02     Ready    <none>                 23h   v1.21.5
 
$ ssh -o "ProxyCommand nc --proxy-type socks5 --proxy 169.254.96.16:10800 %h %p" root@edge-node-01
The authenticity of host 'edge-node-01 (<no hostip for proxy command>)' can't be established.
ECDSA key fingerprint is SHA256:alzjCdezpa8WxcW6lZ70x6sZ4J5193wM2naFG7nNmOw.
ECDSA key fingerprint is MD5:56:b7:08:1d:79:65:2e:84:8f:92:2a:d9:48:3a:15:31.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'edge-node-01' (ECDSA) to the list of known hosts.
root@edge-node-01's password:
Last failed login: Fri Jul  1 09:33:11 CST 2022 from 192.168.1.63 on ssh:notty
There was 1 failed login attempt since the last successful login.
Last login: Fri Jul  1 09:25:01 2022 from 192.168.20.168
[root@edge-node-01 ~]#
Note: Since the IP of the node may be duplicated, only the connection through the node name is supported.

In the v3.3.0 version, it is possible to log in to the terminal in the ks console.



error handling
The services of kubeedge and edgemesh are normal and there is no error in the log, but the cloud and the edge cannot communicate with each other.

Cloud configuration:

# 在云端，开启 dynamicController 模块，并重启 cloudcore
$ kubectl edit cm cloudcore -n kubeedge
modules:
  ..
  dynamicController:
    enable: true
..
$ kubectl rollout restart deploy cloudcore -n kubeedge
Edge configuration:

# 打开 metaServer 模块（如果你的 KubeEdge < 1.8.0，还需关闭 edgeMesh 模块）
vim /etc/kubeedge/config/edgecore.yaml
modules:
  ..
  edgeMesh:
    enable: false
  ..
  metaManager:
    metaServer:
      enable: true
# 配置 clusterDNS 和 clusterDomain
$ vim /etc/kubeedge/config/edgecore.yaml
modules:
  ..
  edged:
    clusterDNS: 169.254.96.16
    clusterDomain: cluster.local
 
# 重启 edgecore
$ systemctl restart edgecore
verify:

$ curl 127.0.0.1:10550/api/v1/services
{"apiVersion":"v1","items":[{"apiVersion":"v1","kind":"Service","......}

```

# Troubleshoot
```
https://devblogs.microsoft.com/commandline/systemd-support-is-now-available-in-wsl/
```
```
https://askubuntu.com/questions/1379425/system-has-not-been-booted-with-systemd-as-init-system-pid-1-cant-operate
```

