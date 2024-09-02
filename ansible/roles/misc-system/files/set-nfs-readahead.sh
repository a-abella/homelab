#!/bin/sh

# this script sets the read_ahead_kb to Red Hat recommended 15360KB for
# discovered nfs mounts in the kubelet pod directory 

find /var/lib/kubelet/pods -type d -name '*nfs*' | while read -r nfs_mount; do
  if [ -d "$nfs_mount" ]; then
    bdi="$(mountpoint -d "$nfs_mount" 2>/dev/null | grep -v 'not a mountpoint')"
    if [ "$bdi" ]; then
      cur_val="$(cat "/sys/class/bdi/$bdi/read_ahead_kb")"
      desired_val=15360
      if [ "$cur_val" -lt "$desired_val" ]; then
        echo "$desired_val" > "/sys/class/bdi/$bdi/read_ahead_kb"
        echo 3 > /proc/sys/vm/drop_caches
      fi
    fi
  fi
done