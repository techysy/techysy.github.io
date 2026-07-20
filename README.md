# 余师洋的个人博客

> 一个基于 Jekyll 的个人博客 + 几个兴趣驱动的小工具

[![GitHub Pages](https://img.shields.io/badge/GitHub-Pages-blue)](https://techysy.github.io)
[![Jekyll](https://img.shields.io/badge/Jekyll-4.x-orange)](https://jekyllrb.com/)
[![CNAME](https://img.shields.io/badge/CNAME-shiyangyu.com-brightgreen)](https://shiyangyu.com)

---

## 🌐 在线访问

- **主站**：https://shiyangyu.com
- **GitHub Pages**：https://techysy.github.io

---

## 📁 项目结构

```
techysy.github.io/
├── _config.yml              # Jekyll 站点配置
├── _layouts/                # 页面布局模板
│   ├── default.html
│   ├── home-page.html
│   └── post.html
├── _includes/               # 可复用片段（header/footer/search...）
├── _pages/                  # 静态独立页面（about/tags/tools）
├── _posts/                  # Markdown 博客文章（15篇）
├── assets/                  # 静态资源
│   ├── css/                 # CSS 样式
│   ├── js/                  # main.js / jquery / jekyll-search
│   ├── fonts/font-awesome/  # 字体图标
│   └── img/                 # 文章配图（含 WebP 版本）
│
├── tianfu-itt.html          # 天府绿道ITT排行榜
├── tianfu-data.json         # 骑行数据（骑手/团队/活动）
├── cycling-activity.html      # 骑行活动发布平台（GPX渲染）
├── 3d-print-threads.html    # 3D打印螺纹规格速查
├── strava-tool.html         # Strava 相关工具
├── long-a-side.html         # 其他独立页面
│
├── tools/                   # WebP 转码工具
│   ├── webp/                # libwebp（包含 cwebp.exe）
│   └── convert-webp.ps1     # 批量转换脚本（本地使用）
│
├── index.html               # 首页
├── search.json              # 站内搜索索引
├── CNAME                    # 自定义域名 shiyangyu.com
├── Gemfile                  # Ruby 依赖
├── serve.rb                 # 本地服务器启动脚本
├── build.rb                 # 构建脚本
│
├── google6c72564a30dfb997.html   # Google 验证
├── baidu_verify_ZISdf60C3y.html  # 百度验证
└── LICENSE                  # 许可协议
```

---

## 🚀 主要页面

### 1. [天府绿道ITT排行榜](tianfu-itt.html)

骑行数据可视化展示，从 `tianfu-data.json` 动态加载。

- **数据规模**：44 位骑手、7 个团队、约 50 条活动记录
- **排序维度**：用时 / 速度 / 心率 / 功率
- **筛选器**：QZ 认证 / 女子组 / 团骑模式
- **交互**：功率单位切换（W ↔ W/kg）、团队成员展开、头像/日期直跳 Strava

> 数据来源为 Strava 公开数据，仅用于学习研究。

### 2. [骑行活动发布平台](cycling-activity.html)

GPX 轨迹渲染与骑行活动发布工具。

- **GPX 渲染**：上传或拖拽 GPX 文件，Leaflet 地图显示轨迹，起终点标记
- **海拔剖面**：Canvas 绘制海拔图，带距离/海拔刻度
- **数据统计**：距离、爬升、时长（按25km/h匀速计算）
- **隧道过滤**：梯度检测去除GPS异常跳点，减少无效爬升
- **电子骑友**：匀速模拟骑行，实时动画沿轨迹前进
- **兴趣点 (POI)**：在地图上标记厕所、拍照点、休息、补给点等
- **路书链接**：输入 Strava / iGPSPORT / Garmin Connect 链接
- **图层切换**：街道/卫星底图一键切换
- **社交分享**：微博、Twitter、复制链接
- **数据导出**：GPX 文件下载、POI 数据 JSON 导出/导入

> 纯静态 HTML，无需后端，直接双击打开即可使用。

### 3. [3D打印螺纹规格速查](3d-print-threads.html)

机械工程工具，FDM 3D打印螺纹配套参考。

- **公制螺纹**：M3~M64，含小径数据（GB/T 196-2003）
- **英制螺纹**：1/4" ~ 2"，含牙数/螺距
- **3D打印优化**：外牙/内牙大径与小径补偿值
- **圈数计算器**：根据螺丝高度计算所需圈数与旋转角度

> 附国标 PDF 跳转（GB/T 196-2003）。

---

## 🛠 技术栈

| 层 | 技术 |
|----|------|
| 站点生成器 | **Jekyll**（GitHub Pages 原生支持） |
| Markdown 渲染 | **kramdown** |
| 样式 | **CSS**（手写或预编译） |
| 交互 | **原生 JavaScript** + **jQuery 3.2.1** |
| 图标 | **Font Awesome**（本地加载） |
| 搜索 | **jekyll-search**（读取 `search.json`） |
| 评论 | **Disqus** |
| 统计 | **Google Analytics** + **百度统计** |
| 图片处理 | **WebP 转换**（本地环境处理） |
| 部署 | **GitHub Actions** |

---

## 📦 Jekyll 插件

- `jekyll-paginate` — 分页（每页 8 篇）
- `jekyll-feed` — RSS feed
- `jekyll-sitemap` — sitemap.xml

---

## 🏃 本地运行

### Windows 环境配置

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

### 启动命令

```bash
# 安装 Ruby 依赖
bundle install

# 生成 WebP 图片（本地环境）
powershell -ExecutionPolicy Bypass -File tools/convert-webp.ps1

# 本地预览（自动构建 + 热刷新）
ruby serve.rb

# 或直接使用 Jekyll
jekyll serve --host 0.0.0.0 --port 4000
```

**浏览器访问**：http://localhost:4000

**注意**：
- 独立 HTML 工具页（`tianfu-itt.html`、`3d-print-threads.html` 等）不需要 Jekyll 构建，直接双击打开即可运行
- **WebP 图片转换已移至本地环境处理**（通过 `tools/convert-webp.ps1`），GitHub Actions 只负责 Jekyll 构建和部署

---

## 🚀 CI/CD 部署

GitHub Actions 工作流（`.github/workflows/deploy.yml`）：

1. ✅ 检出代码
2. ✅ 安装 Ruby 依赖
3. ✅ 运行 Jekyll build
4. ✅ 复制预生成的 WebP 图片到输出目录
5. ✅ 上传构建产物
6. ✅ 部署到 GitHub Pages

**关键改动**：
- 已移除 npm/gulp 构建步骤（WebP 转换现在本地完成）
- 构建流程更快、更稳定

---

## 📝 博客文章

共 15 篇，时间跨度 2019-12 ~ 2026-06：

| 主题 | 代表文章 |
|------|----------|
| Hackintosh / Mac | B450M Mortar 黑苹果、Windows 10 on Mac、rEFInd 引导 |
| 工具 / 效率 | B 站 OBS 推流、TortoiseSVN、tree 命令、WSL + Docker |
| AI / LLM | Relearn AI |
| **最新活跃（2026）** | 3D打印螺纹速查、天府绿道 ITT 排行榜 |

---

## 📬 作者

- **余师洋**
- Email：i@shiyangyu.com
- GitHub：https://github.com/techysy
- Strava：https://www.strava.com/athletes/yangyu
- Bilibili：https://space.bilibili.com/10419858
- 小红书：https://www.xiaohongshu.com/user/profile/5a5d020711be101b3d65cece

---

## 📄 License

请查看项目根目录的 `LICENSE` 文件。
