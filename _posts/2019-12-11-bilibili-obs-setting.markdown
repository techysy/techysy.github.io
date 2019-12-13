---
layout: post
title: 如何使用OBS给B站直播推流
date: 2019-12-11 11:11:11 +0800
img: bilibili-obs.jpg
tags: [教程,Bilibili]
categories: 教程
---

1. 下载OBS-Studio软件 
    
    * OBS-Studio 24.0.3 Windows x64
    
    >  <a href="https://pan.baidu.com/s/1DAcrCoRIRCrCZGnmr3lK1Q" target="_blank">百度云链接</a>   提取码：yv6d


2. 安装OBS-Studio软件 📦
     
     ![sutup]({{site.baseurl}}/assets/img/bilibili-obs/setup.jpg)  
     
    * 双击打开 → Next> (确认安装) → I Agree (同意用户协议) → Next> (设置安装路径) → Install (默认不勾选实感摄像头插件) → Finish (Launch OBS Studio)  


3. 配置OBS-Studio软件 ⚙️

    + 获取哔哩哔哩直播码

        ![bilibili]({{site.baseurl}}/assets/img/bilibili-obs/bilibili.jpg) 

         - 打开直播中心 → 我的直播间 → 点击 "开始直播"按钮 获取直播码：

                你的rtmp地址："rtmp://txy.live-send.acg.tv/live-txy/"

                你的直播码："?streamname=live_10419858_6368653&key=xxxxxxxxxx"

               
 

   + 设置OBS-Studio的推流链接

        ![rtmp]({{site.baseurl}}/assets/img/bilibili-obs/rtmp.jpg)

        - 打开设置 → 推流 → 服务选项框选择"自定义"

              服务器 = rtmp地址 ："rtmp://txy.live-send.acg.tv/xxxxxxxxxx"

              串流密钥 = 直播码 ："?streamname=live_10419858_6368653&key=xxxxxxxxxx"

 

    + 设置直播码率

        ![output]({{site.baseurl}}/assets/img/bilibili-obs/output.jpg)
    
    
        - 打开设置 → 输出

              🎬 默认视频码率 "2500Kbps" 可以根据你的网络带宽和需求调整 

              编码器 建议使用软解 "X264" AMD YES 👌 (具体情况还得看你系统资源  分配)

              🎤 默认音频码率 "160" 个人喜欢设置为192 看上去像一个整数

    + 设置录屏码率

        - 打开设置 → 输出

              路径默认在用户目录的视频文件夹下"C:\Users\i\Videos"  

              录像质量默认与直播串流画质相同 (直播时无法暂停）

              需要暂停请使用"高质量"或者"无损" (需要注意文件大小)



    + 其他设置

         音频 → 音频的输入输出以及相关设备的管理

         视频 → 分辨率和帧率的设置 默认为1920*1080 30p

         热键 → 可以自定义一些常用操作推流开关、录屏开关、音频静音、按住说话 …   

         高级 → "直播延迟"和"网络"的设置 … 

4. 设置直播面板

    ![main]({{site.baseurl}}/assets/img/bilibili-obs/main.jpg)

    * 添加"场景"提前排好版例如生日、节日、日常、游戏 …

    * 添加"来源"显示器、窗口、图片、文本、音频的输入输出、摄像头还有自定义浏览器 …

    * 混音器控制不同源的音频音量平衡

    * 转场特效 不同场景切换间的特效

    * 控件 最重要的几个控制开关

5. 开始直播 📺

    + 点击开始推流按钮

    ![live]({{site.baseurl}}/assets/img/bilibili-obs/live.jpg)

    - 此时状态栏会实时显示直播/录屏时长、CPU占用率、帧率、码率

    ![retry]({{site.baseurl}}/assets/img/bilibili-obs/retry.jpg)

    - 如果连接不上左下角就会显示重连提示
            
6. 插件

    未完待续 …