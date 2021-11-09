#!/bin/bash

current_ip="192.168.42.110"

mkdir ~/.ssh
cat /tmp/id_rsa.pub >> ~/.ssh/authorized_keys
chmod 400 ~/.ssh/authorized_keys
chown root:root ~/.ssh/authorized_keys

curl --insecure https://releases.rancher.com/install-docker/20.10.sh | sh

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --cluster-init --tls-san $(hostname) --bind-address=${current_ip} --advertise-address=${current_ip} --node-ip=${current_ip}" sh -s - --docker

yum install net-tools -y

chmod +r /etc/rancher/k3s/k3s.yaml
echo "alias k='kubectl'" >> /etc/profile.d/00-aliases.sh

##PODS##
cat /tmp/app1.yaml >> ~/.app1.yaml

sleep 30
/usr/local/bin/kubectl create -f ~/.app1.yaml
