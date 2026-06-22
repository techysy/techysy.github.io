---
layout: post
title: Jekyll 迁移 Hugo 完全指南
date: 2026-06-22 10:00:00 +0800
img: hugo-logo.png
tags: [blog,技术文档,Hugo,Jekyll,静态网站]
categories: 分享
---

Jekyll 作为 GitHub Pages 原生支持的静态网站生成器，曾经是搭建个人博客的首选。但随着 Hugo、Hexo、Astro 等现代框架的崛起，Jekyll 在构建速度、主题生态、开发体验等方面逐渐落后。本文记录将个人博客从 Jekyll 迁移到 Hugo 的完整过程。

## 一、为什么迁移？

### Jekyll 的痛点

+  **构建速度慢**：Ruby 生态，文章多了之后构建时间明显增长
+  **主题生态萎缩**：新主题数量远不如 Hugo/Hexo
+  **插件更新滞后**：社区活跃度下降，部分插件长期未维护
+  **Liquid 模板语法**：相对老旧，调试不方便

### Hugo 的优势

+  **构建速度极快**：Go 语言编写，毫秒级构建
+  **主题丰富**：Hugo Themes 收录数百个高质量主题
+  **无需运行时依赖**：单个二进制文件，开箱即用
+  **模板语法灵活**：Go template 功能强大

### 迁移前评估

| 维度 | Jekyll | Hugo |
|------|--------|------|
| 构建速度 | 慢（秒级） | 极快（毫秒级） |
| 主题数量 | ~500 | ~400+ |
| 部署到 GH Pages | 原生支持 | 需 GitHub Actions |
| 学习成本 | 低 | 中 |
| 插件生态 | 成熟但萎缩 | 活跃且增长中 |

---

## 二、环境准备

### 1. 安装 Hugo

**macOS**：

```bash
brew install hugo
```

**Windows**：

```bash
winget install Hugo.Hugo.Extended
```

**Linux**：

```bash
sudo snap install hugo
```

验证安装：

```bash
hugo version
```

### 2. 创建 Hugo 站点

```bash
hugo new site my-blog
cd my-blog
```

生成的目录结构：

```
my-blog/
├── archetypes/
├── assets/
├── content/
├── data/
├── i18n/
├── layouts/
├── static/
├── themes/
├── hugo.toml
└── go.mod
```

---

## 三、目录结构对比

### Jekyll 目录结构

```
├── _config.yml          # 配置文件
├── _posts/              # 文章目录
├── _layouts/            # 布局模板
├── _includes/           # 可复用组件
├── _pages/              # 静态页面
├── assets/              # 静态资源
└── _site/               # 构建输出
```

### Hugo 目录结构

```
├── hugo.toml            # 配置文件（替代 _config.yml）
├── content/             # 所有内容（替代 _posts + _pages）
│   └── posts/           # 文章
├── layouts/             # 布局模板（替代 _layouts + _includes）
├── archetypes/          # 内容模板
├── static/              # 静态资源（直接复制到输出）
├── assets/              # 需要处理的资源（CSS/JS）
├── data/                # 数据文件
└── themes/              # 主题目录
```

**关键区别**：

| Jekyll | Hugo | 说明 |
|--------|------|------|
| `_posts/` | `content/posts/` | 文章目录 |
| `_pages/` | `content/` 下直接创建 | 静态页面 |
| `_layouts/` | `layouts/` | 布局模板 |
| `_includes/` | `layouts/partials/` | 可复用组件 |
| `_config.yml` | `hugo.toml` | 配置文件 |
| `_site/` | `public/` | 构建输出 |

---

## 四、配置文件迁移

### Jekyll 配置 (`_config.yml`)

```yaml
title: 余师洋的个人博客
email: i@shiyangyu.com
description: 余师洋的个人博客
url: "https://shiyangyu.com/"
baseurl: ""

author: Yu ShiYanG
github: techysy

paginate: 8
paginate_path: /page:num/

markdown: kramdown
plugins:
  - jekyll-paginate
  - jekyll-feed
  - jekyll-sitemap
```

### Hugo 配置 (`hugo.toml`)

```toml
baseURL = 'https://shiyangyu.com/'
languageCode = 'zh-CN'
title = '余师洋的个人博客'
theme = 'PaperMod'

[params]
  author = 'Yu ShiYanG'
  description = '余师洋的个人博客'
  github = 'techysy'
  email = 'i@shiyangyu.com'

[pagination]
  paginate = 8

[outputs]
  home = ["HTML", "RSS", "JSON"]

[markup]
  [markup.goldmark]
    [markup.goldmark.renderer]
      unsafe = true
```

---

## 五、文章迁移

### Front Matter 转换

**Jekyll 格式**：

```yaml
---
layout: post
title: 本地部署大模型
date: 2026-03-10 08:00:00 +0800
img: LMStudio.png
tags: [blog,学习日志]
categories: 分享
---
```

**Hugo 格式**：

```yaml
---
title: "本地部署大模型"
date: 2026-03-10T08:00:00+08:00
draft: false
tags: ["blog", "学习日志"]
categories: ["分享"]
---
```

**转换要点**：

+  移除 `layout` 字段（Hugo 由主题决定布局）
+  `date` 格式改为 ISO 8601（`T` 分隔日期和时间）
+  新增 `draft: false`（Hugo 默认不构建草稿）
+  `img` 字段根据主题要求调整
+  `categories` 在 Hugo 中需要提前定义或使用主题默认

### 批量迁移脚本

**Python 脚本**（推荐）：

```python
import os
import re
from datetime import datetime

posts_dir = '_posts'
output_dir = 'content/posts'

os.makedirs(output_dir, exist_ok=True)

for filename in os.listdir(posts_dir):
    if not filename.endswith(('.md', '.markdown')):
        continue
    
    filepath = os.path.join(posts_dir, filename)
    
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # 提取 front matter
    match = re.match(r'^---\n(.*?)\n---\n(.*)$', content, re.DOTALL)
    if not match:
        continue
    
    front_matter = match.group(1)
    body = match.group(2)
    
    # 解析字段
    title = re.search(r'title:\s*(.+)', front_matter)
    date = re.search(r'date:\s*(.+)', front_matter)
    tags = re.search(r'tags:\s*\[(.+)\]', front_matter)
    categories = re.search(r'categories:\s*(.+)', front_matter)
    
    # 转换日期格式
    date_str = date.group(1).strip() if date else ''
    try:
        dt = datetime.strptime(date_str, '%Y-%m-%d %H:%M:%S %z')
        hugo_date = dt.isoformat()
    except:
        hugo_date = date_str
    
    # 构建 Hugo front matter
    hugo_fm = '---\n'
    hugo_fm += f'title: "{title.group(1).strip()}"\n' if title else 'title: "Untitled"\n'
    hugo_fm += f'date: {hugo_date}\n' if hugo_date else ''
    hugo_fm += 'draft: false\n'
    
    if tags:
        tag_list = [t.strip() for t in tags.group(1).split(',')]
        hugo_fm += f'tags: {tag_list}\n'
    
    if categories:
        cat = categories.group(1).strip()
        if cat.startswith('['):
            hugo_fm += f'categories: {cat}\n'
        else:
            hugo_fm += f'categories: ["{cat}"]\n'
    
    hugo_fm += '---\n\n'
    
    # 处理内容中的图片路径
    body = re.sub(
        r'\{\{site\.baseurl\}\}/assets/img/',
        '/images/',
        body
    )
    
    # 写入新文件
    new_filename = filename.replace('.markdown', '.md')
    output_path = os.path.join(output_dir, new_filename)
    
    with open(output_path, 'w', encoding='utf-8') as f:
        f.write(hugo_fm + body)
    
    print(f'Migrated: {filename} -> {new_filename}')
```

---

## 六、模板迁移

### 布局文件对应关系

| Jekyll | Hugo | 用途 |
|--------|------|------|
| `_layouts/default.html` | `layouts/_default/baseof.html` | 基础布局 |
| `_layouts/post.html` | `layouts/_default/single.html` | 文章页 |
| `_layouts/home-page.html` | `layouts/index.html` | 首页 |
| `_includes/header.html` | `layouts/partials/header.html` | 头部导航 |
| `_includes/footer.html` | `layouts/partials/footer.html` | 页脚 |
| `_includes/head.html` | `layouts/partials/head.html` | HTML head |

### Liquid 语法转 Go Template

**Jekyll (Liquid)**：

```html
{% for post in site.posts %}
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <p>{{ post.date | date: "%Y-%m-%d" }}</p>
  <p>{{ post.excerpt }}</p>
{% endfor %}
```

**Hugo (Go Template)**：

```html
{{ range (where site.RegularPages "Section" "posts") }}
  <h2><a href="{{ .RelPermalink }}">{{ .Title }}</a></h2>
  <p>{{ .Date.Format "2006-01-02" }}</p>
  <p>{{ .Summary }}</p>
{{ end }}
```

**常用语法对照**：

| Liquid | Go Template | 说明 |
|--------|-------------|------|
| `{{ post.url }}` | `{{ .RelPermalink }}` | 相对 URL |
| `{{ post.title }}` | `{{ .Title }}` | 标题 |
| `{{ post.content }}` | `{{ .Content }}` | 内容 |
| `{{ post.excerpt }}` | `{{ .Summary }}` | 摘要 |
| `{{ post.date }}` | `{{ .Date }}` | 日期 |
| `{{ site.time }}` | `{{ now }}` | 当前时间 |
| `{% if condition %}` | `{{ if condition }}` | 条件判断 |
| `{% for item in list %}` | `{{ range list }}` | 循环 |
| `{{ variable \| filter }}` | `{{ filter variable }}` | 过滤器 |

---

## 七、主题选择

### 推荐主题

| 主题 | 特点 | 适合场景 |
|------|------|----------|
| **PaperMod** | 简洁、快速、功能全 | 个人博客（推荐） |
| **Hugo Coder** | 极简、响应式 | 技术博客 |
| **Stack** | 现代、分类清晰 | 知识库 |
| **Blowfish** | 功能丰富、美观 | 综合博客 |

### 安装主题（以 PaperMod 为例）

```bash
# 方式一：Git submodule（推荐）
git init
git submodule add --depth=1 https://github.com/adityatelange/hugo-PaperMod.git themes/PaperMod

# 方式二：Hugo module
hugo mod init github.com/your-username/your-blog
hugo mod get github.com/adityatelange/hugo-PaperMod
```

### 主题配置

在 `hugo.toml` 中配置 PaperMod：

```toml
theme = 'PaperMod'

[params]
  defaultTheme = 'auto'
  showReadingTime = true
  showShareButtons = false
  showPostNavLinks = true
  showBreadCrumbs = true
  showCodeCopyButtons = true
  showToc = true
  tocOpen = true

[params.homeInfoParams]
  Title = '👋 Hi there'
  Content = '欢迎来到我的博客'

[[params.socialIcons]]
  name = 'github'
  url = 'https://github.com/techysy'

[menu]
  [[menu.main]]
    identifier = 'posts'
    name = '文章'
    url = '/posts/'
    weight = 1
  [[menu.main]]
    identifier = 'tags'
    name = '标签'
    url = '/tags/'
    weight = 2
  [[menu.main]]
    identifier = 'archives'
    name = '归档'
    url = '/archives/'
    weight = 3
  [[menu.main]]
    identifier = 'about'
    name = '关于'
    url = '/about/'
    weight = 4
```

---

## 八、静态资源处理

### 图片迁移

```bash
# 创建图片目录
mkdir -p static/images

# 复制 Jekyll 的图片
cp -r assets/img/* static/images/
```

### 图片引用修改

**Jekyll**：

```markdown
![图片描述]({{site.baseurl}}/assets/img/photo.png)
```

**Hugo**：

```markdown
![图片描述](/images/photo.png)
```

### CSS/JS 迁移

Jekyll 的 `assets/` 目录中如果有自定义 CSS/JS：

```bash
# 需要处理的资源放 assets/
# 直接复制的静态文件放 static/
```

**Hugo assets 处理**：

```html
{{ $style := resources.Get "css/style.css" | minify }}
<link rel="stylesheet" href="{{ $style.RelPermalink }}">
```

---

## 九、GitHub Actions 部署

### Jekyll 部署方式

Jekyll 可以直接使用 GitHub Pages 的内置构建，但更推荐使用 Actions：

```yaml
# .github/workflows/deploy.yml（Jekyll）
- name: Build Jekyll site
  run: bundle exec jekyll build
```

### Hugo 部署方式

Hugo 必须使用 GitHub Actions：

```yaml
# .github/workflows/deploy.yml（Hugo）
name: Deploy Hugo to GitHub Pages

on:
  push:
    branches:
      - main

permissions:
  contents: read
  pages: write
  id-token: write

concurrency:
  group: "pages"
  cancel-in-progress: false

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
        with:
          submodules: true
          fetch-depth: 0

      - name: Setup Hugo
        uses: peaceiris/actions-hugo@v3
        with:
          hugo-version: 'latest'
          extended: true

      - name: Build
        run: hugo --minify --gc

      - name: Upload Pages artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: 'public'

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 注意事项

+  GitHub Pages 仓库需要设置为 **main** 分支（Hugo 默认）
+  如果保留 **master** 分支，修改 `on.push.branches` 为 `master`
+  主题作为 git submodule 时，确保 `submodules: true`

---

## 十、功能迁移清单

### 必须迁移

+  [ ] 配置文件 (`_config.yml` → `hugo.toml`)
+  [ ] 所有文章 (`_posts/` → `content/posts/`)
+  [ ] 静态页面 (`_pages/` → `content/`)
+  [ ] 静态资源 (`assets/` → `static/`)
+  [ ] 图片引用路径
+  [ ] RSS/Feed 配置
+  [ ] Sitemap 配置

### 可选迁移

+  [ ] 自定义模板（如果不用主题模板）
+  [ ] 评论系统（Disqus → Giscus 等）
+  [ ] 分析工具（Google Analytics 升级到 GA4）
+  [ ] 搜索功能（使用 Algolia 或本地搜索）
+  [ ] 分类/标签页面

---

## 十一、常见问题

### Q1: Hugo 构建后页面 404

检查 `baseURL` 是否正确，以及 `public/` 目录是否正确部署。

### Q2: 中文标签/分类无法显示

在 `hugo.toml` 中启用 taxonomy：

```toml
[taxonomies]
  tag = 'tags'
  category = 'categories'
```

### Q3: 图片路径不对

Hugo 的静态资源放在 `static/` 目录下，访问时不需要带 `static/` 前缀。

### Q4: 代码高亮不生效

Hugo 内置 Chroma 高亮引擎，配置：

```toml
[markup]
  [markup.highlight]
    codeFences = true
    lineNos = false
    style = 'monokai'
```

### Q5: RSS 订阅地址变了

Hugo 默认生成 `/index.xml`，可以在配置中自定义：

```toml
[outputs]
  home = ["HTML", "RSS"]
```

---

## 十二、迁移后验证

构建并本地预览：

```bash
hugo server -D
```

检查清单：

+  首页是否正常显示
+  文章列表是否完整
+  文章内容格式是否正确
+  图片是否正常加载
+  标签/分类页面是否正常
+  RSS 是否可订阅
+  搜索功能是否正常
+  移动端响应式是否正常

---

## 总结

Jekyll 到 Hugo 的迁移主要涉及以下步骤：

1.  安装 Hugo 并创建新站点
2.  转换配置文件和 Front Matter
3.  迁移文章和静态资源
4.  选择并配置主题
5.  适配模板语法（Liquid → Go Template）
6.  更新 GitHub Actions 部署流程
7.  测试验证所有功能

迁移完成后，你会体验到 Hugo 带来的极速构建和更丰富的主题生态。对于个人博客来说，这是一次值得的升级。
