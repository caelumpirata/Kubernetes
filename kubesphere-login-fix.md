# kubesphere login issue
link:
```
https://lesscode.com/259.html
```

According to the instructions in the official community KubeSphere v3.1 installation succeeds, but login fails , comment out the upward resolution configuration of coredns forward.
```
# kubectl -n kube-system edit cm coredns -o yaml
# Please edit the object below. Lines beginning with a '#' will be ignored,
# and an empty file will abort the edit. If an error occurs while saving this file will be
# reopened with the relevant failures.
#
apiVersion: v1
data:
  Corefile: |
    .:53 {
        errors
        health {
           lameduck 5s
        }
        ready
        kubernetes cluster.local in-addr.arpa ip6.arpa {
           pods insecure
           fallthrough in-addr.arpa ip6.arpa
           ttl 30
        }
        prometheus :9153
       #forward . /etc/resolv.conf {
       #    max_concurrent 1000
       # }
        cache 30
        loop
        reload
        loadbalance
    }
kind: ConfigMap
metadata:
  creationTimestamp: "2024-03-15T06:21:58Z"
  name: coredns
  namespace: kube-system
  resourceVersion: "500334"
  uid: 3dadaea2-3800-4ae6-95d0-8c75713b3c1f
```
## restart pod
```
 kubectl  rollout restart deploy coredns -n kube-system
```
Login is OK now.
