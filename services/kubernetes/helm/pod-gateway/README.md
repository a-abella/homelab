
## helm
```
helm -n pod-gateway upgrade --install --wait --rollback-on-failure pod-gateway  angelnu/pod-gateway -f values.yaml --version 7.1.1 --timeout 5m
```


## Notes

- Namespaces must be labeled with `routed-gateway=` to be routed through the gateway. See `values.yaml` for an example.
- Namespaces must ALSO be whitelisted in the values
- Pods _in_ routed namespaces must have `setGateway=` label

DNS is currently configured to go through cluster CoreDNS -> local Pihole instead of the gateway. Pihole DNS will not go through the VPN, but does go through Cloudflare dns-over-https.