#!/bin/bash
# 开启转发
sed -i "s/#net.ipv4.ip_forward=1/net.ipv4.ip_forward=1/g" /etc/sysctl.conf
sysctl -p
#启动ssh
service ssh restart
ip addr
/Ad/AdGuardHome
