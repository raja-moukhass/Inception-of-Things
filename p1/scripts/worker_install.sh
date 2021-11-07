#!/bin/bash

current_ip="192.168.42.111"
server_ip="192.168.42.110"
server_host="login1S"

mkdir ~/.ssh

mv /tmp/id_rsa* ~/.ssh/
chmod 400 ~/.ssh/id_rsa*
chown root:root ~/.ssh/id_rsa*

cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 400 ~/.ssh/authorized_keys
chown root:root ~/.ssh/authorized_keys

echo ${server_ip} ${server_host} >> /etc/hosts

scp -o StrictHostKeyChecking=no root@${server_ip}:/var/lib/rancher/k3s/server/token /tmp/token
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --server https://${server_ip}:6443 --token-file /tmp/token --node-ip=${current_ip}" sh -

yum install net-tools -y

scp root@${server_ip}:/etc/rancher/k3s/k3s.yaml ~/.k3s.yaml

echo "alias k='kubectl'" >> ~/.bash_aliases
echo "source ~/.bash_aliases" >> ~/.bash_profile
echo 'KUBECONFIG="$HOME/.k3s.yaml"'  >> ~/.bash_profile
