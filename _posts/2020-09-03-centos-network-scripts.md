---
layout: post
title: CentOS 7 VMware 静态网络配置教程
date: 2020-09-27 09:00:00 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: vm-network.jpg
tags: [CentOS, VMware, 网络配置, Linux, 教程]
categories: 分享
description: 详细介绍在 VMware 中配置 CentOS 7 静态网络的步骤，包括虚拟网卡设置和网卡配置文件修改
---

在 VMware 虚拟机中配置 CentOS 7 静态网络是日常开发和运维中经常遇到的任务。本文将详细介绍完整的配置步骤。

## 目录

- [准备工作](#准备工作)
- [配置虚拟机虚拟网卡](#配置虚拟机虚拟网卡)
- [配置 CentOS 网卡](#配置-centos-网卡)
- [重启网络服务](#重启网络服务)
- [测试网络连接](#测试网络连接)
- [常见问题](#常见问题)
- [总结](#总结)

## 准备工作

### 环境信息

| 组件 | 版本 |
|------|------|
| 宿主机系统 | Windows 10 2004 |
| 虚拟机软件 | VMware Workstation 15 Pro |
| 虚拟机系统 | CentOS 7 64-bit |

### 获取宿主机网络信息

使用以下方法查看宿主机网络配置：

**方法一：使用命令行**

```cmd
ipconfig
```

**方法二：通过图形界面**

打开「网络和共享中心」→「以太网」→「详细信息」

### 网络映射关系

| 网络用途 | 虚拟网卡 |
|----------|----------|
| 本地网络 | 以太网 |
| Windows Server 2012 | VMware Network Adapter VMnet1 |
| CentOS 7 | VMware Network Adapter VMnet8 |

> **提示**：VMnet8 用于 NAT 模式网络，VMnet1 用于仅主机模式网络。

## 配置虚拟机虚拟网卡

### 方法一：使用 netsh 命令

```cmd
netsh interface ip set address "VMware Network Adapter VMnet8" static 192.168.0.3 255.255.255.0 192.168.0.1
```

### 方法二：通过图形界面

1. 打开「网络和共享中心」
2. 右键点击「VMware Network Adapter VMnet8」
3. 选择「属性」→「Internet 协议版本 4 (TCP/IPv4)」
4. 设置静态 IP 地址：
   - IP 地址：`192.168.0.3`
   - 子网掩码：`255.255.255.0`
   - 默认网关：`192.168.0.1`

> **注意**：虚拟网卡的 IP 地址应与虚拟机在同一网段，但不能冲突。

## 配置 CentOS 网卡

### 1. 切换到 root 用户

```bash
su -
```

### 2. 查看网卡名称

```bash
ip addr show
```

通常网卡名称为 `ens33` 或 `eth0`。

### 3. 修改网卡配置文件

```bash
vi /etc/sysconfig/network-scripts/ifcfg-ens33
```

### 4. 配置参数说明

```bash
BOOTPROTO=static           # 启用静态 IP（dhcp 为自动获取）
IPADDR=192.168.0.2         # 静态 IP 地址
NETMASK=255.255.255.0      # 子网掩码
GATEWAY=192.168.0.1        # 默认网关
DNS1=8.8.8.8               # 首选 DNS 服务器
DNS2=114.114.114.114       # 备用 DNS 服务器
ONBOOT=yes                 # 开机自启网络
NM_CONTROLLED=no           # 禁用 NetworkManager 管理
TYPE=Ethernet              # 网络类型
NAME=ens33                 # 网卡名称
DEVICE=ens33               # 设备名称
```

### 配置参数详解

| 参数 | 值 | 说明 |
|------|-----|------|
| BOOTPROTO | static / dhcp | IP 获取方式，static 为静态，dhcp 为自动获取 |
| IPADDR | 192.168.0.2 | 虚拟机静态 IP 地址 |
| NETMASK | 255.255.255.0 | 子网掩码 |
| GATEWAY | 192.168.0.1 | 默认网关，与宿主机一致 |
| DNS1 | 8.8.8.8 | Google DNS，保证外网访问 |
| DNS2 | 114.114.114.114 | 国内备用 DNS |
| ONBOOT | yes | 开机时自动激活网卡 |
| NM_CONTROLLED | no | 禁用 NetworkManager，使用传统 network 服务 |

## 重启网络服务

### 方法一：重启 network 服务

```bash
systemctl restart network
```

### 方法二：重启 NetworkManager（CentOS 7+）

```bash
systemctl restart NetworkManager
```

### 验证网络配置

```bash
# 查看 IP 地址
ip addr show ens33

# 查看网络状态
systemctl status network
```

## 测试网络连接

### 1. 宿主机 ping 虚拟机

```cmd
ping 192.168.0.2
```

### 2. 虚拟机 ping 宿主机

```bash
ping 192.168.0.3
```

### 3. 虚拟机 ping 外网

```bash
ping www.baidu.com
```

### 4. 使用 SSH 连接

```bash
# Linux / macOS
ssh username@192.168.0.2

# Windows（使用 PuTTY 或 PowerShell）
ssh username@192.168.0.2
```

## 常见问题

### Q1：重启网络服务失败

**错误信息**：`Job for network.service failed because the control process exited with error code.`

**解决方案**：

1. 检查配置文件语法是否正确
2. 确认 IP 地址没有与其他设备冲突
3. 检查 NetworkManager 是否占用了网卡：

```bash
systemctl stop NetworkManager
systemctl disable NetworkManager
systemctl restart network
```

### Q2：虚拟机无法访问外网

**解决方案**：

1. 检查网关配置是否正确
2. 检查 DNS 配置是否正确
3. 测试能否 ping 通网关：

```bash
ping 192.168.0.1
```

### Q3：宿主机无法 ping 通虚拟机

**解决方案**：

1. 检查防火墙设置：

```bash
# 查看防火墙状态
systemctl status firewalld

# 临时关闭防火墙
systemctl stop firewalld

# 永久关闭防火墙
systemctl disable firewalld
```

2. 检查 SELinux 设置：

```bash
# 临时关闭 SELinux
setenforce 0

# 永久关闭 SELinux（修改 /etc/selinux/config）
SELINUX=disabled
```

### Q4：网卡名称不是 ens33

**解决方案**：使用 `ip addr show` 查看实际的网卡名称，然后修改对应的配置文件。

## 总结

配置 CentOS 7 静态网络的关键步骤：

1. **配置宿主机虚拟网卡**：确保 VMnet8 的 IP 与虚拟机在同一网段
2. **修改网卡配置文件**：设置静态 IP、网关和 DNS
3. **重启网络服务**：使配置生效
4. **测试网络连接**：验证宿主机与虚拟机的互通性

**注意事项**：

- 确保 IP 地址不冲突
- 正确配置网关和 DNS，否则无法访问外网
- 根据实际情况选择使用 network 服务或 NetworkManager

---

**参考资源**：

- **CentOS 官方文档**：[https://docs.centos.org/](https://docs.centos.org/)
- **VMware 官方文档**：[https://docs.vmware.com/](https://docs.vmware.com/)