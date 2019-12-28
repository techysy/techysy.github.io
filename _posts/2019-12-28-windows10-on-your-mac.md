---
layout: post
title: macOS 下通过“启动转换助理”安装 Windows 10
date: 2019-12-28 03:00:00 +0800
img: bootcamp.jpg
tags: [MAC,野生技术协会]
categories: 分享
---

通过“启动转换”在 Mac 上安装  Windows 10，然后在重新启动 Mac 时在 macOS 和 Windows 之间进行切换.

## 在你的电脑上安装 Windows 10 需要满足的条件

#### 硬盘（不同盘也行）上需要有 64GB 或更大的可用储存空间：

> 您的可用储存空间最小可为 64GB，但是要想获得最佳体验，可用储存空间需至少为 128GB。Windows 的自动更新至少需要这么多空间才能进行。
>
> 如果您的电脑 内存 (RAM) 为 128GB 或更大，那么 Windows 安装器所需的可用储存空间至少应与 Mac 的内存一样大。例如，如果您的 Mac 内存为 256GB，则您的启动磁盘必须至少有 256GB 的 Windows 可用储存空间。
>
> 储存容量为 16GB 或更大的外置 USB 闪存驱动器，除非您使用的 Mac 不需要从闪存驱动器安装 Windows。(也可以使用一个单独的分区来引导，安装完成删除分区就好)
>
> 存储在磁盘映像 (ISO) 或其他安装介质上(比如其他分区)的  Windows 10 Home 或 Windows 10 Pro：
>
> 如果您是首次在 Mac 上安装 Windows，请使用 Windows 完整版，而不是升级包。
如果您的 Windows 副本以 USB 闪存驱动器形式提供，或您有 Windows 产品密钥但没有安装光盘，您可以从<a href="http://www.microsoft.com/zh-cn/software-download/windows10ISO" target="_blank"> Microsoft </a> 下载磁盘映像。建议还是从 <a href="http://msdn.itellyou.cn" target="_blank"> msdn i tell you </a> 下载最新的系统（ 使用ed2k链接 )

> 我也上传到了我的<a href="http://pan.baidu.com/s/1qsnLLL07b7_UPBMaJUKqvQ" target="_blank"> 百度云盘</a> 密码 : *3fwu* 系统版本 Windows 10 1909 Update 发布日期：*2019-12-17*

> 如何在 Mac 上安装 Windows 10
要安装 Windows，请使用“启动转换助理”。它位于“应用程序”文件夹中的“实用工具”文件夹中。

### 1. 使用“启动转换助理”创建一个 Windows 分区
打开“启动转换助理”，并按照屏幕上的说明操作：

如果系统要求您插入 USB 驱动器，请将 USB 闪存驱动器插入您的 Mac。“启动转换助理”将使用它创建用于安装 Windows 的可引导的 USB 驱动器。
当“启动转换助理”要求您设置 Windows 分区的大小时，请务必遵循上一部分中所述的最低储存空间要求。由于这一分区大小在设置后无法更改，请设置一个能够满足您需求的大小。
### 2. 格式化 Windows (BOOTCAMP) 分区
在“启动转换助理”操作完成后，Mac 会重新启动至 Windows 安装器。如果安装器询问 Windows 的安装位置，请选择 BOOTCAMP 分区并点按“格式化”。在大多数情况下，安装器会自动选择 BOOTCAMP 并进行格式化。

### 3. 安装 Windows
请拔下在安装期间不需要使用的所有外部设备，如额外的显示器和驱动器。然后点按“继续”，并按照屏幕上的说明开始安装 Windows。

### 4. 在 Windows 中使用“启动转换”安装器
Windows 安装完成后，您的电脑 会在 Windows 中启动，并打开“欢迎使用‘启动转换’安装器”窗口。请按照屏幕上的说明来安装“启动转换”，其中包括 Windows 支持软件（驱动程序）。完成之后，系统将要求您重新启动。

如果“启动转换”安装器没有自动打开，则最后一步应该是手动打开“启动转换”安装器，并使用它完成安装。



### 如何在 Windows 和 macOS 之间切换



> 重新启动，然后在启动过程中按住 Option（或 Alt）⌥ 键，以便在 Windows 和 macOS 之间切换。

    图片之后补上等室友休假回来 使用Macbook Pro 演示