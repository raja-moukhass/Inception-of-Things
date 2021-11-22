#!/bin/bash

current_ip="192.168.42.111"
server_ip="192.168.42.110"

mkdir ~/.ssh
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 400 ~/.ssh/authorized_keys
chown root:root ~/.ssh/authorized_keys

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://${server_ip}:6443 --token-file /tmp/token --node-ip=${current_ip}" sh -

yum install net-tools -y

mkdir -pv /etc/rancher/k3s
mv /tmp/k3s.yaml /etc/rancher/k3s/k3s.yaml
chmod +r /etc/rancher/k3s/k3s.yaml

echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh
