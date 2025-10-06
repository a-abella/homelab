
## helm
```
helm -n kube-system upgrade --install --atomic --timeout 5m nfs-provisioner nfs-subdir-external-provisioner/nfs-subdir-external-provisioner -f values.yaml --version 4.0.18
```
