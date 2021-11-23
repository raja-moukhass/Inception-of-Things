#CREATE NAMESPACE DEV
sudo kubectl create namespace dev

#LET ARGOCD HANDLE THE DEPLOYMENT FROM GITHUB
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
sudo /usr/local/bin/argocd login "10.11.100.117:443" --username admin --password $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
sudo /usr/local/bin/argocd app create wil-app --repo https://github.com/oulhafiane/k8s_app.git --path manifests --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy automated --auto-prune
