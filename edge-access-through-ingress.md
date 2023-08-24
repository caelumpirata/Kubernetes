add annotation in ingress file like this
![image](https://github.com/caelumpirata/Kubernetes/assets/85424262/3dbd0067-27de-4bd7-aab7-54ae4a902138)


i enabled it 
----------------------
use the service_name + nodeport shown here in ingress file.
<img width="1080" alt="image" src="https://github.com/caelumpirata/Kubernetes/assets/85424262/b6cd45cc-c393-4adc-b22b-a43cc1fbd061">


when using clusterIP, ingress looks for private_ip + service_port(9090) to access the service

but 

when using the service_name + nodeport_port, it goes for 10.233.13.40:31963  (this one worked for me 😁) 
the same is accessible through master node too(curl ......)
master node ufw was disabled🥱but after disabliing it is accessible too




