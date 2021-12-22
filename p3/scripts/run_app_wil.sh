IP=`ip route get 8.8.8.8 | awk '{for(i=1; i<NF; i++){if($i=="src"){i++; print $i; exit}}}'`

#CREATE NAMESPACE DEV
sudo kubectl create namespace dev

#LET ARGOCD HANDLE THE DEPLOYMENT FROM GITHUB
sudo curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo chmod +x /usr/local/bin/argocd
sudo /usr/local/bin/argocd login ${IP} --username admin --password $(sudo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d) --insecure
sudo /usr/local/bin/argocd app create wil-app --repo https://github.com/oulhafiane/zoulhafi_k8s_app.git --path manifests --dest-server https://kubernetes.default.svc --dest-namespace dev --sync-policy automated --auto-prune
