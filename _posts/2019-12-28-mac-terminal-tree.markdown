---
layout: post
title: 全平台终端树状目录结构输出指南
date: 2019-12-28 14:24:00 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: terminal-tree.jpg
tags: [MAC, Linux, Windows, 终端, 野生技术协会]
categories: 分享
description: 全平台（macOS、Linux、Windows）终端树状目录结构输出方法，包含安装、常用命令和实用技巧
---

在终端中以树状结构展示目录可以清晰地查看文件层级关系，分享项目结构时尤其有用。本文将介绍 **macOS**、**Linux**、**Windows** 三大平台的实现方法。

## 目录

- [macOS](#macos)
- [Linux](#linux)
- [Windows](#windows)
- [常用命令参数](#常用命令参数)
- [实用技巧](#实用技巧)

## macOS

### 方法一：使用 Homebrew 安装 tree

首先确保已安装 [Homebrew](https://brew.sh/index_zh-cn)，推荐使用 [USTC Mirror](http://mirrors.ustc.edu.cn/help/brew.git.html) 加速：

```bash
brew install tree
```

![install]({{site.baseurl}}/assets/img/terminal-tree/install.jpg)

### 方法二：使用 find 命令模拟（无需安装）

如果不想安装额外工具，可以使用 `find` 命令：

```bash
find . -type d | head -20
```

## Linux

### 方法一：系统自带 tree（推荐）

大多数 Linux 发行版（如 Ubuntu、Debian、CentOS）默认已安装 tree：

```bash
tree
```

### 方法二：手动安装

如果系统未安装：

```bash
# Debian / Ubuntu
sudo apt-get install tree

# CentOS / Fedora
sudo yum install tree

# Arch Linux
sudo pacman -S tree
```

## Windows

### 方法一：命令提示符（CMD）

Windows 命令提示符自带 `tree` 命令：

```cmd
tree
```

显示完整路径：

```cmd
tree /f
```

### 方法二：PowerShell

PowerShell 提供了更强大的 `Get-ChildItem` 命令：

```powershell
# 显示2层目录
Get-ChildItem -Recurse -Depth 2 | Format-Wide -Column 1

# 使用 tree 别名（PowerShell 5.1+）
tree
```

### 方法三：安装 Unix 工具

通过 [Git Bash](https://git-scm.com/download/win) 或 [WSL](https://docs.microsoft.com/zh-cn/windows/wsl/install) 使用原生 tree 命令。

## 常用命令参数

以下参数适用于 macOS 和 Linux 的 tree 命令：

### 基本用法

```bash
# 显示当前目录结构
tree

# 限制显示层级（显示2层）
tree -L 2

# 显示3层目录结构
tree -L 3
```

![tree]({{site.baseurl}}/assets/img/terminal-tree/tree.jpg)

### 实用参数

```bash
# 显示文件大小
tree -h

# 只显示目录
tree -d

# 显示完整路径
tree -f

# 按修改时间排序
tree -t

# 忽略特定文件或目录
tree -I "node_modules|.git"

# 输出到文件
tree -L 2 > tree.txt

# 显示隐藏文件
tree -a

# 彩色输出（默认开启）
tree -C
```

### 帮助信息

```bash
tree --help
```

![help]({{site.baseurl}}/assets/img/terminal-tree/help.jpg)

## 实用技巧

### 1. 分享项目结构

在分享 Hackintosh EFI 配置或项目文件时，可以快速生成目录树：

```bash
tree -L 3 > EFI结构.txt
```

### 2. 排查目录问题

快速了解目录结构，排查文件缺失问题：

```bash
tree -d -L 2 /boot/efi/EFI
```

### 3. 配合 grep 过滤

```bash
# 查找包含特定名称的目录
tree -f | grep -i "efi"
```

### 4. 自定义别名

在 `.bashrc` 或 `.zshrc` 中添加常用别名：

```bash
# 显示当前目录2层结构
alias t="tree -L 2"

# 显示目录大小
alias th="tree -h -L 2"

# 只显示目录
alias td="tree -d -L 2"
```

### 5. PowerShell 自定义函数

在 PowerShell 中添加自定义函数：

```powershell
function t {
    tree /f
}

function td {
    tree
}
```

---

**总结**：tree 命令是终端中查看目录结构的利器，各平台都有对应的实现方式。掌握常用参数可以大大提高工作效率，特别是在分享项目结构、排查文件问题时非常实用。