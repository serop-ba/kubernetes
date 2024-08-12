echo 'authenticating with docker in gcp'
gcloud auth configure-docker europe-west1-docker.pkg.dev

gcloud services enable cloudbuild.googleapis.com
gcloud services enable containerregistry.googleapis.com
# For Artifact Registry:
gcloud services enable artifactregistry.googleapis.com



# have the docker images built already 
echo 'building docker'
cd ./src/api
# docker build -t sepo96/kubernetes_test:fastapi_new .
gcloud builds submit --region=europe-west1 --tag europe-west1-docker.pkg.dev/medical-rag-432009/kubernetes-test/fastapi_new

cd ../frontend
# docker build -t sepo96/kubernetes_test:streamlit_new .
gcloud builds submit --region=europe-west1 --tag europe-west1-docker.pkg.dev/medical-rag-432009/kubernetes-test/streamlit_new


# create a cluster with the name autopilot-cluster in europe-west1
echo "getting cluser credentials"
gcloud container clusters get-credentials  autopilot-cluster-1 --region europe-west1

echo 'deploying to cluster'
cd ../../
kubectl create namespace kubernetes-test 
kubectl apply -f deployment-gcp/fastapi-deployment.yml
kubectl apply -f deployment-gcp/streamlit-deployment.yml


# add cpu limits 
# learn about load testing, benchmarking, kubernets metrics servers, prometheus and grafana