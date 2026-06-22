---
layout: post
title: 迁移到 Hugo 后选哪个主题？博主实用推荐
date: 2026-06-22 12:00:00 +0800
img: hugo-themes.png
tags: [blog,技术文档,Hugo,主题,静态网站]
categories: 分享
---

从 Jekyll 迁移到 Hugo 之后，下一步就是选一个合适的主题。Hugo 官方主题库收录了数百个主题，质量参差不齐。本文根据个人博客的实际需求，推荐几个值得关注的 Hugo 主题。

## 一、选主题的核心考量

在选择主题之前，先明确几个关键需求：

+  **布局方式**：卡片网格 vs 列表式
+  **暗色模式**：是否支持 Light/Dark 切换
+  **搜索功能**：是否内置全文搜索
+  **标签/分类**：是否自动生成分类页
+  **响应式**：移动端体验是否良好
+  **维护状态**：主题是否还在更新

---

## 二、主题推荐

### 1. Stack（最推荐）

**GitHub**：[CaiJimmy/hugo-theme-stack](https://github.com/CaiJimmy/hugo-theme-stack)
**Stars**：3.5k+
**布局**：卡片网格

Stack 是目前最接近 Minimal Mistakes 风格的 Hugo 主题。如果你从 Jekyll 迁移过来，想要保持类似的卡片网格布局，Stack 是首选。

**核心特点**：

+  原生卡片网格布局（2列/3列自适应）
+  分类页和标签页自动生成
+  暗色模式支持
+  文章目录（TOC）自动生成
+  代码高亮和代码块复制按钮
+  搜索功能内置
+  社交链接支持

**安装**：

```bash
git submodule add https://github.com/CaiJimmy/hugo-theme-stack.git themes/hugo-theme-stack
```

**基础配置**：

```toml
theme = "hugo-theme-stack"

[params]
  defaultTheme = "auto"
  showReadingTime = true
  showShareButtons = true
  showPostNavLinks = true
  showBreadCrumbs = true
  showCodeCopyButtons = true
  showToc = true
  tocOpen = true

[params.style]
  defaultStyle = "default"
  predefinedColorSchemes = true
```

**适合场景**：从 Jekyll Minimal Mistakes 迁移、个人技术博客

---

### 2. Blowfish

**GitHub**：[nunocoracao/blowfish](https://github.com/nunocoracao/blowfish)
**Stars**：1k+
**布局**：卡片/列表可切换

Blowfish 是一个功能非常丰富的现代主题，基于 Tailwind CSS 构建。它的设计更加现代，支持多种布局方式。

**核心特点**：

+  支持卡片和列表两种布局切换
+  丰富的首页展示方式（Hero、Profile、Card 等）
+  暗色模式支持（跟随系统或手动切换）
+  标签云、分类页
+  搜索功能
+  代码高亮
+  图片懒加载和 WebP 支持
+  i18n 多语言支持

**安装**：

```bash
git submodule add https://github.com/nunocoracao/blowfish.git themes/blowfish
```

**基础配置**：

```toml
theme = "blowfish"

[params]
  defaultTheme = "auto"
  colorScheme = "blowfish"
  showReadingTime = true
  showShareButtons = true
  showPostNavLinks = true
  showBreadCrumbs = true
  showCodeCopyButtons = true
  showToc = true

[params.list]
  showBreadcrumbs = true
  showTableOfContents = true
```

**适合场景**：追求现代设计、功能丰富的个人博客

---

### 3. PaperMod

**GitHub**：[adityatelange/hugo-PaperMod](https://github.com/adityatelange/hugo-PaperMod)
**Stars**：9k+
**布局**：列表式

PaperMod 是目前最流行的 Hugo 主题，以简洁著称。虽然不是卡片网格布局，但胜在稳定、生态好、社区活跃。

**核心特点**：

+  极简设计，加载速度极快
+  暗色模式支持
+  全文搜索（Fuse.js）
+  文章目录（TOC）
+  代码高亮
+  SEO 优化
+  RSS 自动生成
+  多语言支持

**安装**：

```bash
git submodule add https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod
```

**基础配置**：

```toml
theme = "PaperMod"

[params]
  defaultTheme = "auto"
  showReadingTime = true
  showShareButtons = false
  showPostNavLinks = true
  showBreadCrumbs = true
  showCodeCopyButtons = true
  showToc = true
  tocOpen = true

[params.homeInfoParams]
  Title = "👋 Hi there"
  Content = "欢迎来到我的博客"

[[params.socialIcons]]
  name = "github"
  url = "https://github.com/your-username"
```

**适合场景**：追求简洁、不想折腾、注重阅读体验

---

### 4. Congo

**GitHub**：[jpanther/congo](https://github.com/jpanther/congo)
**Stars**：2k+
**布局**：多种首页布局可选

Congo 基于 Tailwind CSS，设计现代，支持多种首页布局（Hero、Card、Page 等），自定义程度高。

**核心特点**：

+  多种首页布局（Hero、Card、Page、Profile）
+  暗色模式支持
+  标签云、分类页
+  搜索功能
+  代码高亮
+  i18n 多语言支持
+  图片处理（懒加载、WebP）
+  响应式设计

**安装**：

```bash
git submodule add https://github.com/jpanther/congo.git themes/congo
```

**适合场景**：追求现代 Tailwind CSS 设计、需要灵活布局

---

### 5. Hugo Coder

**GitHub**：[lukeorth/hugo-coder](https://github.com/lukeorth/hugo-coder)
**Stars**：1k+
**布局**：极简列表

Hugo Coder 是一个极简风格的开发者博客主题，专注于内容本身。

**核心特点**：

+  极简设计，无多余装饰
+  暗色模式支持
+  响应式设计
+  代码高亮
+  社交链接
+  i18n 支持

**适合场景**：开发者个人博客、追求极简

---

## 三、对比总结

| 主题 | 布局 | 暗色模式 | 搜索 | Stars | 自定义难度 |
|------|------|----------|------|-------|------------|
| **Stack** | 卡片网格 | ✅ | ✅ | 3.5k | 中 |
| **Blowfish** | 卡片/列表 | ✅ | ✅ | 1k+ | 中 |
| **PaperMod** | 列表 | ✅ | ✅ | 9k | 低 |
| **Congo** | 多种 | ✅ | ✅ | 2k | 中 |
| **Hugo Coder** | 极简列表 | ✅ | ❌ | 1k | 低 |

---

## 四、迁移建议

### 从 Jekyll Minimal Mistakes 迁移

如果你当前使用的是 Minimal Mistakes 或类似的卡片网格布局，推荐选择：

1.  **Stack**：最接近的布局和功能
2.  **Blowfish**：更现代的设计

### 从简单 Jekyll 主题迁移

如果你当前使用的是简单的列表式布局，推荐选择：

1.  **PaperMod**：最简单、生态最好
2.  **Hugo Coder**：极简开发者风格

### 首页配置示例（Stack）

```toml
[params.homeInfoParams]
  Title = "👋 你好，我是 Yu ShiYanG"
  Content = "分享技术、生活和思考"

[[params.socialIcons]]
  name = "github"
  url = "https://github.com/techysy"

[[params.socialIcons]]
  name = "strava"
  url = "https://www.strava.com/athletes/yangyu"
```

### 分类/标签页配置

大多数主题默认会自动生成分类和标签页。如果需要手动配置：

```toml
[taxonomies]
  tag = "tags"
  category = "categories"
```

---

## 五、注意事项

### 主题更新

+  使用 Git Submodule 安装的主题，可以通过 `git submodule update --remote` 更新
+  使用 Hugo Module 安装的主题，可以通过 `hugo mod get -u` 更新

### 自定义样式

如果需要修改主题样式，优先使用 CSS Override 而不是直接修改主题文件：

+  创建 `assets/css/` 目录
+  添加自定义 CSS 文件
+  在布局文件中引入

### 图片迁移

从 Jekyll 迁移时，注意图片路径的变化：

| Jekyll | Hugo |
|--------|------|
| `{{site.baseurl}}/assets/img/xxx.png` | `/images/xxx.png` |

图片放在 `static/images/` 目录下，访问时不需要带 `static/` 前缀。

---

## 总结

选主题的核心是匹配自己的需求：

+  **要卡片网格布局** → Stack 或 Blowfish
+  **要极简和生态** → PaperMod
+  **要现代 Tailwind 设计** → Congo
+  **要开发者极简风格** → Hugo Coder

主题选好后，不要花太多时间在外观调整上。内容才是博客的核心，先把文章写起来，样式可以慢慢调。
