# CKAD

[CKAD](ckad.md)

[Pods](pods.md)

[Configuration](configuration.md)


Folders

```
installation
|
-- docker - docker files for containers used in this exercise
-- multi - multi machine vagrant setup with K8S provisioned
-- plain - multi machine vagrant setup - plain ubuntu
-- provision - provisioning scripts
k8s
|
-- deploymet
-- pod
spring-boot-demo - spring boot demo app, java project
```

## Create K8s Cluster   
Create the cluster with [multipass](https://multipass.run/) 

Default settings are 1G of memory and 1 CPU. CPU is enough,
but feels faster if the memory is slightly increased.
Creating three machines, one controll plane and two worker nodes.
```shell
multipass launch --mem 3G -n control-node
multipass launch --mem 3G -n worker-1
multipass launch --mem 3G -n worker-2
```

Once they are up and running you can connect to the shell
and install [microk8s](https://microk8s.io/)s

```shell
multipass shell controll-node
sudo snap install microk8s --classic
sudo microk8s enable dns dashboard storage
```

When microk8s is up and running worker nodes can join the
cluster. On the control node issue command
```shell
sudo microk8s add-node
From the node you wish to join to this cluster, run the following:
microk8s join 10.27.179.152:25000/1b7934b93d394efa5fa71c0c2b28c4ad/65265a586ee8

If the node you are adding is not reachable through the default interface you can use one of the following:
microk8s join 10.27.179.152:25000/1b7934b93d394efa5fa71c0c2b28c4ad/65265a586ee8
```

Copy paste the join command and excute on the worker node.
You need to do this for every node (microk8s add-node).

Verify the result
```shell
~$ kubectl get nodes
NAME           STATUS   ROLES    AGE   VERSION
worker-2       Ready    <none>   35m   v1.22.4-3+adc4115d990346
control-node   Ready    <none>   48m   v1.22.4-3+adc4115d990346
worker-1       Ready    <none>   37m   v1.22.4-3+adc4115d990346

```

If you want to stop all the machines
```
multipass stop --all
```

Get rid of all of them 
```
multipass delete --all
multipass purge
```




## Interesting pages

Distroless
https://github.com/GoogleContainerTools/distroless

https://github.com/netlify/gotrue

https://github.com/bradtraversy/vanillawebprojects

https://github.com/bradtraversy/50projects50days

https://github.com/google/zx

https://github.com/dgkanatsios/CKAD-exercises/blob/master/a.core_concepts.md

https://github.com/bmuschko/ckad-study-guide




