---
layout: post
title: Jekyll 博客集成 Disqus 评论系统
date: 2021-11-30 08:00:00 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: disqus.png
tags: [Disqus, Jekyll, 博客, 评论系统, 野生技术协会]
categories: 分享
description: 详细介绍如何在 Jekyll 博客中集成 Disqus 评论系统，包括配置步骤、常见问题及国内访问解决方案
---

Disqus 是一款广泛使用的第三方评论系统，为静态博客提供了完整的评论功能支持。本文将详细介绍如何在 Jekyll 博客中集成 Disqus 评论系统。

## 目录

- [什么是 Disqus](#什么是-disqus)
- [注册 Disqus 账号](#注册-disqus-账号)
- [配置 Jekyll](#配置-jekyll)
- [创建评论组件](#创建评论组件)
- [集成到文章页面](#集成到文章页面)
- [国内访问问题](#国内访问问题)
- [常见问题](#常见问题)
- [总结](#总结)

## 什么是 Disqus

**Disqus** 是一款云端评论托管服务，为网站提供评论、投票和社交分享功能。

### 主要特点

| 特点 | 说明 |
|------|------|
| 即插即用 | 几行代码即可集成到任何网站 |
| 社交登录 | 支持 Google、Facebook、Twitter 等社交账号登录 |
| 反垃圾评论 | 内置垃圾评论过滤功能 |
| 多平台支持 | 支持 Web、移动端和平板设备 |
| SEO 友好 | 评论内容可被搜索引擎索引 |
| 数据导出 | 支持导出评论数据 |

### 适用场景

- 个人博客
- 新闻网站
- 论坛社区
- 任何需要评论功能的网站

## 注册 Disqus 账号

### 步骤 1：访问 Disqus 官网

打开 [https://disqus.com/](https://disqus.com/)，点击「Get Started」。

### 步骤 2：选择安装方式

点击「I want to install Disqus on my site」。

### 步骤 3：填写网站信息

| 字段 | 说明 | 示例 |
|------|------|------|
| Website Name | 网站名称 | techysy |
| Category | 网站分类 | Tech |
| Language | 评论系统语言 | 中文（建议英文） |

### 步骤 4：选择安装计划

| 计划 | 价格 | 功能 |
|------|------|------|
| Basic | 免费 | 基本评论功能，广告支持 |
| Plus | $9/月 | 无广告，自定义主题 |
| Pro | $99/月 | 专业功能，高级支持 |

对于个人博客，**Basic 计划**已经足够使用。

### 步骤 5：获取 Shortname

安装完成后，在控制台首页可以看到你的 **Shortname**，这是后续配置必需的信息。

```
# 示例 shortname
techysy-blog
```

## 配置 Jekyll

### 方法一：修改 _config.yml

在 Jekyll 站点的 `_config.yml` 配置文件中添加 Disqus 配置：

```yaml
# Disqus 评论系统配置
disqus:
  enabled: true
  shortname: your-disqus-shortname  # 替换为你的 shortname
  count: true                       # 显示评论数量
```

### 方法二：直接添加到配置文件

```yaml
# Disqus 配置
disqus_shortname: your-disqus-shortname
```

## 创建评论组件

### 创建 _includes/disqus.html

在 `_includes` 目录下创建 `disqus.html` 文件：

```html
{% raw %}{% if page.comments != false and site.disqus.enabled %}
<div id="disqus_thread"></div>
<script>
    var disqus_config = function () {
        this.page.url = "{{ page.url | absolute_url }}";
        this.page.identifier = "{{ page.url }}";
        this.page.title = "{{ page.title }}";
    };
    
    (function() {
        var d = document, s = d.createElement('script');
        s.src = 'https://{{ site.disqus.shortname }}.disqus.com/embed.js';
        s.setAttribute('data-timestamp', +new Date());
        (d.head || d.body).appendChild(s);
    })();
</script>
<noscript>
    请启用 JavaScript 以查看 <a href="https://disqus.com/?ref_noscript">Disqus 评论</a>
</noscript>
{% endif %}{% endraw %}
```

### 创建评论计数组件

在 `_includes` 目录下创建 `disqus_count.html` 文件：

```html
{% raw %}{% if site.disqus.enabled %}
<script id="dsq-count-scr" src="https://{{ site.disqus.shortname }}.disqus.com/count.js" async></script>
{% endif %}{% endraw %}
```

## 集成到文章页面

### 1. 在文章布局中添加评论

编辑 `_layouts/post.html`，在内容区域下方添加评论组件：

```html
{% raw %}<div class="post-content">
    {{ content }}
</div>

<!-- 评论区域 -->
{% if site.disqus.enabled %}
<div class="post-comments">
    {% include disqus.html %}
</div>
{% endif %}{% endraw %}
```

### 2. 添加评论计数

在文章列表或其他需要显示评论数的地方添加：

```html
{% raw %}{% if site.disqus.enabled %}
<span class="disqus-comment-count" data-disqus-identifier="{{ post.url }}">
    <a href="{{ post.url | absolute_url }}#disqus_thread">评论</a>
</span>
{% endif %}{% endraw %}
```

### 3. 引入计数脚本

在 `head.html` 或文章页面中添加计数脚本的引用：

```html
{% raw %}{% include disqus_count.html %}{% endraw %}
```

### 4. 控制单篇文章是否显示评论

在文章头部的 Front Matter 中添加：

```yaml
---
layout: post
title: 文章标题
comments: true   # 显示评论
---

# 或

---
layout: post
title: 文章标题
comments: false  # 隐藏评论
---
```

## 国内访问问题

Disqus 在中国大陆无法直接访问，需要特殊处理。

### 问题表现

- 评论框无法加载
- 显示空白或错误提示
- 评论数量显示不出来

### 解决方案一：使用代理

如果你的网站部署在可以科学上网的服务器上，可以：

1. 在服务器上配置反向代理
2. 将 Disqus 的 JS 域名代理到国内可访问的地址

### 解决方案二：使用国内评论系统替代

| 评论系统 | 特点 | 适用场景 |
|----------|------|----------|
| Gitalk | 基于 GitHub Issues | 开源项目博客 |
| Valine | 轻量级，无需登录 | 静态博客 |
| 畅言 | 国内服务 | 国内网站 |
| 来必力 | 韩国服务 | 外贸网站 |

### 解决方案三：使用 Gitalk（推荐）

Gitalk 是一个基于 GitHub Issues 的评论系统，国内访问无障碍。

**安装步骤**：

1. 在 GitHub 申请 OAuth App
2. 在 Jekyll 中引入 Gitalk 资源：

```html
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.css">
<script src="https://cdn.jsdelivr.net/npm/gitalk@1/dist/gitalk.min.js"></script>
```

3. 添加 Gitalk 初始化脚本：

```html
<div id="gitalk-container"></div>
<script>
    var gitalk = new Gitalk({
        clientID: 'your-client-id',
        clientSecret: 'your-client-secret',
        repo: 'your-repo',
        owner: 'your-github-username',
        admin: ['your-github-username'],
        id: location.pathname,
        distractionFreeMode: false
    });
    gitalk.render('gitalk-container');
</script>
```

## 常见问题

### Q1：Disqus 评论不显示

**可能原因**：

1. 网站地址配置错误
2. Shortname 不正确
3. 网络问题（国内无法访问）

**解决方案**：

1. 检查 `_config.yml` 中的 shortname 是否正确
2. 检查浏览器控制台是否有错误信息
3. 确认页面 URL 是否正确设置

### Q2：评论数量显示为 0

**可能原因**：

1. 页面首次加载时 Disqus 需要同步数据
2. 评论数量统计有延迟
3. 页面标识符（identifier）不一致

**解决方案**：

1. 等待几分钟后刷新页面
2. 确保每个页面的 identifier 唯一且稳定
3. 检查 count.js 脚本是否正确加载

### Q3：如何开启评论审核？

**解决方案**：

1. 登录 Disqus 控制台
2. 进入「Settings」→「General」
3. 找到「Community」设置
4. 开启「Review each comment before it appears」

### Q4：如何自定义评论样式？

**解决方案**：

在 Disqus 控制台中：

1. 进入「Settings」→「Appearance」
2. 自定义评论框颜色、字体等样式
3. 点击「Publish」应用更改

### Q5：如何迁移现有评论？

**解决方案**：

Disqus 支持导入评论数据：

1. 进入「Settings」→「Community」→「Community Settings」
2. 找到「Import Export」
3. 选择导入格式（WordPress、TypePad 等）
4. 上传数据文件

## 总结

Disqus 是一款功能强大的评论系统，适合需要国际化支持的博客网站。

**优势**：

- 功能完善，界面友好
- 社交登录方便用户评论
- 反垃圾评论功能强大
- 数据可导出迁移

**不足**：

- 国内访问受限
- 免费版有广告
- 需要维护 Disqus 账号

**建议**：

- 如果网站主要面向国内用户，建议使用 Gitalk 或 Valine
- 如果需要国际化支持，可以保留 Disqus 并提供备选方案
- 定期备份评论数据，防止数据丢失

---

**参考资源**：

- **Disqus 官网**：[https://disqus.com/](https://disqus.com/)
- **Disqus 官方文档**：[https://help.disqus.com/](https://help.disqus.com/)
- **Jekyll + Disqus 集成教程**：[https://抵消多余空行.github.io/2017/02/20/jekyll-disqus.html](https://抵消多余空行.github.io/2017/02/20/jekyll-disqus.html)