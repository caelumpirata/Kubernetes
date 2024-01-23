

1. Specify a Port in Your Spring Boot Application:
   In your Spring Boot application, you can specify the port by adding the following property in your `application.properties` or application.yml file:
```
server.port=8081
```
  This way, you explicitly set the port to 8081 instead of relying on the default 8080.

2. Update Dockerfile:
  Make sure to expose the correct port in your Dockerfile. In your case, you've mentioned that you want to use port 8081, so the EXPOSE directive should reflect that:

  Dockerfile
```
EXPOSE 8081
```
  Also, make sure that your ENTRYPOINT or CMD in the Dockerfile is correctly set up to run your Spring Boot application.
