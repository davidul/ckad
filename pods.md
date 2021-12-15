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

We are three node cluster, the pod has been scheduled to one 
of them
```
kubectl get pods -o wide
NAME    READY   STATUS    RESTARTS   AGE   IP             NODE       NOMINATED NODE   READINESS GATES
nginx   1/1     Running   0          75s   10.1.133.193   worker-2   <none>           <none>
```

We can inspect the logs
```
kubectl logs nginx
/docker-entrypoint.sh: /docker-entrypoint.d/ is not empty, will attempt to perform configuration
/docker-entrypoint.sh: Looking for shell scripts in /docker-entrypoint.d/
/docker-entrypoint.sh: Launching /docker-entrypoint.d/10-listen-on-ipv6-by-default.sh
```

We can describe the pod
```
kubectl describe pod nginx
```

So far there are not many differences from the docker container.
We can actually have a look at the container itself. Kubernetes
dropped the support for docker, microk8s is using containerd to run
the containers. You can verify this
by running
```shell
ps aux | grep containerd
```
For containerd you have to install [crictl](https://github.com/kubernetes-sigs/cri-tools/blob/master/docs/crictl.md)

List available images, to see the nginx, you have to do it on the where it 
has been scheduled see kubectl get pods -o wide the NODE column.
```shell
crictl -r /var/snap/microk8s/common/run/containerd.sock images
```

Our nginx container is running here
```shell
crictl -r /var/snap/microk8s/common/run/containerd.sock ps

CONTAINER           IMAGE               CREATED             STATE               NAME                ATTEMPT             POD ID
389a12535bdad       f652ca386ed13       15 minutes ago      Running             nginx               0                   925fdb09c759f
8d54f035ee64e       c4d75af7e098e       About an hour ago   Running             calico-node         0                   a340329a8e2db
```
Exec a bash inside the container (if there is any)
```shell
crictl -r /var/snap/microk8s/common/run/containerd.sock exec -t -i 389a12535bdad /bin/bash
```

