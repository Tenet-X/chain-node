#!/bin/bash -xe
CLUSTER_NAME=cluster3
# read -t 30 -p "Please input GKE cluster name: " CLUSTER_NAME
echo "GKE cluster name: $CLUSTER_NAME"

# read -t 30 -p "Please input chain name: " CHAIN_NAME
# echo "Chain name: $CHAIN_NAME"
CHAIN_NAME=geth
NODE_NAME=node2
# read -t 30 -p "Please input full node name: " NODE_NAME
echo "Full node name: $NODE_NAME"



export CLUSTER_NAME=$CLUSTER_NAME
export NODE_NAME=$NODE_NAME
# export SERVICE="$NODE_NAME-service"

PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
GCP_REGION=$(gcloud config get-value compute/region)
# gcloud container clusters get-credentials ${_CLUSTER_NAME} --region ${_GCP_REGION}
# IP=$(kubectl get service ${SERVICE}--output yaml  | grep 'ip:    ' | sed  "s/- ip:    //g")
gcloud builds submit --config=add-node/cloudbuild.yaml --substitutions=_PROJECT_ID=${PROJECT_ID},_GCP_REGION=${GCP_REGION},_NODE_NAME=${NODE_NAME},_CLUSTER_NAME=${CLUSTER_NAME},_CHAIN_NAME=${CHAIN_NAME}
