
## helm
```
helm repo add nfs-subdir-external-provisioner https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
helm -n kube-system upgrade --install --wait --rollback-on-failure --timeout 5m nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner -f values.yaml --version 4.0.18
```
