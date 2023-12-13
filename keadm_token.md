// token to connect edgenode generated in kubesphere  - tried to genrate the same token using java

// "keadm gettoken"

# Steps i created to achieve this
kubeconfig only allows kubectl command (keadm not allowed)

1. create a deployment and run in the kubernetes(this creates a pod with specific name "keadm-token-pod-0" )
2. create a bash command to run in the master node which runs keadm gettoken command (output shows the token)
3. add command to copy the ouput of keadm gettoken command and paste in the root directory of the new created pod
4. as kubectl can access the directory of pod and can see the token.
5. all done for showing the token using java + kubeconfig
6. here is how bash file looks like----- keadm-token.sh
```
#!/bin/bash

while true; do
    TOKEN_LIST=$(keadm gettoken)
    echo "$TOKEN_LIST" > /root/keadm_token.txt
    kubectl cp /root/keadm_token.txt keadm-token-pod-0:/root/keadm_token.txt
    sleep 1  # Sleep for 1 minute
done
```
7. the deployment yaml looks like this(pod will recreate with same name if one dies) -
   kubectl apply -f  keadm-token-pod.yaml

   ```
    apiVersion: apps/v1
    kind: StatefulSet
    metadata:
      name: keadm-token-pod
      namespace: default
    spec:
      replicas: 1
      selector:
        matchLabels:
          app: keadm-token
      serviceName: keadm-token-svc
      template:
        metadata:
          labels:
            app: keadm-token
        spec:
          containers:
          - name: token-container
            image: ubuntu  # Replace with the image you want to use
            command: ["/bin/sleep", "infinity"]
   ```

   > you can get kubeconfig.yaml data from
   ```
   https://kubesphere.io/docs/v3.4/multicluster-management/enable-multicluster/retrieve-kubeconfig/
   ```
   
9. the java code looks like this (the kubeconfig.yaml is in------ /src/main/resouces directory)
 ```
   try {
            // Execute the script inside the pod
            String[] execCommand = {
                "kubectl",
                "--kubeconfig=src/main/resources/kubeconfig.yaml",
                "exec",
                "keadm-token-pod-0", // Replace with the actual pod name
                "--",
                "cat",
                "/root/keadm_token.txt"
            };

            // Create a process builder for executing the command inside the pod
            ProcessBuilder execProcessBuilder = new ProcessBuilder(execCommand);

            // Redirect error stream to output stream
            execProcessBuilder.redirectErrorStream(true);

            // Start the process to execute the command inside the pod
            Process execProcess = execProcessBuilder.start();

            // Read the output from the process
            InputStream inputStream = execProcess.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            String line;
            
            while ((line = reader.readLine()) != null) {
               System.out.println(line);
                keadmtoken = line;
            }

         
        } catch (IOException e) {
            e.printStackTrace();
        }
        System.out.println(keadmtoken);

   ```

# update DEC - 2023 
✅✅✅✅
> what we are doing is

> the `keadm-token.sh` command is running on master node which runs `kubectl gettoken` command and store the token in the root directory of the master node itself.

> it runs at interval of 1 min.

> what is does is, it copies the token to the root directory of the app whose pod in running on kuberntes and that app generates the full edgenode join `one-click-deploy.sh` command.

> the command copies the `token` and add in the one-click-config script  at its appropriate place  
✅✅✅✅✅
---------------------
app which generates edgeconnect command -  deployment.yaml
```

apiVersion: v1
kind: Service
metadata:
  name: test-service
spec:
  selector:
    app: test-app
  ports:
    - protocol: "TCP"
      port: 80
      targetPort: 8080
  type: NodePort

---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: test-app-stateful
spec:
  serviceName: test-service
  replicas: 1
  selector:
    matchLabels:
      app: test-app
  template:
    metadata:
      labels:
        app: test-app
    spec:
      containers:
      - name: test-app-container
        image: <image_name>
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 8080
```
this creates  pod name as `test-app-stateful-0`

## the bash command  - (run this in master node)
```
#!/bin/bash

while true; do
    TOKEN_LIST=$(keadm gettoken)
    echo "$TOKEN_LIST" > /root/keadmToken.txt
    kubectl cp /root/keadmToken.txt test-app-stateful-0:/root/keadm_token.txt
    sleep 1  # Sleep for 1 minute
done
```

## token app updated workaround.
```
	try {
			 // Path to the token file
	        String tokenFilePath = "/root/keadm_token.txt";
	        
	        // Read the token file content
	        keadmtoken = Files.readString(Paths.get(tokenFilePath));
	        
	        // Use the token as needed
	        System.out.println("keadm token:" + keadmtoken);
	        
	        // Further processing with the token...
	    } catch (IOException e) {
	        e.printStackTrace();
	    }
        System.out.println("keadm token ------" + keadmtoken);
```

## Dockerfile 
```
FROM openjdk:17 as builder
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} bash.jar
RUN java -Djarmode=layertools -jar bash.jar extract

FROM openjdk:17
COPY --from=builder dependencies/ ./
COPY --from=builder snapshot-dependencies/ ./
COPY --from=builder spring-boot-loader/ ./
COPY --from=builder application/ ./
EXPOSE 8080
ENTRYPOINT ["java", "org.springframework.boot.loader.JarLauncher"]
```
