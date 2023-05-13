# unable to join worker node in kubesphere while your both master and worker nodes are on AWS
go to master and worker instance security group and add rule (ALL TCP) from anywhere in  inbound rules.






# Troubleshoot

### *unable to ping instance*
```
https://arcadian.cloud/aws/2022/07/01/4-reasons-you-cannot-ping-your-aws-ec2-instance-and-how-to-fix-them/
```

### *lb.kubesphere: 6443 .... error occurs*
enable port 6443 in master node
make sure you can connect to
```
telnet <MASTER_NODE_IP> 6443
```

### *systemd, cgroupfs error - unable to connect edgenode with kubesphere*
```
https://stackoverflow.com/questions/45708175/kubelet-failed-with-kubelet-cgroup-driver-cgroupfs-is-different-from-docker-c
```
```
sudo systemctl restart docker
```

### am i using *systemd*
```
https://superuser.com/questions/1017959/how-to-know-if-i-am-using-systemd-on-linux
```
