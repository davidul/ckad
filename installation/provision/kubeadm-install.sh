#!/bin/bash

sudo apt-get update
sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
#kubeadm join 10.0.2.15:6443 --token rdd83j.sw5zkoggxscf29nz \
#   --discovery-token-ca-cert-hash sha256:5af1deea6ea1068a79bef60b3d66603acd3c56f609c4c7a5f295fbd84532b1fb