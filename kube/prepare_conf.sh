export ENCODED_USERNAME=`echo -n $USERNAME | base64 -w 0`
export ENCODED_PASSWORD=`echo -n $PASSWORD | base64 -w 0`
export ENCODED_TOKEN=`echo -n $TOKEN | base64 -w 0`
export ENCODED_DATABASE_URL=$(printf "%s" "postgresql://${USERNAME}:${PASSWORD}@postgres:5432/drkiq?encoding=utf8&pool=5&timeout=5000" | base64 -w 0)
envsubst '${ENCODED_USERNAME} ${ENCODED_PASSWORD} ${ENCODED_TOKEN} ${ENCODED_DATABASE_URL}' < drkiq-secret.yaml.template > drkiq-secret.yaml

kubectl create -f pvc/
kubectl create -f svc/
kubectl create -f deploy/
kubectl create -f jobs/
kubectl create -f drkiq-configmap.yaml
kubectl create -f drkiq-secret.yaml