---
layout: post
title: 如何使用OBS给B站直播推流
date: 2019-12-11 11:11:11 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: bilibili-obs.jpg
tags: [教程, Bilibili, OBS]
categories: 教程
description: 从零开始配置OBS Studio，教你如何给B站直播推流，包含详细的设置步骤和实用技巧
---

使用 OBS Studio 可以轻松实现 B 站直播推流，支持屏幕捕捉、窗口录制、摄像头、自定义场景等功能。本文将详细介绍从安装到开播的完整流程。

## 目录

- [1. 下载 OBS Studio](#1-下载-obs-studio)
- [2. 安装 OBS Studio](#2-安装-obs-studio)
- [3. 配置推流参数](#3-配置推流参数)
- [4. 设置直播场景](#4-设置直播场景)
- [5. 开始直播](#5-开始直播)
- [6. 实用插件推荐](#6-实用插件推荐)

## 1. 下载 OBS Studio

建议从官方网站下载最新版本：

- **官方网站**：[https://obsproject.com/](https://obsproject.com/)
- **GitHub 下载**：[https://github.com/obsproject/obs-studio/releases](https://github.com/obsproject/obs-studio/releases)

> **注意**：下载与系统对应的版本（Windows / macOS / Linux），推荐使用稳定版（Stable）。

## 2. 安装 OBS Studio

![setup]({{site.baseurl}}/assets/img/bilibili-obs/setup.jpg)

安装步骤：

1. 双击打开安装包
2. 点击 `Next >` 确认安装
3. 选择 `I Agree` 同意用户协议
4. 设置安装路径（建议保持默认）
5. 取消勾选不必要的插件（如实感摄像头插件）
6. 点击 `Install` 开始安装
7. 安装完成后点击 `Finish` 启动 OBS Studio

## 3. 配置推流参数

### 3.1 获取 B 站直播码

![bilibili]({{site.baseurl}}/assets/img/bilibili-obs/bilibili.jpg)

1. 登录 B 站，进入 [直播中心](https://link.bilibili.com/p/center/index)
2. 点击「我的直播间」
3. 点击「开始直播」按钮获取直播码

直播码包含两部分：

```
RTMP 地址：rtmp://txy.live-send.acg.tv/live-txy/
直播码：?streamname=live_xxxxxxxx_xxxxxxxx&key=xxxxxxxxxx
```

> **重要**：直播码是敏感信息，请勿泄露给他人，否则可能被他人盗用直播。

### 3.2 设置推流链接

![rtmp]({{site.baseurl}}/assets/img/bilibili-obs/rtmp.jpg)

1. 打开 OBS，点击菜单栏「文件」→「设置」
2. 在左侧选择「推流」
3. 服务选项框选择「自定义」
4. 填写推流信息：
   - **服务器**：粘贴 RTMP 地址
   - **串流密钥**：粘贴直播码

### 3.3 设置输出参数

![output]({{site.baseurl}}/assets/img/bilibili-obs/output.jpg)

1. 在设置中选择「输出」选项卡

#### 直播码率设置

- **视频码率**：根据网络带宽调整，建议设置为 **3000-6000 Kbps**
  - 1080p 画质建议 4000-6000 Kbps
  - 720p 画质建议 2000-3000 Kbps
- **编码器**：
  - NVIDIA 用户选择「NVENC H.264」（硬件加速，CPU 占用低）
  - AMD 用户选择「AMD AMF H.264」
  - 无独显用户选择「x264」（软件编码，画质更好但 CPU 占用高）
- **音频码率**：建议设置为 **192 Kbps**（音质与文件大小的平衡点）

#### 录像设置

- **录像路径**：默认在用户目录的视频文件夹下，可自定义
- **录像质量**：
  - 选择「与直播串流相同」：直播时无法暂停，文件较小
  - 选择「高质量」或「无损」：支持暂停，但文件较大

### 3.4 视频设置

1. 在设置中选择「视频」选项卡

- **基础分辨率**：设置为显示器分辨率（如 1920×1080）
- **输出分辨率**：根据直播需求设置
- **帧率**：建议设置为 **30 FPS**（常规直播）或 **60 FPS**（游戏直播）

### 3.5 音频设置

1. 在设置中选择「音频」选项卡

- **麦克风/辅助音频**：选择正确的音频输入设备
- **桌面音频**：确保系统声音可以被捕获
- **音频采样率**：保持默认 44.1 kHz 即可

### 3.6 高级设置

1. 在设置中选择「高级」选项卡

- **延迟**：根据网络情况调整，建议设置为 0-2 秒
- **关键帧间隔**：设置为 2（B 站推荐）
- **预设**：选择「非常快」或「超快」以降低 CPU 占用

## 4. 设置直播场景

![main]({{site.baseurl}}/assets/img/bilibili-obs/main.jpg)

OBS 的核心是场景系统，可以灵活组合各种来源：

### 场景管理

- **场景**：可以创建多个场景，例如「日常直播」「游戏直播」「节日主题」等
- **来源**：每个场景可以添加多种来源：
  - **显示器捕获**：捕捉整个屏幕
  - **窗口捕获**：只捕捉特定窗口
  - **视频捕获设备**：摄像头画面
  - **图像**：添加背景图或 Logo
  - **文本**：添加自定义文字
  - **音频输入捕获**：麦克风
  - **音频输出捕获**：系统声音

### 混音器

- 调整每个音频源的音量
- 可以设置静音、降噪等效果

### 转场特效

- 设置场景切换时的过渡动画
- 推荐使用「淡入淡出」效果

## 5. 开始直播

![live]({{site.baseurl}}/assets/img/bilibili-obs/live.jpg)

1. 确认所有设置正确后，点击右下角「开始推流」按钮
2. 状态栏会实时显示：
   - 直播/录屏时长
   - CPU 占用率
   - 帧率（FPS）
   - 码率（Bitrate）

![retry]({{site.baseurl}}/assets/img/bilibili-obs/retry.jpg)

如果连接失败，左下角会显示重连提示，常见原因：

- 网络不稳定
- 直播码过期（重新获取即可）
- 服务器维护

## 6. 实用插件推荐

### 6.1 OBS Virtual Camera
- **功能**：将 OBS 画面作为虚拟摄像头输出
- **用途**：在 Zoom、钉钉等视频会议软件中使用 OBS 的场景
- **安装**：OBS 内置，无需额外安装

### 6.2 StreamFX
- **功能**：提供丰富的滤镜和特效
- **用途**：添加模糊背景、美颜、自定义转场等
- **下载**：[https://github.com/Xaymar/obs-StreamFX](https://github.com/Xaymar/obs-StreamFX)

### 6.3 OBS WebSocket
- **功能**：通过 WebSocket 控制 OBS
- **用途**：配合手机 App 远程控制直播
- **下载**：[https://github.com/obsproject/obs-websocket](https://github.com/obsproject/obs-websocket)

### 6.4 Advanced Scene Switcher
- **功能**：根据窗口标题、进程等自动切换场景
- **用途**：游戏直播时自动切换不同游戏场景
- **下载**：[https://obsproject.com/forum/resources/advanced-scene-switcher.395/](https://obsproject.com/forum/resources/advanced-scene-switcher.395/)

### 6.5 Noise Suppression
- **功能**：实时降噪，消除背景杂音
- **用途**：改善麦克风音质
- **安装**：OBS 内置，在音频滤镜中添加

---

**结语**：OBS Studio 是一款功能强大且完全免费的直播软件，掌握好基础设置后可以实现各种复杂的直播效果。建议多练习场景切换和滤镜使用，打造独一无二的直播风格！