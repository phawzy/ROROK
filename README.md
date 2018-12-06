# ROROK

Ruby on Rails on Kubernetes(ROROK) : sample ror app with docker and kube manifests

# Components

  - Rails app
  - Sidekiq
  - redis
  - postgres

# deployment
    
Prerequestes:
  - [Docker], [Docker-Compose] installed (for local)
  - Kubectl configured with Kubernetes cluster (for kubernetes)

For installing Kubernetes cluster on a local vm use [MINIKUBE]

### Kube Directory Components

Dillinger uses a number of open source projects to work properly:

*  Deployments : for rails app and sidekiq and currently for redis and postgres
*  Services : for accessing the deployed services
*  Persistent Volumes and claims : for data in postfres and redis to persist
*  job : for migrating database
*  configmaps and secrets : to store config and sensetive data
*  scripts : to config/start/delete the app stack 


### Installation

##### Docker compose
--------------------
```sh
docker-compose up --build -d
```

##### Kubernetes (minikube)
---------------------------
```sh
minikube start
cd kube
source vars.sh
source up.sh
```

##### New build - Rolling Updates
---------------------------------
```sh
docker build -t <new_image_name>:<tag> .
docker push <new_image_name>:<tag>
kubectl set image deploy/drkiq  drkiq=<new_image_name>:<tag>
kubectl set image deploy/sidekiq  sidekiq=<new_image_name>:<tag>
```

##### Cleanup
-------------
```sh
cd kube
source delete.sh
```


#### Enhancements

* use statefulset for database and redis
* use rediness and liveness probes
* use another namespace 
* add travis build or jenkins pipeline to automate image build/push and deployment
* add memort and cpu requests and limits and more app replicas number
* add more replicas for app and db and use HPA
* use better handling for securing secrets like maybe hashicorp vault

#### Tested Version

* Docker : 18.06.1-ce
* Docker Compose : 1.18.0
* minikube : v0.30.0
* Kubectl : client==v1.12.2 , server==v1.10.0

#### Issues
* Couldn't use podpreset to inject env vars by label selector but cant activate the admission controller plugin >> [issue1]


   [Docker]: <https://docs.docker.com/install/>
   [Docker-Compose]: <https://docs.docker.com/compose/install/>
   [MINIKUBE]: <https://kubernetes.io/docs/setup/minikube>
   [issue1]: <https://github.com/kubernetes/minikube/issues/2353>
