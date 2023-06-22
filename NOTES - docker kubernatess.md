\create spring file

create rest controller

create a docker file

clean build to get .jar file in the target folder with name  
	you gave in the docker file. [ clean package -Pproduction ] in maven build

build docker image [ docker build -t docker-demo . ] 
	here docker-demo is the docker file( the one we created with no extension :)

after creating image, tag it with the DOCKER HUB { docker tag JAR_NAME   CAELUMPIRATA/JAR_NAME }

push it to DOCKER HUB  { docker push caelumpirata/jar_name }

//**
//************PULLING IMAGES FROM THE DOCKER HUB AND RUN*********************//
//**
make sure to delete the same image you created before pulling the same from docker hub

docker run -p 8080:8080 caelumpirata/docker-image  [ first that we will access in browser and the second port is of the uploaded image]
```
docker run -p <custom_port>:8080 caelumpirata/docker-image:tag
```
it will pull the image run it automatically, 


//***************************************************************//
//****************CHECK CONTAINER RUNNNING************//
//***************************************************************//
docker ps
docker history JAR_NAME



//********************************************************//
//*******DOCKER DEFAULT CODE**********************//
//*********************************************************//
FROM openjdk:17

EXPOSE 8080

ADD target/docker-demo.jar docker-demo.jar

ENTRYPOINT ["java", "-jar", "docker-demo.jar"]


//***************************************************************************************************************//
//*******ADD THESE THINGS TO POM.XML TO ADD LAYERS IN SPRING APPLICATION**********************//
//***************************************************************************************************************//

<build>
		<plugins>
			<plugin>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-maven-plugin</artifactId>
				<configuration>************************************************************************************
					<layers>							*****FROM HERE***
						<enabled>true</enabled>				*************
					</layers>							***********
				</configuration>							*******TO***
				<executions> 							************
					<execution>						********
						<goals>						************
							<goal>build-image</goal>			***********
						</goals>						***HERE***
					</execution>						**********
				</executions>***************************************************************************************
			</plugin>
		</plugins>
		<finalName>docker-demo</finalName>**********
	</build>


//***************************************************************************************************************//
//*******DEPLOY ON THE KUBERNATES LOCALLY**********************//
//***************************************************************************************************************//
kubectl get pods
kubectl get deployments
minikube dashboard











