#!/bin/bash -xe
read -t 30 -p "Please input GKE cluster name: " CLUSTER_NAME
echo "GKE cluster name: $CLUSTER_NAME"

read -t 30 -p "Please input chain name: " CHAIN_NAME
echo "Chain name: $CHAIN_NAME"

read -t 30 -p "Please input full node name: " NODE_NAME
echo "Full node name: $NODE_NAME"

export CLUSTER_NAME=$CLUSTER_NAME
export NODE_NAME=$NODE_NAME

PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
GCP_REGION=$(gcloud config get-value compute/region)

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
     --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/iam.serviceAccountTokenCreator

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/container.clusterAdmin

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/container.admin

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/compute.admin

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding ${PROJECT_ID} \
    --member=serviceAccount:${PROJECT_NUMBER}@cloudbuild.gserviceaccount.com \
     --role roles/compute.storageAdmin

gcloud builds submit --config=./cloudbuild-eth.yaml --substitutions=_PROJECT_ID=${PROJECT_ID},_GCP_REGION=${GCP_REGION},_NODE_NAME=${NODE_NAME},_CLUSTER_NAME=${CLUSTER_NAME},_CHAIN_NAME=${CHAIN_NAME}
