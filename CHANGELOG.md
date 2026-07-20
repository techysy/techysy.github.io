# CHANGELOG

## 2026-07-21

### 新增

1. **骑行活动发布平台** (`cycling-activity.html`)
   - 全新 GPX 轨迹渲染与骑行活动发布工具
   - Leaflet 地图显示轨迹，支持街道/卫星底图切换
   - Canvas 海拔剖面图，带距离/海拔刻度
   - 数据统计：距离、爬升、时长（按25km/h匀速计算）
   - 隧道/桥梁过滤：梯度检测去除GPS异常跳点，可调坡度阈值和平滑窗口
   - 电子骑友：匀速模拟骑行，实时动画沿轨迹前进，支持暂停/重置
   - 兴趣点 (POI)：在地图上标记厕所、拍照点、休息、补给点、饮水、注意等
   - POI 数据支持 JSON 导出/导入
   - 路书链接：输入 Strava / iGPSPORT / Garmin Connect 链接
   - 社交分享：微博、Twitter、复制链接
   - GPX 文件上传（点击/拖拽）与下载
   - 活动标题自动从 GPX 文件名读取
   - 响应式设计，支持移动端

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

### 构建修复

1. **Jekyll 构建失败**
   - 问题：`disqus-test.markdown` 文章中包含未转义的 Liquid 模板语法，导致构建时尝试执行 `{% include disqus_count.html %}`
   - 修复：在所有包含 Liquid 模板语法的代码块中添加 `{% raw %}` 和 `{% endraw %}` 标签进行转义

2. **GitHub Actions Node.js 20 弃用警告**
   - 问题：GitHub Actions 从 2026 年 6 月 16 日起强制使用 Node.js 24，现有工作流使用的 actions 版本不支持 Node.js 24
   - 修复：升级所有 actions 到支持 Node.js 24 的版本
     - `actions/checkout`: v4 → v5
     - `actions/setup-node`: v4 → v5
     - `actions/upload-pages-artifact`: v3 → v4
     - `actions/deploy-pages`: v4 → v5

### 更新内容

1. **代码高亮主题更新**
   - 将复古浅色主题替换为 Catppuccin Mocha 深色主题
   - 更新 `_syntax.scss` 和 `main.css` 文件

2. **文章更新**
   - 更新了文章 `2019-12-11-bilibili-obs-setting.markdown`

### 文档

1. **CHANGELOG 添加**
   - 创建了项目变更日志文件 [CHANGELOG.md](file:///c:/Users/ZJZHZF/Documents/GitHub/techysy.github.io/CHANGELOG.md)

## 2026-06-16

### 文章更新

1. **bilibili-OBS-推流设置**
   - 优化文章结构，添加目录导航
   - 更新下载链接为官方地址
   - 完善配置步骤（视频码率、音频设置、高级设置）
   - 添加实用插件推荐

2. **B450M-MORTAR-Hackintosh**
   - 优化文章结构，添加目录导航
   - 将配置和跑分数据改为表格形式
   - 添加使用建议章节

3. **Mac-终端显示目录树**
   - 补充全平台内容（macOS、Linux、Windows）
   - 添加常用命令参数详解
   - 添加实用技巧和自定义别名配置

4. **Windows-10-安装指南**
   - 更新文件名：`2025-12-28-windows10-on-your-mac.markdown`
   - 补充 M 系列 Mac 说明及替代方案（Parallels Desktop）
   - 添加常见问题章节

5. **搬砖日志**
   - 优化文章结构，添加目录导航
   - 将环境配置清单改为表格形式
   - 添加总结部分

6. **TortoiseSVN-教程**
   - 补充 SVN 与 Git 对比表格
   - 添加仓库服务推荐（自建和第三方）
   - 添加完整命令行操作指南
   - 添加常见问题及解决方案

7. **CentOS-7-VMware-静态网络配置**
   - 补充网络映射关系表格
   - 添加配置参数详解表格
   - 添加常见问题（防火墙、SELinux）
   - 添加总结部分

8. **重装系统完全指南**
   - 补充系统镜像下载地址（Windows、macOS、Linux、服务器系统）
   - 添加三种启动盘制作方法（Ventoy、Rufus、Windows自带工具）
   - 完善安装步骤和装机后配置
   - 添加常见问题及解决方案

9. **Disqus-评论系统**
   - 完全重写为完整的集成教程
   - 添加 Disqus 特点、注册步骤、配置方法
   - 添加 Jekyll 集成代码示例
   - 补充国内访问解决方案（Gitalk、Valine 等）

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
