# sace-helm

# Create image Docker

## tag
docker tag docker_sace_saceweb:latest docker.io/edneyego/sace:latest

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
helm upgrade --set ingress.enabled=false --set JAVA_XMX=3096 --set JAVA_XMS=1024 --set ativarAgendamentos=true --set ativarAgendamentos=false  sace ./sace-helm 

### subir com postgres
helm upgrade --set ingress.enabled=false --set postgres.enabled=true  sace ./sace-helm 

## crc maintenance

crc delete -f
crc cleanup & crc setup
crc start --log-level debug




# Instalação Postgres Helm

helm dependency upgrade

helm install postgres \
             --set image.repository=postgres \
             --set image.tag=14.3.3 \
             --set postgresqlDataDir=/data/pgdata \
             --set persistence.mountPath=/data/ \
             stable/postgresql

# Atualizar Helm para novas dependências
helm dependency update