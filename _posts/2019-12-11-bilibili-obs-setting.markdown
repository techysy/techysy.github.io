---
layout: post
title: 如何使用OBS Studio给B站直播推流
date: 2019-12-11 00:00:00 +0800
img: bilibili-obs.jpg
tags: [教程]
categories: obs
---

1. 下载OBS-Studio软件
    
    <a href="https://pan.baidu.com/s/1DAcrCoRIRCrCZGnmr3lK1Q" target="_blank">百度云链接</a>   提取码：yv6d


2. 安装OBS-Studio软件

    * 双击打开 → (确认安装) Next> → (同意用户协议) I Agree → (设置安装路径) Next> 

      → (默认不安装实感摄像头插件) Install → (安装完成勾上Launch OBS Studio) Finish 


3. 配置OBS-Studio软件

    * 获取哔哩哔哩直播码

         打开直播中心 → 我的直播间 → 点击 "开始直播"按钮 获取直播码：

            你的rtmp地址："rtmp://txy.live-send.acg.tv/live-txy/"

            你的直播码："?streamname=live_10419858_6368653&key=xxxxxxxxxx"

    * 设置OBS-Studio的推流链接

        打开设置 → 推流 → 服务选项框选择"自定义"

            服务器 = rtmp地址 ："rtmp://txy.live-send.acg.tv/xxxxxxxxxx""

            串流密钥 = 直播码 ："?streamname=live_10419858_6368653&key=xxxxxxxxxx"

    * 设置直播码率

        打开设置 → 输出
            
            🎬 默认视频码率 "2500Kbps" 可以根据你的网络带宽和需求调整 

                编码器 建议使用软解 "X264" AMD YES 👌  硬解的话 NVIDIA YES 🐶 (具体情况还得看你系统资源分配)

            🎤 默认音频码率 "160" 个人喜欢设置为192 看上去像一个整数

    * 设置录屏码率

        打开设置 → 输出
