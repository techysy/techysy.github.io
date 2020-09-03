---
layout: post
title: CentOS 7 VMware 静态网络配置
date: 2020-09-27 09:00:00 +0800
img: anyoffice.jpg
tags: [blog,学习日志]
categories: 分享
---

## 配置VMware环境下CentOS 7 静态IP

在这之前先获取当前宿主的网络设置

使用`ipconfig`命令或者直接在设置中查看网络信息以及网卡的名字

#### 我的配置

    ip：192.168.50.116
    子网掩码：255.255.255.0
    网关:192.168.50.1

如果不想占用内部网络资源可以给虚拟网卡配置一个虚拟机的IP段

但是得注意一下路由表别冲突了，我喜欢使用`netsh`命令配置网络 

    netsh interface ip set address "网卡名称" static 本机ip 子网掩码 网关 

> netsh interface ip set address "VMware Network Adapter VMnet8" static 192.168.0.2 255.255.255.0 192.168.0.1

#### 配置网络

> su - #切换用户

> vi /etc/sysconfig/network-scripts/ifcfg-ens33

     BOOTPROTO=static
     IPADDR=192.168.0.3
     NETMASK=255.255.255.0
     GATEWAY=192.168.50.1
     DNS1=8.8.8.8
     ONBOOT=yes
 
#### 重启网络

> systemctl restart network  

#### 重启CentOS

> reboot

    其实也可以不重启，这样已经生效了

#### 测试

宿主主机ping虚拟机地址

> ping 192.168.0.3