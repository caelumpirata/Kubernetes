Setup Kasten in Worker NOde
--------------------------------

Create a New Namespace named (kasten-io)
```
kubectl create ns kasten-io
```

install KASTEN in our new namespace (kasten-io) with chart name (k10) usingg following command
```
helm install k10 kasten/k10 --namespace=kasten-io
```
```

Step 3: Add profile after kasten dashboard opens.

Step 4: Create a Policy to backup the current Application

Step 5: After the backup is complete, Export the application Namespace and copy the link to the clipboard

Step 6: In the application in which you want to inport the namespace/application, install kasten in this kluster too using step:1 

Step 7: Create a new Policy, and Choose IMPORT in action tab this time. (tick restore after import)

Step 8: After Policy is created, run the Policy onCe and wait for the application to get restore in your kluster.


```

