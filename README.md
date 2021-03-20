# chain-node
---
## ENV Install (GKE + Chain Node)
### Use cloud build (recommend)
```
gcloud init
gcloud auth application-default login
gcloud config set project <YOUR_PROJECT_ID>
gcloud config set compute/region <GCP REGION>

cd chain-node

# Create GKE cluster, add one full node
./setup.sh

# Add full node
./add-node.sh
```

### Use terraform to create GKE cluster
```
export PROJECT_ID=<YOUR PROJECT ID>
sed -i'' -e  "s/YOUR_PROJECT_ID/${PROJECT_ID}/g" terraform.tfvars

terraform init
terraform plan -out=terraform.tfplan
terraform apply terraform.tfplan

gcloud container clusters get-credentials $(terraform output kubernetes_cluster_name) --region $(terraform output region)
```
