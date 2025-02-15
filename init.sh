#!/bin/sh

mount -t proc proc proc/
mount -t sysfs sys sys/

#!/bin/sh
# Mount basic filesystems
mount -t proc proc /proc
mount -t sysfs sysfs /sys
mount -t tmpfs cgroup /sys/fs/cgroup

# Set up cgroups v1 hierarchy
mkdir -p /sys/fs/cgroup/memory
mkdir -p /sys/fs/cgroup/cpu
mkdir -p /sys/fs/cgroup/pids
mkdir -p /sys/fs/cgroup/cpuset
mkdir -p /sys/fs/cgroup/net_cls
mkdir -p /sys/fs/cgroup/blkio
mkdir -p /sys/fs/cgroup/devices

mount -t cgroup cgroup -o memory /sys/fs/cgroup/memory
mount -t cgroup cgroup -o cpu /sys/fs/cgroup/cpu
mount -t cgroup cgroup -o pids /sys/fs/cgroup/pids
mount -t cgroup cgroup -o cpuset /sys/fs/cgroup/cpuset
mount -t cgroup cgroup -o net_cls /sys/fs/cgroup/net_cls
mount -t cgroup cgroup -o blkio /sys/fs/cgroup/blkio
mount -t cgroup cgroup -o devices /sys/fs/cgroup/devices

# Enable user namespaces
sysctl -w kernel.unprivileged_userns_clone=1

# Set environment variables for Podman
export PODMAN_SECCOMP=false
export PODMAN_IGNORE_CGROUPSV1_WARNING=1
ifconfig eth0 10.0.2.14 netmask 255.255.255.240 broadcast 10.0.2.15
route add default gw 10.0.2.2

reset
uname -av
echo "networking set up"



exec /tini /bin/sh
