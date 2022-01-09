
# Configuration
## Config map

List config maps
```
kubectl get configmap
```

List config maps in namespace
```
kubectl get configmap -n kube-system
```

Describe configmap
```
kubectl describe configmap coredns -n kube-system
```

Create config map
```
kubectl create configmap test-config-map --from-literal=env=prod --from-literal=app=spring
```
