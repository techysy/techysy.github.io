---
layout: post
title: 本地部署大模型
date: 2026-03-10 08:00:00 +0800
img: LMStudio.png
tags: [blog,学习日志]
categories: 分享
---

    本地部署大模型使用率LM Studio和 Ollama 都比较高，LM Studio 更加强大，Ollama 更简单。
    LM Studio 可视化操作界面，更方便用户操作。更好下载和管理大模型。
    最初开始接触本地化部署就是从Ollama，那时候不知道量化模型的概念，就看到电脑空间少了🤣

+  最终选择 LM Studio 作为本地大模型的部署工具。
+  AI聊天客户端工具选择了ChatBox，Windows和iOS端都有，功能都比较完善。
+  后续也会考虑使用Cherry Studio 作为主要 的 AI工作台 配合知识库使用。


## LM Studio
> LM Studio 就是把 “本地跑大模型” 这件事，从复杂的命令行操作，变成了一个人人能用的桌面软件

官方地址：👉 [LM Studio](https://lmstudio.ai/)

![LM Studio]({{site.baseurl}}/assets/img/relearn-ai/LMStudio.webp)

## ChatBox
> 轻量型 AI 聊天客户端（主打对话 + 基础文件 + 跨平台）
> 全平台覆盖、本地优先、轻量化、零配置上手

官方地址：👉 [ChatBox](https://chatbox.ai/)

![ChatBox]({{site.baseurl}}/assets/img/relearn-ai/ChatBox.webp)

## Cherry Studio
> 全能型 AI 生产力平台（多模型 + 知识库 + 文件处理 + 智能体）
> 功能全面、多模型对比、知识库、思考可视化

官方地址：👉 [Cherry Studio](https://cherrystudio.ai/)

![Cherry Studio]({{site.baseurl}}/assets/img/relearn-ai/CherryStudio.png)

## 实例
> 下面是一些使用 ChatBox 的实例

默认预设了一些写好提示词的对话助手例如：
+ 翻译助手
+ 夸夸机
+ 小红书文案生成器
+ 贪吃蛇小游戏

使用同样的提示词分别使用 qwen3.5-9b 和 deepseek-r1-0528-qwen3-8b进行对话。

> qwen3.5-9b 生成结果：

#### 网页链接：
[Tailwind CSS 贪吃蛇](https://mcp.edgeone.site/share/ooKmamhfSZLGmvIjlSxbh)

#### 效果图：
![贪吃蛇游戏]({{site.baseurl}}/assets/img/relearn-ai/snake-qwen.png)

> deepseek-r1-0528-qwen3-8b 生成结果：

#### 网页链接(无法正常运行)： 
[贪吃蛇游戏](https://mcp.edgeone.site/share/lIxZWKjdgiGDkYEcYnBB_)

#### 效果图：
![贪吃蛇游戏]({{site.baseurl}}/assets/img/relearn-ai/snake-ds.png)