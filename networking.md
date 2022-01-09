# Networking

showh in JSON format
ip -j --pretty link

ip netns network namespace

```shell
ip netns
cni-23a719df-8283-949d-c05e-45a7d813acc9 (id: 5)
cni-235c1771-3fe3-3db0-2c54-e4b959dd920f (id: 4)
cni-fcd78e01-8b83-fd95-fdc3-20e9abb553da (id: 3)
cni-c2882214-942f-c07e-e556-d5f73b331907 (id: 2)
cni-641cf733-4c00-2b4f-3a2e-73e18dd44f82 (id: 1)
cni-454b134d-2f11-eb26-cac2-2918f87159cd (id: 0)
```

```shell
ip netns add red
ip netns add blue
```
```shell
ip -n red link
```

```shell
ip link add veth-red type veth peer name veth-blue
ip link set veth-red netns red
ip link set veth-blue netns blue
ip -n red addr add 192.168.15.1 dev veth-red
ip -n blue addr add 192.168.15.2 dev veth-blue
ip -n red link set veth-red up
ip -n blue link set veth-blue up
```

Delete link
```shell
ip -n red link del veth-red 
```

Create a switch (bridge)
```shell
ip link add v-net-0 type bridge
ip addr add 192.168.15.5/24 dev v-net-0
ip link set dev v-net-0 up
```

Add cable to the bridge
```shell
ip link add veth-red type veth peer name veth-red-br
ip link add veth-blue type veth peer name veth-blue-br
ip link set veth-red netns red
ip link set veth-red-br master v-net-0
ip link set veth-blue netns blue
ip link set veth-blue-br master v-net-0
```

set ip address

```shell
ip -n red addr add 192.168.15.1 dev veth-red
ip -n red addr add 192.168.15.2 dev veth-blue
ip -n red link set veth-red up
ip -n blue link set veth-blue up
```

Add route
```shell
ip route add 192.168.0.0/24 via 192.168.15.1
ip netns exec blue ip route add 192.168.0.0/24 via 192.168.15.1
```

Cgroups
systemd-cgls
https://developers.redhat.com/blog/2018/10/22/introduction-to-linux-interfaces-for-virtual-networking#macvlan
