# external-dns

With pihole provider

Requires the Sealed-Secret manifest to be installed first.

```
kubectl create namespace external-dns
kubectl apply -f sealed-secret.yaml
helm repo add external-dns https://kubernetes-sigs.github.io/external-dns/
helm repo update
helm upgrade --install --wait --timeout 5m --rollback-on-failure external-dns external-dns/external-dns --namespace external-dns --values values.yaml --version 1.21.1
```