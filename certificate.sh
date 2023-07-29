
#!/bin/bash

echo "hello there"

# installing docker
sudo apt install docker.io

echo "-----------------docker installation completed-----------------------"



# adding ssh pub key to .ssh/authorizedkeys
ssh_pub_key_code="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCznOGkGVDBbnM3NQHyikSuOHaD5dRBrXDQyrLv23SaWEbiHbeN5AV3SeX2eFI/EaIpjuWseXBCSmmPXEi6ZNAPDG0ZVbXkxdvyIhbKMt1IYfAvmu3GcKugoM>
"
echo "$ssh_pub_key_code" > ~/.ssh/authorized_keys



# id_rsa key to let the cluster access the instance whenever needed
ssh_pvt_key_code="
-----BEGIN OPENSSH PRIVATE KEY-----
b3BlbnNzaC1rZXktdjEAAAAABG5vbmUAAAAEbm9uZQAAAAAAAAABAAABlwAAAAdzc2gtcn
NhAAAAAwEAAQAAAYEAs5zhpBlQwW5zNzUB8opErjh2g+XUQa1w0Mqy79t0mlhG4h23jeQF
d0nl9nhSPxGiKY7lrHlwQkppj1xIumTQDwxtGVW15MXb8iIWyjLdSGHwL5rtxnCroKDJpX
+vSGxf588Q0bYkb10Pac31X9ydD6JxHz0wl2xcaexnMTkvzmpudgJhOZ2Lj4nf8+w78xH9
81hfZevdH9TDrnd+O5luHDGdnHjHKVC31cgFvhHMIyUx/mltdSnqROE97Xc0n8rN5zS92l
e6DRjrHPTJ3+tZVUpLKgrANEwossXOAEGlhLSBfiDYnoiOoXZTOIAI5wWvGjELOOI/NH3B
qCpd8tLMWK7WM6CqhBBsGOzmRZNltWH9R3rAxaO+FeuuuOtkutmXWVFYoTCgfNt/FaAfR2
dOD9/OPa3XOT+/ncX+WbFk5k/7MyDhIp53C+6/RUgC1DnLtIiYjUTvQ3il29PYNHjdHHqZ
NZvcdUM7dlCLz4nNWdaAeb2aWgJkoW0xxvqkbbD3AAAFkMZ6dj/GenY/AAAAB3NzaC1yc2
EAAAGBALOc4aQZUMFuczc1AfKKRK44doPl1EGtcNDKsu/bdJpYRuIdt43kBXdJ5fZ4Uj8R
oimO5ax5cEJKaY9cSLpk0A8MbRlVteTF2/IiFsoy3Uhh8C+a7cZwq6CgyaV/r0hsX+fPEN
G2JG9dD2nN9V/cnQ+icR89MJdsXGnsZzE5L85qbnYCYTmdi4+J3/PsO/MR/fNYX2Xr3R/U
w653fjuZbhwxnZx4xylQt9XIBb4RzCMlMf5pbXUp6kThPe13NJ/Kzec0vdpXug0Y6xz0yd
/rWVVKSyoKwDRMKLLFzgBBpYS0gX4g2J6IjqF2UziACOcFrxoxCzjiPzR9wagqXfLSzFiu
1jOgqoQQbBjs5kWTZbVh/Ud6wMWjvhXrrrjrZLrZl1lRWKEwoHzbfxWgH0dnTg/fzj2t1z
k/v53F/lmxZOZP+zMg4SKedwvuv0VIAtQ5y7SImI1E70N4pdvT2DR43Rx6mTWb3HVDO3ZQ
i8+JzVnWgHm9mloCZKFtMcb6pG2w9wAAAAMBAAEAAAGBAJ9uSQf9hKY+YT0G61ScETzIV8
Ladh9aUgKzekPYe9cpNrotgKoNViC90seFpBPhlhznf80p+lCNdsfPNatmIxzIfer4Hr4U
Nxjl027l2XAPp0DKd/cmOeIZ9wPVpARYVoUQUzCjShIj+7OCIyVVUYD4QwtkqEYw5JMNSc
fyqBHEfYp4sE6RHrlpvAXrkoc/WDjyH7P7uksv9AZggQdsOMYD8JBc0QRGZvf3VcmSSK6F
rKvUb1mJvC4p9Wtc3bRdMgvdOtgJo9fV1XhamgrtV9kyX6KO1r33xYcbilTho5w4ZEkBuW
YUp6xZjhyA5Z56Vr5dV1hiMPizOJpryMeKZsip/RuFKwnMVZIi+dJJ2UJZ3WcN6dxM5hDR
oAS8eclpnNGsZ3AyvYM+jNN5iw169Z2NYzieseyTEs1r0nyxg/8Q0XJH5HOj2FPHPu0Jda
ZgJQyGiwbaRxv5kv3dY/ESJSDDnPqU1Z4pTrDCL7dcFf57fP8azp0JUTFpPCjT2BXt8QAA
AMEAo/iLlutHGBfDA3eIQO1QpBtZ+ii7mjVTH79hYxiLuE/4fhhezZimQRf0LXIqv6r9VQ
7gwckx/lfUMffjaDNRRKi65cb9sg80+JrOHPKpkae4Va+YMYgo60Av9odYNHP5mOcZX6Qi
dLbugTGj5ry2O8y6v6AvMmhjaT33SUOdslt88CB0LuTPFStfWV/9y6A4HR9UMI32SNMdOy
L6HlgvDgplhfIwH1vIil2KDhw/PZvAKF2GwYSxPePgsFhRKd4RAAAAwQDpLZDBBYwGqDP2
k+evp/0cDdLlt7X7dqAj5hJSpPY9wvzieLkNvpW0qbvpNSv+TEwSJvXqDKIcPBSIGfHSTI
XhRsQh4Ah7wd8hiu0VY3PngLvjugiuYc40EZCsV5E59ZVcIX5mHJj1+ZPhu6Mmdx+sKFqB
fwprnr7cT3SoPIqb6CU6Mfw9CkMGVNp8rmPvLu1CEXULvolg+mdLITv9tUY9ikKcpJXxVG
hbd+7ETh76kn3fuCetdZBi0wlKzDVuHB8AAADBAMUxNC2sBjpTWTMCD4WZYq5vDUK1Df6F
5HLvDweDbnXXYVW+SITgSOp4YLt++Z8tDrGlJpuxsZ/U2dDLESVvUwjRmp6rXvClr8cnRM
gfK9N9fk72cVzFhQ/KvN4bzxOvtG9O9dVgxz8UuEGOEjD5ZDG4ens1E86LVRjCvp9Eu5bL
D1AJ2pILTZHEx4x42azVaYOZVpdwYJFPn7ZhAU3T2VNi0X+dT84g5ERl1Upx91msuNAkPH
sB+UyiT2C+Qs7QKQAAABJjYWVsdUBjYWVsdW1waXJhdGEBAgMEBQYH
-----END OPENSSH PRIVATE KEY-----
"

# create .ssh directory, if not present
mkdir -p ~/.ssh



# Write the SSH key to the id_rsa file
echo "$ssh_pvt_key_code" > ~/.ssh/id_rsa
sudo chmod 400 .ssh/id_rsa
 echo "------------------id_rsa configuration done successfully---------------------"


# Connect EdgeNode
arch=$(uname -m); if [[ $arch != x86_64 ]]; then arch='arm64'; fi;  curl -LO https://kubeedge.pek3b.qingstor.com/bin/v1.9.2/$arch/keadm-v1.9.2-linux-$arch.tar.gz  && tar xvf keadm-v1.9.2-linux-$arch.tar.gz && chmod +x keadm && ./keadm join --kubeedge-version=1.9.2 --region=zh --cloudcore-ipport=65.20.81.24:30000 --quicport 30001 --certport 30002 --tunnelport 30004 --edgenode-name edgenode-ubuntu --edgenode-ip 192.168.0.138 --token 5a6827a758e00bcd7771335dde3f1aeec44ddbf639461b7c4dd3e76e32d75ed7.eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTA2NzQzODl9.h4dX3YTA9dBihc5o-B8ynk7r7-oUANTyp79EFFWA4AA --with-edge-taint"
echo "Edgenode Connection Done......................................................................................."

echo "starting edgecore.yaml configuration..."
sed -i '/^ *edgeStream:/,/^[[:space:]]*server:/ s/^\( *enable: \).*/\1true/' /etc/kubeedge/config/edgecore.yaml
sed -i 's/^\( *server: [0-9.]*\):10004/\1:30004/' /etc/kubeedge/config/edgecore.yaml
sed -i '/^ *metaManager:/,/^[[:space:]]*podStatusSyncInterval:/ s/^\( *enable: \).*/\1true/' /etc/kubeedge/config/edgecore.yaml
sed -E -i 's/^( *clusterDNS: ).*/\1"169.254.96.16"/; s/^( *clusterDomain: ).*/\1"cluster.local"/' /etc/kubeedge/config/edgecore.yaml
echo"edgecore.yaml config done...................................."

systemctl restart edgecore.service

echo "edgecore restart done........................................."

curl 127.0.0.1:10550/api/v1/services