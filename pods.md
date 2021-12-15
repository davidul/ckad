# PODS

In Kubernetes Pod is the smallest deployable unit.
Pod is one or more containers, sharing network 
and storage resources. 

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

Run pod, named "nginx"
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

## Run Pod
Pod can be created and schedules by either declarative or imperative
way.
Imperative way is in form of executing a command. Declarative way 
is to write the declaration in form of YAML file and then let the 
K8s cluster to determine the best way to fulfill it.

Imperative way of creating POD
```
kubectl run nginx --image=nginx
```