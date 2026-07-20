# metallb

VIP failover load balancing for bare metal Kubernetes clusters.

Also used for the external kube-api service to provide a static IP for kubectl access.

```
helm repo add metallb https://metallb.github.io/metallb
helm upgrade --install -n metallb-system --create-namespace --wait --timeout 5m --rollback-on-failure metallb  metallb/metallb -v 0.16.1
```