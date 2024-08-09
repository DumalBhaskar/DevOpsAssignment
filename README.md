# DevOpsAssignment

#3 Building and Pushing a Docker Image to a Container Registry

This guide will walk you through the process of building a Docker image for your Flask application and pushing it to a container registry.

## Prerequisites

- **Docker** installed on your machine.
- An account on a container registry.
- A Flask application with a `Dockerfile` in the root directory.

```bash
docker build -t <username>/flask-app:latest .
docker tag <image-id> <username>/flask-app:<tag>
docker login
docker push <username>/flask-app:latest
```

# Deploying a Flask Application with MongoDB on Minikube

This guide will walk you through deploying a Flask application and MongoDB on a Minikube Kubernetes cluster.

## Prerequisites

- **Minikube** installed on your machine.
- **kubectl** installed and configured to use with Minikube.
- **Docker** installed and configured to work with Minikube.

## Step 1: Set Up Minikube

Start Minikube with sufficient resources:

```bash
minikube start
kubectl apply -f mongodb-statefulset.yaml
kubectl apply -f flask-deployment.yaml
kubectl apply -f flask-hpa.yaml
```
## DNS resolution within the Kubernetes cluster for inter-pod communication.

When a pod within the cluster tries to connect to another service using its service name, it sends a DNS query to CoreDNS.
CoreDNS resolves this query to the cluster IP of the service, which is a stable IP address used to route traffic to one of the service's endpoints (pods).

## Resource Management: Requests and Limits
Resource requests and limits help manage resource allocation and ensure stability:
Requests are the minimum resources guaranteed for a pod.
Limits are the maximum resources a pod can use.

## Design Choices and Configurations
In the design and deployment of the Python Flask application with MongoDB on Kubernetes, several specific configurations and setups were chosen to meet the requirements efficiently. 
