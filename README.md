# Docker-Kubernates
------------------------------
Container
----------
			  = Lightweight standalone executable software package
				container packs contains
				(code  + dependencies)
			can be deployed anywhere and is of small size metrics

			it uses namespaces and cgoups

			so we can have independent isolated containers

			(in the background, they are using the same os)

	container == application


Continer-Orchestration
----------------------
		managing containers in large amount

		eg(kubernetes)


***************************************************
we deploy containers in the kuberenetes cluster which is made up of mulple nodes


/************************
node  == physical server/ VM  (each node  has kubelet and docker )

kubernetes cluster == multiple nodes



POD = =  collection of one or more containers (mainly 1 container) (wrapper around a container)

Deployments can have one or more pods

REplicas == 2
	
	 :2 pods based on same specs

Kubernetes decides which of the node  of this is going to deploy the nodes we created in the Deployments


kuberenetes giver storage in the form of PERSISTANT VOLUMES
	data remains in the volumes evern after the pods is not existing


	pod access those volumes via CLAIM ON PERSISTANT VOLUME
		and persistent volume is linked to VOLUME



sidecar is additionl port that statys with the main pod and mainily used while metrics and stuffs



