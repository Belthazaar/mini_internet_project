#!/bin/bash

if (($UID != 0)); then
    echo "$0 needs to be run as root"
    exit 1
fi

apt update
apt install openvpn openvswitch-switch openvpn linux-modules-extra-`uname -r` -y
sysctl fs.inotify.max_user_instances=1024

bash ./docker_images/pull_images.sh
