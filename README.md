# GKE + chain-node + ETL
---
A universal chain node on GKE & data collection & analytics solution on GCP!



## Quickstart

### 1 Initialize your project
```
gcloud init 
gcloud auth application-default login
```
Follow the guide to set up your project id and region. Information needed will be required in the following step.
We recommend uploading the service account key to manage your project. Please refer to this page for more information https://cloud.google.com/iam/docs/creating-managing-service-account-keys 

### 2 Create secret
```
kubectl create secret generic pubsub-key --from-file=key.json=/path/to/your/key/file/
```
Create secret file which will be needed when creating pub/sub topic.

### 3 One-shot set up
```
./setup-demo.sh
```
Once setup, you can run the following command to see the masage published by Pub/Sub.
```
python3 subscribe.py
```
You may need to set the default credential file as follows if you encounter google.auth.exceptions.DefaultCredentialsError.
```
export GOOGLE_APPLICATION_CREDENTIALS='/path/to/your/key/file/‘
```

Or you can run
```
kubectl get pods
kubectl logs $pod_id
```
to make sure the full node and etl node are running smooothly.

## Get Started
For detailed information and additional functions of this project.

### Add  full node
If you want to add a new full node to current cluster, please run the following command.
```
./add-node.sh
```
The cluster name and the node name is by default cluster1 and node1 respectively.
If you want to customize the settings of Ethereum nodes. 
You can visit [Go Ethereum](https://github.com/ethereum/go-ethereum) for more information. For example, you can change the [syncmode](https://github.com/Tenet-X/chain-node/blob/eth/chain/geth/deployment.yaml) to "snap"  to set up an Ethereum node more quickly.

This script will first create a persistent volumn claim and then apply the deployment.

### Add etl node
If you want to add a node that can listen to the full node and publish information using Pub/Sub, please run the following command.
```
./add-etl.sh
```
For detailed information about Ethereum-etl, please refer to https://github.com/Tenet-X/ethereum-etl


etl/cloudbuild.yaml will first create a Pub/Sub topic and then apply the deployment.yaml. The secret file created beforehand will be used in this cloudbuild.file.
Please refer to this page https://cloud.google.com/kubernetes-engine/docs/samples/container-pubsub-secret-deployment

For more information of Pub/Sub deployment with credentials, please visit https://cloud.google.com/kubernetes-engine/docs/samples/container-pubsub-secret-deployment



### Create snapshot
If you want to create snapshot for the full node, please set the node name and the cluster name and run the following command.
```
./snapshot.sh
```
For detailed information about creating snapshot, please refer to https://cloud.google.com/kubernetes-engine/docs/how-to/persistent-volumes/volume-snapshots?hl=zh-cn#v1beta1
### Restore from snapshot
Once you have snapshot created, please set the snapshot name, node name and the cluster name and run the following command.
```
./restore-from-snapshot.sh
```
### Create Scheduled snashot
If you run your node in Google Cloud, you can attach a [snapshot schedule](https://cloud.google.com/compute/docs/disks/scheduled-snapshots#attach_snapshot_schedule) to it.


