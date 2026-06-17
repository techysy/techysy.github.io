# CHANGELOG

## 2026-06-17

### 安全修复

1. **decompress 路径遍历漏洞 (Critical)**
   - 问题：`decompress@<4.2.1` 存在路径遍历漏洞（CVE-2021-23425），攻击者可通过恶意压缩文件写入任意文件
   - 严重程度：Critical (CVSS 9.8/10)
   - 修复：升级相关依赖版本
     - `gulp-imagemin`: ^3.2.0 → ^9.2.0
     - `gulp-webp`: ^3.0.0 → ^4.0.1
     - `imagemin-pngquant`: ^5.0.0 → ^9.0.2

2. **lodash.template 命令注入漏洞 (High)**
   - 问题：`lodash.template@<=4.5.0` 存在命令注入漏洞（CVE-2021-23337），攻击者可通过恶意模板输入执行任意命令
   - 严重程度：High (CVSS 7.2/10)
   - 修复：升级相关依赖版本
     - `gulp-autoprefixer`: ^3.1.1 → ^9.0.0
     - `gulp-cache`: ^0.4.6 → ^1.1.3

3. **axios SSRF 漏洞 (Moderate)**
   - 问题：`axios@<0.31.0` 在检查 `NO_PROXY` 规则时存在主机名规范化绕过漏洞（CVE-2023-45853）
   - 严重程度：Moderate (CVSS 6.3/10)
   - 修复：升级 `browser-sync` 从 ^2.18.8 → ^3.0.2

### 更新内容

1. **文章更新**
   - 更新了文章 `2019-12-11-bilibili-obs-setting.markdown`

### 文档

1. **CHANGELOG 添加**
   - 创建了项目变更日志文件 [CHANGELOG.md](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/CHANGELOG.md)

## 2026-06-16

### Bug 修复

1. **GitHub Actions 分支监听问题**
   - 问题：代码推送到 `master` 分支，但工作流监听的是 `main` 分支
   - 修复：在 [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L6) 中将分支从 `main` 改为 `master`

2. **npm ci 缺少锁文件**
   - 问题：`npm ci` 需要 `package-lock.json`，但项目中不存在该文件
   - 修复：在 [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L44) 中将命令从 `npm ci` 改为 `npm install --legacy-peer-deps`

3. **npm 缓存配置**
   - 问题：`setup-node` 配置了 `cache: 'npm'` 需要 `package-lock.json`
   - 修复：从 [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L39) 中移除 `cache: 'npm'`

4. **node-sass Python 版本不兼容**
   - 问题：`node-sass` 需要 Python 2，但 GitHub Actions Ubuntu 环境只有 Python 3
   - 修复：升级到 `gulp-sass@5.x` 和 `sass`（dart-sass），移除 `node-sass` 依赖

5. **gulp 版本升级**
   - 问题：`gulp-sass@5.x` 需要 `gulp@4.x`
   - 修复：在 [package.json](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/package.json#L12) 中将 `gulp` 从 `^3.9.1` 升级到 `^4.0.2`

6. **gulp 任务名称与变量名称冲突**
   - 问题：`var sass = require('gulp-sass')(...)` 与 `gulp.task('sass', ...)` 任务名称冲突，导致 "Task never defined: sass" 错误
   - 修复：将任务从 `sass` 重命名为 `compile-sass`，更新 [package.json](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/package.json#L22) 中的构建脚本

7. **pngquant-bin 缺少系统依赖**
   - 问题：`pngquant-bin` 在 Ubuntu 上编译需要 `libpng-dev`
   - 修复：在 [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L41-L42) 中添加 `sudo apt-get install -y libpng-dev` 步骤

8. **WebP 图片未复制到 _site 目录**
   - 问题：Jekyll 默认构建不会复制子目录中的 WebP 文件
   - 修复：在 [deploy.yml](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/.github/workflows/deploy.yml#L55-L56) 中添加 `cp -r assets/img/*.webp assets/img/**/*.webp _site/assets/img/` 步骤

9. **browserSync reload 调用修复**
   - 修复：修复了 `jekyll-rebuild` 和 `img` 任务中的 `browserSync.reload` 调用
   - 修复：修复了 `compile-sass` 任务中仅在 browserSync 激活时才调用 reload

### 改进

1. **package.json 构建脚本**
   - 添加 WebP 生成：`gulp sass && gulp webp` → `gulp compile-sass && gulp webp`

2. **gulpfile.js 语法升级**
   - 将 gulp 3.x 的数组式任务依赖升级为 gulp 4.x 的 `gulp.series()` 语法
   - 将 sass 编译器初始化移到任务内部，避免变量名称冲突

3. **Gemfile.lock 移除**
   - 移除 Windows 生成的 `Gemfile.lock`，避免跨平台依赖冲突

4. **部署工作流简化**
   - 从 CI 中移除了 Node.js 步骤，简化部署流程

5. **build.rb 集成**
   - 添加 WebP 生成到构建脚本并使用 build.rb

6. **README 更新**
   - 文档化 WebP 转换移至本地环境
   - 从 CI 中移除 Gulp/npm 构建步骤

### 内容更新

1. **文章更新**
   - 更新 `2019-12-11-bilibili-obs-setting.markdown`
   - 更新 `2026-06-16-uefi-refind-boot.markdown`
   - 更新 `_config.yml`
   - 删除 `2026-06-16-new-post.markdown`

## 2026-06-13

### 文档

1. **README 更新**
   - 更新 readme.md

## 2026-06-12

### 清理

1. **删除 package.json**
   - 移除 package.json 文件

## 2026-06-06

### 更新内容

1. **数据更新**
   - 更新 `tianfu-data.json`
   - 添加优化后的小数数据
   - 更新 `itt-data.json`

2. **页面更新**
   - 更新 `3d-print-threads.html`

## 2026-06-05

### 更新内容

1. **首页优化**
   - 优化首页内容

2. **结构更新**
   - 更新网站结构

3. **外部加载**
   - 添加外部加载 JSON 数据

4. **回滚操作**
   - 回滚了 `tianfu-itt.html` 的更新
