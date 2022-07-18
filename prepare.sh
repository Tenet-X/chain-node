docker pull blockchainetl/ethereum-etl:2
docker tag blockchainetl/ethereum-etl:2 gcr.io/${PROJECT_ID}/etl
docker push gcr.io/${PROJECT_ID}/etl
kubectl create secret generic pubsub-key --from-file=key.json=/path-to-your-key-file/