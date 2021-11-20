#INSTALL DOCKER-CE IN UBUNTU
#https://docs.docker.com/engine/install/ubuntu/

sudo apt-get update
sudo apt-get install \
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

#INSTALL K3D and Create cluster of one node
#https://k3d.io/v5.1.0/

sudo wget -q -O - https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
sudo k3d cluster create mycluster

#INSTALL ARGO CD
sudo kubectl create namespace argocd
sudo kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

#EXPOSE IP OF ARGOCD
sudo kubectl port-forward --address 0.0.0.0 svc/argocd-server -n argocd 8080:443 & >> argocd_logs.tmp

#GET PASSWORD OF ADMIN
sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

#CREATE NAMESPACE DEV
sudo kubectl create namespace dev

#LET ARGOCD HANDLE THE DEPLOYMENT FROM GITHUB
sudo kubectl apply -f namespace argocd my_app.yaml
 
#EXPOSE IP OF APP DEPLOYED
sudo kubectl port-forward --address 0.0.0.0 svc/app-wil -n dev 8888:8888 & >> dev_logs.tmp
