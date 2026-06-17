---
layout: post
title: macOS 下通过启动转换助理安装 Windows 10/11
date: 2025-12-28 03:00:00 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: bootcamp.jpg
tags: [MAC, Windows, Boot Camp, 双系统, 野生技术协会]
categories: 分享
description: 在 Mac 上使用启动转换助理（Boot Camp）安装 Windows 10/11 的完整指南，包含系统要求、安装步骤和常见问题解决
---

通过 **启动转换助理（Boot Camp）** 可以在 Mac 上安装 Windows 系统，实现 macOS 和 Windows 双系统切换。本文将详细介绍安装步骤和注意事项。

## 目录

- [系统要求](#系统要求)
- [准备工作](#准备工作)
- [安装步骤](#安装步骤)
- [双系统切换](#双系统切换)
- [常见问题](#常见问题)
- [卸载 Windows](#卸载-windows)

## 系统要求

### 硬件要求

| 项目 | 最低要求 | 推荐配置 |
|------|----------|----------|
| 可用存储空间 | 64GB | 128GB+ |
| USB 闪存驱动器 | 16GB+（部分 Mac 不需要） | 32GB |
| 内存 | 4GB | 8GB+ |

> **注意**：如果 Mac 内存为 128GB 或更大，Windows 分区大小需至少等于内存容量。

### 支持的 Mac 型号

**Intel 机型（支持 Boot Camp）**：

- MacBook Pro（2012 年及更新机型）
- MacBook Air（2012 年及更新机型）
- MacBook（2015 年及更新机型）
- iMac（2012 年及更新机型）
- iMac Pro（所有机型）
- Mac Pro（2013 年及更新机型）
- Mac mini（2012 年及更新机型）

**M 系列机型（不支持 Boot Camp）**：

> **重要提示**：搭载 Apple Silicon（M1、M2、M3 系列芯片）的 Mac **不支持** 使用 Boot Camp 安装 Windows！
>
> 原因：Boot Camp 依赖 Intel 硬件虚拟化技术，而 Apple Silicon 使用 ARM 架构，与 Intel x86 架构不兼容。

### M 系列 Mac 的替代方案

如果您使用的是 M 系列 Mac，可以通过以下方式运行 Windows：

| 方案 | 类型 | 优势 | 劣势 |
|------|------|------|------|
| [Parallels Desktop](https://www.parallels.com/) | 虚拟机 | 性能出色，无缝集成 | 需要订阅付费 |
| [VMware Fusion](https://www.vmware.com/products/fusion.html) | 虚拟机 | 稳定可靠，企业级支持 | 需要付费 |
| [CrossOver](https://www.codeweavers.com/crossover) | 兼容层 | 轻量级，无需完整系统 | 兼容性有限 |
| Boot Camp（Intel Mac） | 双系统 | 性能最佳，完整体验 | 仅限 Intel 机型 |

**推荐方案**：对于 M 系列 Mac，**Parallels Desktop** 是目前最佳选择，支持 Windows 10/11 ARM 版，性能接近原生体验，且与 macOS 集成度高。

## 准备工作

### 1. 下载 Windows 镜像

推荐从官方渠道下载：

- **Windows 10**：[Microsoft 官方下载](https://www.microsoft.com/zh-cn/software-download/windows10ISO)
- **Windows 11**：[Microsoft 官方下载](https://www.microsoft.com/zh-cn/software-download/windows11)

选择对应的版本（家庭版/专业版）和语言。

### 2. 备份重要数据

安装过程会对磁盘进行分区操作，**强烈建议提前备份重要数据**：

- 使用 Time Machine 备份 macOS
- 将重要文件复制到外部存储设备

### 3. 检查 macOS 更新

确保 macOS 已更新到最新版本：

```bash
# 打开系统设置 → 通用 → 软件更新
```

## 安装步骤

### 步骤 1：打开启动转换助理

启动转换助理位于「应用程序」→「实用工具」文件夹中：

```bash
open "/Applications/Utilities/Boot Camp Assistant.app"
```

### 步骤 2：创建 Windows 分区

1. 打开启动转换助理，点击「继续」
2. 勾选「创建 Windows 7 或更高版本安装盘」和「下载 Windows 支持软件」
3. 选择 Windows ISO 镜像文件
4. 设置 Windows 分区大小（建议至少 128GB）
5. 点击「安装」，等待分区和驱动下载完成

> **注意**：分区大小设置后无法更改，请根据实际需求合理分配。

### 步骤 3：格式化 Windows 分区

1. Mac 会自动重启并进入 Windows 安装程序
2. 当安装器询问安装位置时，选择名为「BOOTCAMP」的分区
3. 点击「格式化」，等待格式化完成

### 步骤 4：安装 Windows

1. 点击「继续」开始安装 Windows
2. 按照屏幕提示完成 Windows 设置（语言、区域、产品密钥等）
3. 安装完成后，系统会自动重启

### 步骤 5：安装 Boot Camp 驱动

1. Windows 启动后，会自动打开「启动转换安装器」
2. 按照提示安装 Windows 支持软件（包括硬件驱动）
3. 安装完成后，重新启动电脑

> 如果安装器没有自动打开，可以手动运行：`D:\setup.exe`（D 盘为 Boot Camp 驱动所在分区）

## 双系统切换

### 方法一：使用启动管理器

1. 关闭 Mac
2. 按住 **Option（或 Alt）⌥** 键并开机
3. 在启动管理器中选择要启动的系统（macOS 或 Windows）

### 方法二：在 macOS 中设置默认启动系统

1. 打开「系统设置」→「通用」→「启动磁盘」
2. 点击锁图标，输入密码解锁
3. 选择默认启动的系统
4. 点击「重新启动」

### 方法三：在 Windows 中设置默认启动系统

1. 打开「控制面板」→「Boot Camp」
2. 在「启动磁盘」选项卡中选择默认系统
3. 点击「重新启动」

## 常见问题

### Q1：启动转换助理提示无法创建可引导 USB

**解决方案**：

- 确保 USB 驱动器格式为 FAT32
- 使用 16GB 以上的 USB 驱动器
- 尝试更换 USB 端口或使用其他 USB 驱动器

### Q2：安装 Windows 后无法启动 macOS

**解决方案**：

1. 按住 Option ⌥ 键开机，选择 macOS 启动
2. 打开「启动转换助理」→「启动磁盘」，设置 macOS 为默认系统

### Q3：Windows 中没有声音或触控板不工作

**解决方案**：

- 确保已安装最新的 Boot Camp 驱动
- 打开「设备管理器」，检查是否有未识别的设备
- 重新运行 Boot Camp 安装器

### Q4：如何调整 Windows 分区大小

**注意**：Boot Camp 不支持调整已创建的分区大小。如需调整，需要：

1. 备份所有数据
2. 使用第三方工具（如 Paragon Hard Disk Manager）调整分区
3. 或卸载 Windows 后重新创建分区

### Q5：MacBook Pro 键盘背光不工作

**解决方案**：

- 安装最新的 Boot Camp 驱动
- 在 Windows 中打开「Boot Camp」控制面板，调整键盘设置

## 卸载 Windows

如果不再需要 Windows，可以将其卸载并恢复磁盘空间：

1. 在 macOS 中打开「启动转换助理」
2. 点击「继续」
3. 选择「移除 Windows 7 或更高版本」
4. 点击「恢复」，等待磁盘恢复完成
5. 重新启动 Mac

> **注意**：此操作会删除 Windows 分区上的所有数据，请提前备份。

---

**总结**：使用 Boot Camp 在 Mac 上安装 Windows 是官方推荐的方法，兼容性和稳定性都有保障。安装前请仔细阅读系统要求，备份重要数据。安装后记得及时更新 Boot Camp 驱动，以获得最佳体验。