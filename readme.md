#CKAD

https://github.com/dgkanatsios/CKAD-exercises/blob/master/a.core_concepts.md
https://github.com/bmuschko/ckad-study-guide

Distroless
https://github.com/GoogleContainerTools/distroless

https://github.com/netlify/gotrue

https://github.com/bradtraversy/vanillawebprojects

https://github.com/bradtraversy/50projects50days

https://github.com/google/zx

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

##Curriculum

* Application Design and Build  20%
* Application Deployment 20%
* Application observability and maintenance 15%
* Application Environment, Configuration and Security 25%
* Services and Networking 20%

###Application Design and Build
* Define, build and modify container images
* Understand Jobs and CronJobs
* Understand multi-container Pod design patterns (sidecar, init, etc.)
* Utilize persistent and ephemeral volumes

###Application Deployment
* Use Kubernetes primitives to implement common deployment strategies (blue/green, canary etc.)
* Understand deployments and how to perform rolling updates
* Use Helm package manager to deploy existing packages

###Application observability and maintenance
* Understand API deprecations
* Implement probes and health checks
* Use provided tools to monitor Kubernetes applications
* Utilize container logs
* Debugging in Kubernetes

###Application Environment, Configuration and Security
* Discover and use resources that extend Kubernetes (CRD)
* Understand authentication, authorization and admission control
* Understanding and defining resource requirements, limits and quotas
* Understand ConfigMaps
* Create and Consume secrets
* Understand ServiceAccounts
* Understand SecurityContext

###Services and Networking
* Demonstrate basic understanding of NetworkPolicies
* Provide and troubleshoot access to application via services
* Use Ingress rules to expose applications

[Pods](pods.md)
