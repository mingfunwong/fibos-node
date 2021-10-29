# install k3s
curl -sfL https://get.k3s.io | sh -
# install helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
# setup helm
mkdir ~/.kube
sudo kubectl config view --raw >~/.kube/config
# add helm repo
helm repo add mingfunwong https://mingfunwong.github.io/helm-charts

# name
NAME=fibos-node-1
# enable block producers
PRODUCER_ENABLE=false
# block producer information
PRODUCER_NAME=
PUBLIC_KEY=
PRIVATE_KEY=
# enable the producer api
PRODUCER_API_ENABLE=false
# use a snapshot
SNAPSHOT_ENABLE=true
# snapshot url
SNAPSHOT_URL=https://github.com/andy-backup/fibos/raw/master/snapshot.bin
# enable provide
HTTP_ENABLE=false
P2P_ENABLE=false
# provide information
HTTP_HOST=
P2P_PORT=

# install fibos-node
helm install $NAME mingfunwong/fibos-node \
  --set PRODUCER_ENABLE=$PRODUCER_ENABLE\
  --set PRODUCER_NAME=$PRODUCER_NAME\
  --set PUBLIC_KEY=$PUBLIC_KEY\
  --set PRIVATE_KEY=$PRIVATE_KEY\
  --set PRODUCER_API_ENABLE=$PRODUCER_API_ENABLE\
  --set SNAPSHOT_ENABLE=$SNAPSHOT_ENABLE\
  --set SNAPSHOT_URL=$SNAPSHOT_URL 
