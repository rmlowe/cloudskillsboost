gcloud container clusters create nucleus-cluster-1 --zone=us-east1-b
gcloud container clusters get-credentials nucleus-cluster-1 --zone=us-east1-b
kubectl create deployment nucleus-deploy-1 \
    --image=gcr.io/google-samples/hello-app:2.0
kubectl expose deployment nucleus-deploy-1 --type=LoadBalancer \
    --port=$APP_PORT_NUMBER
