
## helm
```
helm -n local-path-storage upgrade --install --atomic --timeout 5m local-path-storage oci://ghcr.io/rancher/local-path-provisioner/charts/local-path-provisioner -f values.yaml --version 0.0.32 
```
