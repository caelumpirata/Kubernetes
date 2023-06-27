# EdgeMesh v1.11.0(server + agent)
```
helm install edgemesh \
--set agent.image=kubeedge/edgemesh-agent:v1.11.0 \
--set server.image=kubeedge/edgemesh-server:v1.11.0 \
--set agent.modules.edgeProxy.socks5Proxy.enable=true \
--set server.nodeName=worker1 \
--set server.advertiseAddress="{master-node-ip}" \
https://raw.githubusercontent.com/kubeedge/edgemesh/release-1.11/build/helm/edgemesh.tgz
```
source: 
```
https://github.com/kubeedge/edgemesh/issues/403
```
