---
layout: post
title: 本地部署大模型
date: 2026-03-10 08:00:00 +0800
img: LMStudio.png
tags: [blog,学习日志]
categories: 分享
---

## LM Studio


### 构建本地环境
  
 + WSL 适用于Linux的Windows子系统
 
        >   wsl --install

![wsl]({{site.baseurl}}/assets/img/relearn/wsl.png)

 + Node.js (使用Docker下部署)

        >   docker pull node:24-alpine           # 拉取 Node.js Docker 镜像
        >   docker run -it --rm --entrypoint sh node:24-alpine   # 创建 Node.js 容器并启动一个 Shell 会话   
        >   node -v # Should print "v24.14.0".
        >   npm -v # Should print "11.9.0".

![docker]({{site.baseurl}}/assets/img/relearn/docker.png)