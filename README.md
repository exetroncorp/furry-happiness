# furry-happiness

A proof of concept [user mode linux](https://en.wikipedia.org/wiki/User-mode_Linux)
Docker image. This builds a simply configured kernel and sets up an [Alpine Linux](https://alpinelinux.org)
userland for it. It has fully working networking via slirp.

This runs an entire Linux kernel as a userspace process inside a docker container.
Anything you can do as root in a linux kernel, you can do inside this user mode
Linux process. The root inside this user mode Linux kernel has significanly more
power than root outside of the kernel, but it cannot affect the host kernel.

To build:

```
docker build -t xena/docker-uml .
```

To run:

```
docker run --rm -it xena/docker-uml
```
export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
apk update
apk add podman fuse-overlayfs iptables-legacy
apk add nftables aardvark-dns
ln -sf /usr/sbin/iptables-legacy /usr/sbin/iptables
ln -sf /usr/sbin/ip6tables-legacy /usr/sbin/ip6tables
mkdir -p /dev/shm   
mount -t tmpfs tmpfs /dev/shm
sed -i '/^#mount_program/s/^#//'  /etc/containers/storage.conf 
sed -i 's|^graphroot = .*$|graphroot = "/tmp/var/lib/containers/storage"|' /etc/containers/storage.conf 
sed -i 's|^runroot = .*$|runroot = "/tmp/run/containers/storage"|' /etc/containers/storage.conf 
podman run hello-world

# In the Alpine stage, add these packages:
apk --no-cache add     iptables     ip6tables     iproute2     bridge-utils     iputils     net-tools
 



