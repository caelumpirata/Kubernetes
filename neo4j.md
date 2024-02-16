Failed to read config: Unrecognized setting. No declared setting with name: PORT.7687.TCP.PORT. Cleanup the config or disable 'server.config.strict_validation.enabled' to continue. Run with '--verbose' for a more detailed error message.
```
https://stackoverflow.com/questions/76207890/neo4j-docker-compose-to-kubernetes
```
* pass the env-var `NEO4J_server_config_strict__validation_enabled=false` to stop these strict checks (as mentioned in the error message)
```
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: neo4j-statefulset
spec:
  serviceName: "neo4j-svc"
  replicas: 1
  selector:
    matchLabels:
      app: neo4j-app
  template:
    metadata:
      labels:
        app: neo4j-app
    spec:
      containers:
      - name: neo4j-app
        image: neo4j:5.12.0
        ports:
        - containerPort: 7474
          name: http
        - containerPort: 7687
          name: bolt
        env:
        - name: NEO4J_AUTH
          value: "neo4j/Password@123"  # Change 'your_password' to your desired password
        - name: NEO4J_server_config_strict__validation_enabled
          value: "false"
        volumeMounts:
        - name: neo4j-data
          mountPath: /data
      volumes:
      - name: neo4j-data
        persistentVolumeClaim:
          claimName: neo4j-pvc

```
