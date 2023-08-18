// token to connect edgenode generated in kubesphere  - tried to genrate the same token using java

// "keadm gettoken"

# Steps i created to achieve this
kubeconfig only allows kubectl command (keadm not allowed)

1. create a pod and run in the kubernetes blank one.
2. create a bash command to run in the master node which runs keadm gettoken command (output shows the token)
3. add command to copy the ouput of keadm gettoken command and paste in the root directory of the new created pod
4. as kubectl can access the directory of pod and can see the token.
5. all done for showing the token using java + kubeconfig
6. nano keadm-token.sh
```
#!/bin/bash

while true; do
    TOKEN_LIST=$(keadm gettoken)
    echo "$TOKEN_LIST" > /root/keadm_token.txt
    kubectl cp /root/keadm_token.txt keadm-token-pod:/root/keadm_token.txt
    sleep 1  # Sleep for 1 minute
done
```
7. the pod yaml looks like this
   ```
    apiVersion: v1
    kind: Pod
    metadata:
      name: keadm-token-pod
      namespace: default
    spec:
      containers:
      - name: token-container
        image: ubuntu  # Replace with the image you want to use
        command:
          - "/bin/sleep"
        args:
          - "infinity"

   ```
8. the java code looks like this (the kubeconfig.yaml is in------ /src/main/resouces directory)
 ```
   try {
            // Execute the script inside the pod
            String[] execCommand = {
                "kubectl",
                "--kubeconfig=src/main/resources/kubeconfig.yaml",
                "exec",
                "keadm-token-pod", // Replace with the actual pod name
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
