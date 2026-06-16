# 余师洋的个人博客

基于 Jekyll + Gulp 构建的静态博客，部署在 GitHub Pages。

## 技术栈

- **静态站点生成器**: Jekyll 4.x
- **构建工具**: Gulp 3.x
- **样式预处理**: SCSS (Sass)
- **前端框架**: jQuery 3.x
- **搜索功能**: SimpleJekyllSearch
- **部署平台**: GitHub Pages + GitHub Actions

## 安装

```bash
# 安装 Ruby 依赖
bundle install

# 安装 Node.js 依赖（使用 --legacy-peer-deps 兼容旧版 Gulp）
npm install --legacy-peer-deps
```

## 本地开发

### Windows 环境配置

由于项目依赖较旧（Gulp 3.x），Windows 环境需要特殊配置：

1. **安装 Ruby**（推荐安装到用户目录避免权限问题）：
   - 下载：https://github.com/oneclick/rubyinstaller2/releases
   - 安装路径建议：`C:\Users\<用户名>\Ruby34`
   - 安装时勾选 "MSYS2 development toolchain"

2. **配置环境变量**（每次新开终端需要执行）：
   ```powershell
   $env:Path = "C:\Users\<用户名>\Ruby34\bin;$env:Path"
   ```

3. **安装 Jekyll 和 Bundler**：
   ```powershell
   gem install jekyll bundler
   ```

4. **验证安装**：
   ```powershell
   ruby --version    # 应显示 3.x
   jekyll --version  # 应显示 4.x
   ```

### 启动本地服务器

```bash
# 编译 SCSS
npm run build

# 生成 WebP 图片（见下方说明）
powershell -ExecutionPolicy Bypass -File tools/convert-webp.ps1

# 启动本地服务器（推荐使用项目提供的脚本）
ruby serve.rb

# 或直接使用 Jekyll
jekyll serve --host 0.0.0.0 --port 4000
```

访问 http://localhost:4000 查看效果。

### WebP 图片转码

项目使用官方 `cwebp` 工具进行图片转码，无需安装额外的 npm 包：

```powershell
# 批量转换所有 JPG/PNG 图片为 WebP
powershell -ExecutionPolicy Bypass -File tools/convert-webp.ps1
```

**转换说明**：
- 工具目录：`tools/webp/libwebp-1.4.0-windows-x64/bin/cwebp.exe`
- 输出质量：80%（可在脚本中调整）
- 已转换的文件会被跳过，不会重复转换
- 平均压缩率：50-70%

**模板支持**：
- 首页文章卡片：CSS 背景图双重 URL（WebP + 原图降级）
- 文章详情页：`<picture>` 标签支持（WebP + 原图降级）

## 部署

项目使用 GitHub Actions 自动部署。

1. 推送代码到 `main` 分支
2. GitHub Actions 自动构建并部署到 GitHub Pages
3. 访问 https://shiyangyu.com 查看站点

### GitHub Pages 配置

- 仓库设置：Settings → Pages → Source 选择 "GitHub Actions"
- 自定义域名：shiyangyu.com
- 构建输出目录：`_site`

## 功能特性

- ✅ 响应式设计，支持移动端
- ✅ 文章分类与标签
- ✅ 全文搜索（支持模糊搜索）
- ✅ 代码高亮
- ✅ 评论系统（Disqus）
- ✅ 文章阅读时间统计
- ✅ 返回顶部按钮
- ✅ WebP 图片支持
- ✅ 完善的 SEO 优化（Meta 标签、结构化数据）
- ✅ Google Analytics 统计
- ✅ 百度统计

## 项目结构

```
techysy.github.io/
├── _includes/          # 可复用组件
├── _layouts/           # 页面布局模板
├── _pages/             # 静态页面
├── _posts/             # 博客文章
├── assets/
│   ├── css/sass/       # SCSS 样式文件
│   ├── fonts/          # 字体资源
│   ├── img/            # 图片资源（含 WebP 版本）
│   └── js/             # JavaScript 文件
├── tools/
│   ├── webp/           # WebP 转码工具（cwebp.exe）
│   └── convert-webp.ps1 # 批量转换脚本
├── .github/workflows/  # GitHub Actions 工作流
├── _config.yml         # Jekyll 配置
├── gulpfile.js         # Gulp 构建脚本
├── package.json        # Node.js 依赖
├── serve.rb            # 本地服务器启动脚本
└── build.rb            # 构建脚本
```

## 自定义配置

在 `_config.yml` 中修改以下配置：

```yaml
# 站点信息
title: 余师洋的个人博客
description: 余师洋的个人博客，分享技术、生活和思考
keywords: 技术博客, 编程, 开发, 生活

# 作者信息
author: Yu ShiYanG
email: i@shiyangyu.com

# 社交链接
github: techysy
weibo: yushiyang2010
bilibili: 10419858
```

## 编写文章

在 `_posts/` 目录下创建新文章，命名格式：`YYYY-MM-DD-title.markdown`

```markdown
---
layout: post
title: "文章标题"
date: 2026-06-16
img: cover.jpg
description: "文章描述（用于 SEO）"
keywords: "关键词1,关键词2"
tags: [标签1,标签2]
---

文章内容...
```

## 许可证

MIT License
