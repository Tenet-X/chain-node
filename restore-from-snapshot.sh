#!/bin/bash -xe
CLUSTER_NAME=cluster1
# read -t 30 -p "Please input GKE cluster name: " CLUSTER_NAME
echo "GKE cluster name: $CLUSTER_NAME"

# read -t 30 -p "Please input chain name: " CHAIN_NAME
# echo "Chain name: $CHAIN_NAME"
CHAIN_NAME=geth
NODE_NAME=node1
SNAPSHOT_NAME=snapshot.09-20-2022
# read -t 30 -p "Please input full node name: " NODE_NAME
echo "Full node name: $NODE_NAME"

PROJECT_ID=$(gcloud config get-value project)
PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
GCP_REGION=$(gcloud config get-value compute/region)


gcloud builds submit --config=add-node-snap/cloudbuild.yaml --substitutions=_PROJECT_ID=${PROJECT_ID},_GCP_REGION=${GCP_REGION},_NODE_NAME=${NODE_NAME},_CLUSTER_NAME=${CLUSTER_NAME},_SNAPSHOT_NAME=${SNAPSHOT_NAME}