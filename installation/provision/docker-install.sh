#!/bin/bash

DEBIAN_FRONTEND=noninteractive sudo apt-get update -qq

DEBIAN_FRONTEND=noninteractive sudo apt-get install -y -qq apt-transport-https ca-certificates curl software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

sudo add-apt-repository "deb https://download.docker.com/linux/$(. /etc/os-release; echo "$ID") $(lsb_release -cs) stable"

sudo apt-get update

sudo apt-get install -y -qq docker-ce docker-ce-cli containerd.io