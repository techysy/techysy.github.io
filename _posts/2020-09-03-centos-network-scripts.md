---
layout: post
title: CentOS 7 VMware 静态网络配置
date: 2020-09-27 09:00:00 +0800
img: vm-network.jpg
tags: [blog,学习日志]
categories: 分享
---

## 准备工作

> Windows 10 2004  →  VMware® Workstation 15 Pro

先获取当前宿主的网络设置方便之后配置

使用`ipconfig`命令或者直接在设置中查看网络信息以及网卡名

    本地网络 → 以太网

    Windows Server 2012 → VMware Network Adapter VMnet1

    CentOS 7 64 bit  → VMware Network Adapter VMnet8

### 配置虚拟机虚拟网卡

    如果不想占用内部网络资源可以给虚拟网卡配置一个虚拟机的IP段

    但是得注意一下路由表别冲突了，我喜欢使用`netsh`命令配置网络 

```netsh interface ip set address "VMware Network Adapter VMnet8" static 192.168.0.3 255.255.255.0 192.168.0.1```

### 配置CentOS网卡

> su - #切换用户
>
> vi /etc/sysconfig/network-scripts/ifcfg-ens33

    BOOTPROTO=static           #静态变量
    IPADDR=192.168.0.2         #IP地址
    NETMASK=255.255.255.0      #子网掩码
    GATEWAY=192.168.0.1        #网关
    DNS1=8.8.8.8               #DNS
    ONBOOT=yes                 #自启
 
### 重启网络

> systemctl restart network  

### 重启CentOS

> reboot

    不重启也可用，但是不能确保重启之后网卡能不能拉起来

### 测试

宿主主机ping虚拟机地址

> ping 192.168.0.2

使用SSH工具连接

> ssh 用户名@192.168.0.2