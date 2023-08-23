use the service_name + nodeport shown here in ingress file.
<img width="1080" alt="image" src="https://github.com/caelumpirata/Kubernetes/assets/85424262/b6cd45cc-c393-4adc-b22b-a43cc1fbd061">


when using clusterIP, ingress looks for private_ip + service_port(9090) to access the service

but 

when using the service_name + nodeport_port, it goes for 10.233.13.40:31963  (this one worked for me 😁) 
