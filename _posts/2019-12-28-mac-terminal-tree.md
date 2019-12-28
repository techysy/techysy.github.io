---
layout: post
title: 在 macOS 终端输出漂亮的目录结构
date: 2019-12-28 14:24:00 +0800
img: terminal-tree.jpg
tags: [MAC,野生技术协会]
categories: 分享
---

## 使用 Homebrew 安装 tree

 默认情况需要提前安装 <a herf="https://brew.sh/index_zh-cn" target="_blank">Homebrew </a>  并使用<a herf="http://mirrors.ustc.edu.cn/help/brew.git.html" target="_blank"> USTC Mirror</a> 加速

> brew install tree

![it]({{site.baseurl}}/assets/img/bterminal-tree/it.jpg) 

当前目录下2层目录结构（系统的EFI引导文件夹）

> tree -L 2

![tree]({{site.baseurl}}/assets/img/bterminal-tree/tree.jpg) 

> tree -L 3

就是当前目录下2层目录结构

> tree -help 查看帮助

![help]({{site.baseurl}}/assets/img/bterminal-tree/help.jpg) 

## 相关链接：

+ 官方主页
<a herf="http://brew.sh/" target="_blank">http://brew.sh/</a>

+ brew 文档 <a herf="http://docs.brew.sh/" target="_blank">http://docs.brew.sh/</a>


+ USTC Mirror <a herf="http://mirrors.ustc.edu.cn/ " target="_blank">http://mirrors.ustc.edu.cn/ </a>