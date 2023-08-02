# When you have the edenode with arm64 arch
replace amd64 with arm64 wherever it is mentioned !

## kubelet failed with kubelet cgroup driver: "cgroupfs" is different from docker cgroup driver: "systemd"
```
https://gist.github.com/jimangel/21568c757b2b374cabb8cc53e6c9125f
```
```
# create a daemon.json config file
cat << EOF | sudo tee -a /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF

# restart Docker
sudo systemctl restart docker

# check the output to confirm success
sudo docker info | grep Cgroup
```
