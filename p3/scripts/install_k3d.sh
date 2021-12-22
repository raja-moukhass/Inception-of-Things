#!/bin/bash

#INSTALL DOCKER-CE IN UBUNTU
#https://docs.docker.com/engine/install/ubuntu/

if [ "$1" = "password" ];
	then
		sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
		echo ""
		exit
fi

sudo apt-get update
sudo apt-get install -y \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io

#INSTALL KUBECTL

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
alias k="sudo /usr/local/bin/kubectl"

#INSTALL K3D and Create cluster of one node
#https://k3d.io/v5.1.0/

sudo wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
sudo k3d cluster create mycluster -p "443:443@loadbalancer" -p "8888:8888@loadbalancer" --k3s-arg "--disable=traefik@server:0"

#INSTALL ARGO CD
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sudo kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
