# Simple Frontend-Backend App to Deploy to Kubernetes

This guide will walk you through deploying a simple frontend-backend application to a Kubernetes cluster using Minikube. The application consists of a backend service (FastAPI) and a frontend service (Streamlit). 

## Prerequisites

- **Minikube**: A tool that makes it easy to run Kubernetes locally.
- **Docker**: For building container images.
- **Kubectl**: The command-line tool for interacting with Kubernetes.
- **Docker Hub**: (Optional) For pushing and pulling Docker images. 

## Setup

### 1. Install Minikube, Docker, and Kubectl

Ensure that Minikube, Docker, and Kubectl are installed on your local machine. Follow the [official installation instructions for Minikube](https://minikube.sigs.k8s.io/docs/start/), [Docker](https://docs.docker.com/get-docker/), and [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) if they are not already installed.

### 2. Start Minikube

Start Minikube to create a local Kubernetes cluster:

```
minikube start
```

### 3. Build Docker Images
You need to build Docker images for both the FastAPI backend and the Streamlit frontend. Make sure you have Dockerfiles for both services.

Build Backend Image
Navigate to the directory containing the Dockerfile for the FastAPI backend and run:



```
docker build -t <your-dockerhub-username>/fastapi-backend:latest .
```

Build Frontend Image
Navigate to the directory containing the Dockerfile for the Streamlit frontend and run:
```
docker build -t <your-dockerhub-username>/streamlit-frontend:latest .
```

4. Push Docker Images to Docker Hub
Login to Docker Hub (if not already logged in):

```
docker login
```

Push the backend image:
```
docker push <your-dockerhub-username>/fastapi-backend:latest
```

Push the frontend image:
```
docker push <your-dockerhub-username>/streamlit-frontend:latest
```

### 5. Apply Kubernetes Deployments
Now that your Docker images are pushed to Docker Hub, you need to apply the Kubernetes deployments for both services.

Deploy FastAPI Backend
Apply the FastAPI deployment configuration:

```
kubectl apply -f deployment/fastapi-deployment.yml
```

Deploy Streamlit Frontend
Apply the Streamlit deployment configuration:

```
kubectl apply -f deployment/streamlit-deployment.yml
```

### 6. Expose Services
Expose the services to access them from your local machine. You can use kubectl port-forward or create a Service of type LoadBalancer or NodePort in your Kubernetes configuration.

```
kubectl port-forward service/fastapi-backend 8000:80
```
Port-Forward for Streamlit Frontend
```
kubectl port-forward service/streamlit-frontend 8501:80
```

### 7. Access Your Application
Once the services are exposed, you can access them using:

- FastAPI Backend: Open http://localhost:8000 in your web browser.
- Streamlit Frontend: Open http://localhost:8501 in your web browser.
----

### 8. Clean Up
When you are done with your local Kubernetes cluster, you can stop Minikube:

```
minikube stop
```
To delete the Minikube cluster entirely, use:

```
minikube delete
```
----
##  Troubleshooting
- Images Not Found: Ensure that the image names and tags are correct and that they have been pushed to Docker Hub.
- Deployment Issues: Check logs and events using kubectl logs <pod-name> and kubectl describe pod <pod-name>.
- Service Not Accessible: Verify that the services are correctly exposed and that the port-forwarding commands are running.

----
# next steps 
[ ] https  TLs termination there are https loadbalancer or ingress
[ ] authentification Oauth
[ ] network policy 
[ ] resource limits
[ ] add scaling 
[ ] load testing
[ ] ingress controller ? 
[ ] Add monitoring (log what the user is sending), maybe push to bigquery 
[ ] add backup and recovery
[ ] add readiness/livenes probes 
[ ] you need to create a DNS (record that maps domaon to external ip address)

