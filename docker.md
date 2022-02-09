# Docker

- [Docker](#docker)
    * [Docker image](#docker-image)
    * [Docker socket](#docker-socket)
    * [Volumes](#volumes)
        + [Listing volumes](#listing-volumes)
    * [Mount docker socket](#mount-docker-socket)

<small><i><a href='http://ecotrust-canada.github.io/markdown-toc/'>Table of contents generated with markdown-toc</a></i></small>

## Docker image
Docker image is created using `Dockerfile`. There you put the instructions how to assemble
the image. There is usually a `parent` image which you specify with `FROM` keyword.
You can also build the image from `scratch` and there is no parent 
in that case.
Example:

```dockerfile
FROM alpine:3.15.0
```

This means that `alpine` linux will be used as the base image. To build the actual 
image use command, where -t is tag and `.` is context where to build the
image
```shell
docker build -t david .
```
This will build the image in the current directory and will tag it
as `david:latest`, latest is default.

```shell
docker images

REPOSITORY            TAG               IMAGE ID       CREATED         SIZE
david                 latest            0affd6b30e11   4 hours ago     221MB
```

## Docker socket
Docker creates a socket at `/var/run/docker.sock` . You can connect to it
via `curl`, for example list of all images in json format

```shell
curl --unix-socket /var/run/docker.sock http://localhost/images/json
```

## Volumes
Volumes allows docker to mount filesystem from outside of the container.
Container itself has just temporary writable layer.

Mount volume
```shell
docker run -v $(pwd):/var/opt/project bash 
```

### Listing volumes
You can list all volumes docker is managing with 
command 
```shell
docker volume ls

DRIVER    VOLUME NAME
local     2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8
local     3a6ecbb26c13688d60b8ad261428c0f78a1582c8f9f8cf4bd7d8b03c1fc9d35b
local     3c8ca2d67ab74b47d0850eb531b2f1cf093c69c44b3b91b54a71187cd21300e1
```

Volume names are little cryptic, but you can inspect the 
volume with command

```shell
docker volume inspect 2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8

[
    {
        "CreatedAt": "2022-01-19T09:55:05Z",
        "Driver": "local",
        "Labels": null,
        "Mountpoint": "/var/lib/docker/volumes/2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8/_data",
        "Name": "2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8",
        "Options": null,
        "Scope": "local"
    }
]
```
Still does not tell to which container this volume belongs to.
To find a volume in container, you can inspect the container itself.
Let`s list the containers first

```shell
docker ps -a

CONTAINER ID   IMAGE                       COMMAND                  CREATED             STATUS                         PORTS     NAMES
c3df94c9c2fc   bash:latest                 "docker-entrypoint.s…"   About an hour ago   Exited (0) About an hour ago             elegant_nash
b53c6520ded9   bash:latest                 "docker-entrypoint.s…"   2 hours ago         Exited (0) 2 hours ago                   trusting_pare
3d949aa79ef0   couchbase:community-7.0.2   "/entrypoint.sh couc…"   6 days ago          Exited (0) 34 minutes ago                db
```

We can inspect any of the containers with `inspect` command.
Output of the inspect command is very verbose and we are now interested
only into the `Mounts`. You can use the `--format` option and
Go template

```shell
docker inspect db --format '{{json .Mounts}}'          
[{"Type":"volume","Name":"2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8","Source":"/var/lib/docker/volumes/2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8/_data","Destination":"/opt/couchbase/var","Driver":"local","Mode":"","RW":true,"Propagation":""}]
```

Or use [jq](https://stedolan.github.io/jq/) utility to nice print

```shell
docker inspect db | jq '.[].Mounts' 

[
  {
    "Type": "volume",
    "Name": "2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8",
    "Source": "/var/lib/docker/volumes/2bdc02a4406b255b63d96eead26cfbbbaa6f785e85860d72bfdbf577932006d8/_data",
    "Destination": "/opt/couchbase/var",
    "Driver": "local",
    "Mode": "",
    "RW": true,
    "Propagation": ""
  }
]
```

## Mount docker socket
Because docker socket is regular file on unix, it can be
mounted to the docker container. In this way the container has
access to the docker daemon who executed him.

Run vanilla ubuntu and install `curl` and `jq` into it
```shell
docker run -v /var/run/docker.sock:/var/run/docker.sock -ti ubuntu

root@1607dabf02b0:/# apt install curl
root@1607dabf02b0:/# apt install jq
```
Now we have access to the "outer" dockerd

```shell
root@1607dabf02b0:/# curl --unix-socket /var/run/docker.sock http://localhost/images/json | jq .
```

If you have docker available you can use standard docker command
```shell
docker ps
```
Will then list yourself running. Note that `$HOSTNAME` holds the container ID.
You can use for example in the `port` command
This will show the port the container is listening

```shell
docker port $HOSTNAME
```
## Docker Execute
There are few options how to execute the docker container. Docker `run` command has basic
syntax 
```shell
docker run IMAGE COMMAND
```
You can pass the command from the shell, for example with empty command

```shell
docker run alpine
```
It will create the container and exit immediately.
It executed `/bin/sh` and exit
```shell
61b134d5fd93   alpine                      "/bin/sh"                7 seconds ago   Exited (0) 6 seconds ago             tender_khayyam
```
If we allocate the interactive tty with `-it` param, we will jump into the shell

```shell
docker run -it alpine
/ # 
```

Let's pass the command now

```shell
docker run alpine ls
bin
dev
etc
home
...
```

Alpine 3.15 Dockerfile is here [https://github.com/alpinelinux/docker-alpine/blob/v3.15/armv7/Dockerfile](https://github.com/alpinelinux/docker-alpine/blob/v3.15/armv7/Dockerfile)

```dockerfile
FROM scratch
ADD alpine-minirootfs-3.15.0-armv7.tar.gz /
CMD ["/bin/sh"]
```
`CMD` directive instructs docker to run this command when no other command is passed from
command line.
We can demonstrate this with our own command

```dockerfile
FROM alpine:3.15
CMD ["ls"]
```

```shell
docker build . -t davidul-ls
docker run davidul-ls
bin
dev
etc
home
...
```
`ls` command is executed by default.

You can add `ENTRYPOINT` instruction and use `CMD` as 
parameters to it. For example
```dockerfile
FROM alpine:3.15
ENTRYPOINT ["ls"]
CMD ["-l"]
```
Output of execution

```shell
docker run davidul-ls
total 56
drwxr-xr-x    2 root     root          4096 Nov 24 09:23 bin
drwxr-xr-x    5 root     root           340 Feb  9 10:43 dev
...
```
