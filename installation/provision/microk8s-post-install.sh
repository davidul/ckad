#!/bin/bash

sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

cat > ~/.bash_aliases << EOF
alias kubectl='microk8s kubectl'
EOF