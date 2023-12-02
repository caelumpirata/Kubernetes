# EdgeMesh v1.11.0(server + agent) ✅working 30 nov,2023✅
```
helm install edgemesh -n kubeedge \
--set agent.image=kubeedge/edgemesh-agent:v1.11.0 \
--set server.image=kubeedge/edgemesh-server:v1.11.0 \
--set agent.modules.edgeProxy.socks5Proxy.enable=true \
--set server.nodeName=worker1 \
--set server.advertiseAddress="{worker1-node-ip}" \
https://raw.githubusercontent.com/kubeedge/edgemesh/release-1.11/build/helm/edgemesh.tgz
```
source: 
```
https://github.com/kubeedge/edgemesh/issues/403
```


# Edgemesh :v1.12.0 (4 agent doing all the work )
```
helm install edgemesh --namespace kubeedge \
--set agent.image=kubeedge/edgemesh-agent:v1.12.0 \
--set agent.relayNodes[0].nodeName=k8s-node1,agent.relayNodes[0].advertiseAddress="{119.8.211.54,2.2.2.2}" \
https://raw.githubusercontent.com/kubeedge/edgemesh/release-1.12/build/helm/edgemesh.tgz
```
# Working Edgemesh month
```
https://github.com/caelumpirata/Kubernetes/commit/ed9d40afa339efaee4ec9ad43e3b7949a38953ba
```

# Edgemesh official version commit dates
![image](https://github.com/caelumpirata/Kubernetes/assets/85424262/14ca0a6b-1d66-4ae5-b8fd-bc91a45a98b2)
