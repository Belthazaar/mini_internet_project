#!/bin/bash


sudo apt update && sudo apt install openvpn openvswitch-switch openvpn linux-modules-extra-`uname -r` -y
sudo sysctl fs.inotify.max_user_instances=1024
