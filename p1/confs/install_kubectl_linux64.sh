#!/bin/sh

#Usage : source install_kubectl_linux64.sh
#      : kubectl

master_ip=192.168.42.110

curl -L https://storage.googleapis.com/kubernetes-release/release/v1.22.3/bin/linux/amd64/kubectl -o /tmp/kubectl
chmod +x /tmp/kubectl

scp -o StrictHostKeyChecking=no root@${master_ip}:/etc/rancher/k3s/k3s.yaml /tmp/.k3s.yaml
export KUBECONFIG="/tmp/.k3s.yaml"
alias kubectl="/tmp/kubectl"
