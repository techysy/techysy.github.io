---
layout: post
title: CentOS 7 VMware网络配置
date: 2020-05-27 09:00:00 +0800
img: anyoffice.jpg
tags: [blog,学习日志]
categories: 分享
---

## 配置VMware环境下CentOS 7 静态IP

在这之前先获取当前宿主的网络设置

使用ipconfig命令或者直接在设置中查看网络信息

#### 我的配置

    ip：192.168.50.116
    子网掩码：255.255.255.0
    网关:192.168.50.1



#### 配置网络

> vi /etc/sysconfig/network-scripts/ifcfg-ens33

    BOOTPROTO=static
     IPADDR=192.168.50.216
     NETMASK=255.255.255.0
     GATEWAY=192.168.50.1
     DNS1=8.8.8.8
     ONBOOT=yes
 
#### 重启网络

> systemctl restart network  

#### 重启
    如果IP冲突路由器会重新分配一个  
    在这之前我设置的是120
    ip addr 查看就是216了