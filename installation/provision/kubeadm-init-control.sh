#!/bin/bash

sudo kubeadm init --apiserver-advertise-address=$1 --control-plane-endpoint=$1

#sudo kubeadm init --apiserver-advertise-address=192.168.50.11 --control-plane-endpoint=192.168.50.11 --pod-network-cidr=192.168.50.11/24

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl apply -f "https://cloud.weave.works/k8s/net?k8s-version=$(kubectl version | base64 | tr -d '\n')"
