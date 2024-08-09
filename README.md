# DevOpsAssignment

# Building and Pushing a Docker Image to a Container Registry

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
minikube start --cpus=4 --memory=4096mb
kubectl apply -f mongodb-statefulset.yaml
kubectl apply -f flask-deployment.yaml
kubectl apply -f flask-hpa.yaml
```
