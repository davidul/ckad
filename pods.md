#PODS
List pods in default namespace
```
kubectl get pods
kubectl get pod
kubectl get po
```
List pods in kube-system namespace
```
kubectl get pods -n kube-system
```

Delete pod name curl-david
```
kubectl delete pod curl-david
```

Run pod
```
kubectl run nginx --image=nginx
```

Get a shell into running container
```
kubectl exec --stdin --tty nginx -- /bin/bash
```

Run command
```
kubectl exec nginx -- ls -ltr
```

Attach to a container
```
kubectl attach nginx
```