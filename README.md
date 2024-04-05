# sace-helm

# Create image Docker

## tag
docker tag docker-sace-saceweb:latest docker.io/edneyego/sace:latest

## login
docker login

## Push
docker push docker.io/edneyego/sace:latest


# create Heml
helm create sace

# Check Helm
helm install --dry-run --debug  sace ./sace-helm

# Helm deploy 
helm install --set ingress.enabled=false  sace ./sace-helm