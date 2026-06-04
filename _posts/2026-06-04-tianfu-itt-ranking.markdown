---
layout: post
title: 天府绿道ITT排行榜网页架构文档
date: 2026-06-04 18:00:00 +0800
img: tianfu-itt.png
tags: [blog,技术文档,Strava,骑行]
categories: 分享
---

本文档整理了天府绿道 ITT 排行榜网页的完整架构信息，包括数据结构、筛选逻辑、核心函数等内容。

## 一、页面结构

```
┌─────────────────────────────────────────────────────────────┐
│                      Hero Section                           │
│  标题：天府绿道单飞ITT排行榜                                  │
│  副标题：成都绕城绿道 逆时针方向 | 0公里出发                   │
│  赛段信息：96.29km | 593m爬升 | 0%坡度 | 470-530m海拔        │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Ranking Section                          │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Section Header                                       │   │
│  │ - 标题：单飞数据排行榜                                │   │
│  │ - 排序按钮：用时/速度/心率/功率                        │   │
│  │ - 筛选按钮：QZ认证/女子组/团骑                        │   │
│  └─────────────────────────────────────────────────────┘   │
│  ┌─────────────────────────────────────────────────────┐   │
│  │ Cards Container                                      │   │
│  │ - 骑手卡片列表                                        │   │
│  │ - 每个卡片包含：排名/头像/姓名/用时/速度/心率/功率     │   │
│  └─────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                       Footer                                │
│  - QZ认证信息（秦浩然）                                      │
│  - 维护者信息（余师洋）                                      │
└─────────────────────────────────────────────────────────────┘
```

**在线访问**：👉 [天府绿道ITT排行榜](https://techysy.github.io/tianfu-itt.html)

---

## 二、数据结构

### 1. 骑手数据 (`ridersData`)

```javascript
{
  name: '骑手姓名',           // 显示名称
  stravaId: 122968010,        // Strava 运动员 ID
  avatar: 'https://...',      // 头像 URL
  female: false               // 是否女性
}
```

**当前骑手数量**：37 人

---

### 2. 队伍数据 (`groupData`)

```javascript
{
  groupId: '0001',            // 队伍 ID
  name: '巾帼号',             // 队伍名称
  members: [122968010, ...]   // 成员 Strava ID 列表
}
```

**当前队伍列表**：

| 队伍 ID | 队伍名称 | 成员数 |
|---------|----------|--------|
| 0001 | 巾帼号 | 4（全女生） |
| 0002 | YY | 2 |
| 0003 | 南门绿道pr局 | 7 |
| 0004 | SZS双子星 | 2 |
| 0005 | 黑白衣呆 | 6 |

---

### 3. 活动数据 (`activityData`)

```javascript
{
  stravaId: 122968010,        // 骑手 Strava ID
  activityId: 18777123822,    // 活动 ID
  time: '2:32:10',            // 用时
  speed: 38.0,                // 速度 (km/h)
  heart: 174,                 // 心率 (bpm)
  power: 0,                   // 功率 (W)
  date: '2026年6月4日',       // 日期
  remark: '备注',             // 备注
  qz: false,                  // QZ 认证
  weight: 0,                  // 体重 (kg)
  heightFront: 0,             // 前框高 (mm)
  heightBack: 0,              // 后框高 (mm)
  groupId: null,              // 队伍 ID（null=单飞）
  itt: true                   // 是否 ITT 记录
}
```

**当前活动数量**：47 条

---

## 三、筛选逻辑

### 1. 筛选状态变量

```javascript
let showQzOnly = false;        // QZ 认证筛选
let showFemaleOnly = false;    // 女子组筛选
let showGroupRideOnly = false; // 团骑筛选
```

### 2. 筛选规则

| 模式 | 条件 | 说明 |
|------|------|------|
| **默认（ITT）** | `itt === true` | 显示所有 ITT 单飞记录 |
| **QZ 认证** | `qz === true` | 仅显示 QZ 认证记录 |
| **女子组** | `female === true` | 仅显示女性骑手 |
| **团骑** | `groupId !== null` | 显示所有团队记录 |
| **女子组团骑** | `femaleGroupIds.includes(groupId)` | 仅显示全女生队伍 |

### 3. 最佳数据选择 (`getBestActivityDataBySpeed`)

- 每个骑手只显示一条最佳记录
- QZ 模式下优先选择 QZ 认证数据
- 女子组团骑模式下区分女生队伍和非女生队伍

---

## 四、核心函数

| 函数名 | 功能 |
|--------|------|
| `renderCards(sortBy)` | 渲染骑手卡片 |
| `getBestActivityDataBySpeed()` | 获取最佳活动数据 |
| `getFemaleGroupIds()` | 获取全女生队伍 ID 列表 |
| `getGroupMembers()` | 获取队伍成员信息 |
| `toggleQzFilter()` | 切换 QZ 认证筛选 |
| `toggleFemaleFilter()` | 切换女子组筛选 |
| `toggleGroupRideFilter()` | 切换团骑筛选 |
| `compareTime()` | 比较用时 |
| `isFastTime()` | 判断是否快速（≤2:30:59） |

---

## 五、UI 组件

### 1. 骑手卡片

```
┌────────────────────────────────────────────────────────────┐
│ [排名] [头像] [姓名]          [用时] [速度] [心率] [功率]   │
│                              [日期]  [备注]                │
│                              [团队成员头像] ← 点击显示      │
└────────────────────────────────────────────────────────────┘
```

### 2. 卡片样式

| 排名 | 样式 |
|------|------|
| 第1名 | 金色渐变背景 + 金色边框 |
| 第2名 | 银色渐变背景 + 银色边框 |
| 第3名 | 铜色渐变背景 + 铜色边框 |
| 其他 | 白色背景 |

### 3. 交互功能

- **点击头像**：跳转到 Strava 主页
- **点击日期**：跳转到原始活动
- **点击功率**：切换 W/W/kg 显示
- **点击卡片**：显示/隐藏团队成员头像

---

## 六、CSS 样式模块

| 模块 | 说明 |
|------|------|
| `.hero-section` | 顶部英雄区域 |
| `.ranking-section` | 排行榜区域 |
| `.rider-card` | 骑手卡片 |
| `.rank-badge` | 排名徽章 |
| `.avatar` | 头像 |
| `.time-badge` | 用时标签 |
| `.stats-inline` | 统计数据 |
| `.filter-tag` | 筛选按钮 |
| `.group-members` | 团队成员 |

---

## 七、响应式设计

| 断点 | 调整内容 |
|------|----------|
| ≤768px | 标题缩小、卡片间距调整、统计项缩小 |

---

## 八、文件位置

```
f:\Files\GitHub Files\techysy.github.io\tianfu-itt.html
```

**访问地址**：`https://techysy.github.io/tianfu-itt.html`

---

## 九、Strava 数据识别 Skill

已创建 `.trae/skills/strava-parser/SKILL.md` 用于解析 Strava 数据：

### 支持的解析能力

1. **运动员 ID 提取**
   - 从运动员主页：`https://www.strava.com/athletes/122968010` → `122968010`
   - 从头像 URL：`https://dgalywyr863hv.cloudfront.net/pictures/athletes/122968010/...` → `122968010`

2. **活动 ID 提取**
   - 从活动链接：`https://www.strava.com/activities/18777123822` → `18777123822`

3. **头像 URL 识别**
   - 标准头像：`https://dgalywyr863hv.cloudfront.net/pictures/athletes/{id}/...`
   - 默认头像：`https://d3nn82uaxijpm6.cloudfront.net/assets/avatar/athlete/large-...`
