# Tested in VUltr instance
## make sure that the DNS(example.com) is attached to vultr
Step 1 - Create new instance.

Step 2 - apt update

Step 3 - open http, https
```
ufw allow http
```
```
ufw allow https
```
![image](https://github.com/caelumpirata/Kubernetes/assets/85424262/4bff4e9f-09ff-4be5-9acc-8810cfdfd17d)

---------------------
and follow this 👇

```
https://www.nginx.com/blog/using-free-ssltls-certificates-from-lets-encrypt-with-nginx/
```

# Troubleshoot
nginx: [error] invalid PID number "" in "/run/nginx.pid"
```
https://stackoverflow.com/questions/36176255/error-invalid-pid-number-in-run-nginx-pid
```

```
https://community.letsencrypt.org/t/nginx-invalid-pid-number-error-during-certbot-renew/85405/7
```
```
sudo service nginx stop
sudo rm /run/nginx.pid
sudo service nginx start
```


