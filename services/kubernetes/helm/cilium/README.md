```
~ helm upgrade --atomic --timeout=20m cilium cilium/cilium --namespace kube-system -f values.yaml --set upgradeCompatibility=${CURRENT_VERSION} --version=${TARGET_VERSION}
```
