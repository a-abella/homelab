# pre-upgrade
dnf -y upgrade --refresh
dnf -y install http://repo.almalinux.org/elevate/elevate-release-latest-el$(rpm --eval %rhel).noarch.rpm
dnf install -y leapp-upgrade leapp-data-almalinux
kubectl drain _ --ignore-daemonsets
systemctl stop containerd
systemctl stop kubelet
umount -a -t nfs
nmcli connection migrate
sed -i'' 's/^media/#media/' /etc/fstab
leapp preupgrade
leapp upgrade


# post-upgrade
reboot
dnf -y distro-sync
sed -i'' 's/^SELINUX=.*/SELINUX=enforcing/' /etc/sysconfig/selinux
cat /etc/sysconfig/selinux
cat /etc/resolv.conf
sed -i'' 's/^#media/media/' /etc/fstab
cat /etc/fstab
reboot
kubectl uncordon _