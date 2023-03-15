# Install Kubesphere on linux machine  - (MULTI NODE INSTALLATION)

```
https://kubesphere.io/docs/v3.3/installing-on-linux/introduction/multioverview/
```

install *socat* and *conntrack* - if asked while deploying *kubekey*
```
sudo apt-get update
sudo apt-get install socat
sudo apt install conntrack
sudo apt install ebtables
```


# Setup KugeEdge

>> follow *Installing on Linux* section
```
https://kubesphere.io/docs/v3.3/pluggable-components/kubeedge/
```

>> Changes to make in *config-sample.yaml*
```
edgeruntime:          # Add edge nodes to your cluster and deploy workloads on edge nodes.

 enabled: true    #------------------------> true

 kubeedge:        # kubeedge configurations

   enabled: true  #----------------------> true 

   cloudCore:

     cloudHub:

       advertiseAddress: # At least a public IP address or an IP address which can be accessed by edge nodes must be provided.

         - "PUBLIC_IP_MASTER_NODE"    #---------------------------->  Add IP of your cluster i.e MASTER public IP address(TESTED)

     service:

       cloudhubNodePort: "30000"

       cloudhubQuicNodePort: "30001"

       cloudhubHttpsNodePort: "30002"

       cloudstreamNodePort: "30003"

       tunnelNodePort: "30004"

     # resources: {}

     # hostNetWork: false

```


## Additional Changes to make
edit *cloudcore.yaml*

![image](https://user-images.githubusercontent.com/85424262/217455931-9734e251-a941-4f06-a8ed-40851f5d85fd.png)

```
apiVersion: cloudcore.config.kubeedge.io/v1alpha2
kind: CloudCore
kubeAPIConfig:
  kubeConfig: ""
  master: ""
modules:
  cloudHub:
    advertiseAddress:
    - MASTER_NODE_PUBLIC_IP   #------------------------------> MASTER_NODE_PUBLIC_IP
    nodeLimit: 1000
    tlsCAFile: /etc/kubeedge/ca/rootCA.crt
    tlsCertFile: /etc/kubeedge/certs/edge.crt
    tlsPrivateKeyFile: /etc/kubeedge/certs/edge.key
    unixsocket:
      address: unix:///var/lib/kubeedge/kubeedge.sock
      enable: true
    websocket:
      address: 0.0.0.0
      enable: true
      port: 10000
    quic:
      address: 0.0.0.0
      enable: false
      maxIncomingStreams: 10000
      port: 10001
    https:
      address: 0.0.0.0
      enable: true
      port: 10002
  cloudStream:
    enable: true
    streamPort: 10003
    tunnelPort: 10004
  dynamicController:
    enable: false
  router:
    enable: false
  iptablesManager:
    enable: true
    mode: external
```







# Add Edge Nodes

>> Make sure you have already enabled *Kube Edge* in kubesphere
```
https://kubesphere.io/docs/v3.3/installing-on-linux/cluster-operation/add-edge-nodes/
```

>> create *.sh* executable file 
```
https://www.andrewcbancroft.com/blog/musings/make-bash-script-executable/
```

>> After you add *EDGE_NODE_INTERNAL_IP* and validate

![image](https://user-images.githubusercontent.com/85424262/217451808-83792777-0fe4-4e7b-82c2-c3562a968c39.png)

>> make sure to change *HIGHLIGHTED_PORT* to *30000*, *30001*, *30002*, *30004* and then run in your *Edge_Node* Droplet

![image](https://user-images.githubusercontent.com/85424262/217451580-f3d9c530-5d4b-4711-8ec2-2d48f563fbda.png)

>> Otherwise it will genereate *CA_certificate_error*, follow *Troubleshoot link Below*
```
https://kubesphere.io/forum/d/4359-kubesphere-31-ksinstall
```







# To add Extra node - in case NEEDED

```
https://kubesphere.io/docs/v3.3/installing-on-linux/cluster-operation/add-new-nodes/
```
>> just add the new node detail in *config-sample.yaml* like you did when adding master and worker node address and name etc in multinode installation step after deploying *kubekey*


# Failed to Schedule pod in *EDGE NODE*
just remove taint from edge node if availalbe


# Troubleshoot links:
CA certificate error solved using this -.
```
https://kubesphere.io/forum/d/4359-kubesphere-31-ksinstall
```

## Metrics Data unavailable for EdgeNOde
```
https://kubesphere.io/docs/v3.3/pluggable-components/pod-ip-pools/#enable-pod-ip-pools-before-installation
```
make changes to 
```
network:

  ippool:

    type: weave-scope # Change "none" to "weave-scope".

```

2nd Change
```
https://kubesphere.io/docs/v3.3/installing-on-linux/cluster-operation/add-edge-nodes/
```
```
edgeStream:

enable: true #Change "false" to "true".。

handshakeTimeout: 30

readDeadline: 15

server: xx.xxx.xxx.xxx:10004 #If port forwarding is not configured, change the port ID to 30004 here. #----------------------------->>consider changing it to 30004

tlsTunnelCAFile: /etc/kubeedge/ca/rootCA.crt

tlsTunnelCertFile: /etc/kubeedge/certs/server.crt

tlsTunnelPrivateKeyFile: /etc/kubeedge/certs/server.key

writeDeadline: 15
```

Consider installing it 
```
https://kubesphere.io/docs/v3.3/pluggable-components/service-topology/
```

