---
layout: post
title: B450M 迫击炮 OC 引导 EFI 分享与 macOS 体验
date: 2019-12-24 23:59:59 +0800
last_modified_at: 2026-06-16 20:00:00 +0800
img: Hackintosh-b450.jpg
tags: [MAC, Hackintosh, 野生技术协会]
categories: 分享
description: MSI B450M MORTAR MAX + Ryzen 5 3600 + RX 580 Hackintosh 配置分享，包含 EFI 文件下载、硬件兼容性、性能测试对比
---

# MSI B450M MORTAR MAX (MS-7B89) Hackintosh

通过 **UEFI → rEFInd → OpenCore 0.5.2 → macOS 10.15.2** 实现多系统引导，完美运行 macOS Catalina。

> **项目地址**：[https://github.com/techysy/B450M-MORTAR-Hackintosh](https://github.com/techysy/B450M-MORTAR-Hackintosh)（EFI 文件下载）

## 目录

- [硬件配置](#硬件配置)
- [已知问题](#已知问题)
- [性能测试](#性能测试)
- [使用建议](#使用建议)

## 硬件配置

| 组件 | 型号 | 备注 |
|------|------|------|
| 主板 | MSI B450M MORTAR MAX | BIOS 版本建议更新至最新 |
| 处理器 | AMD Ryzen 5 3600 | 电压优化：-0.05v（迫击炮默认电压偏高） |
| 显卡 | AMD Radeon RX 580 8G | 原生硬解码支持 |
| 内存 | 光威 DDR4 2666 16G（2×8G） | 原 2400 c17 超频至 2666 c18 |
| 有线网卡 | Realtek RTL8111H-CG | 需要驱动支持 |
| 无线网卡 | Broadcom BCM943602CS | 免驱，支持蓝牙 4.0 + 2.4G/5G WiFi |
| 声卡 | Realtek ALC892 | 需使用 AppleALC 驱动 |

## 已知问题

### 音频问题

1. **3.5mm 麦克风无声音**：目前解决方案是使用外置 USB 免驱声卡
2. **耳机插孔选择**：建议使用机箱背板或前面板的耳机插孔
3. **Windows 下驱动问题**：UWP 驱动在 Windows 下表现不佳，建议使用官方驱动

> ~~已解决：插耳机或麦克风时系统不会自动识别的问题~~
>
> ~~已解决：音质差异和推力不足的问题，改用 UWP 驱动后明显改善~~

## 性能测试

### DaVinci Resolve 导出视频对比

**测试条件**：

- 原始素材：MP4 H.264 1080p 50fps，大小 50MB，时长 01:40:39
- 导出设置：MP4 1080p 50fps 6000kbps

#### macOS 10.15.2 + DaVinci Resolve 16

| 编码方式 | 完成时间 |
|----------|----------|
| H.264 原生 | 01:25 |
| H.265 | 00:43 |
| H.264 硬件加速 | 01:20 |

#### Windows 10 1909 + DaVinci Resolve 16

| 编码方式 | 完成时间 |
|----------|----------|
| H.264 原生 | 00:54 |
| H.265 AMD 硬件加速 | 00:28 |
| H.264 AMD 硬件加速 | 00:48 |

**结论**：Windows 平台在视频编码方面表现更优，特别是 H.265 硬件加速差距明显。

### Geekbench 跑分对比

#### Geekbench 4

| 平台 | CPU 单核 | CPU 多核 | GPU 计算 |
|------|----------|----------|----------|
| macOS 10.15.2 | 5595 | 29783 | 122623 |
| Windows 10 1909 | 5319 | 26963 | 138227 |

[macOS CPU 跑分](https://browser.geekbench.com/v4/cpu/15066696) | [macOS GPU 跑分](https://browser.geekbench.com/v4/compute/4677747)
[Windows CPU 跑分](https://browser.geekbench.com/v4/cpu/15066532) | [Windows GPU 跑分](https://browser.geekbench.com/v4/compute/4677679)

#### Geekbench 5

| 平台 | CPU 单核 | CPU 多核 | GPU 计算 |
|------|----------|----------|----------|
| macOS 10.15.2 | 1230 | 6898 | 33202 |
| Windows 10 1909 | 1207 | 6890 | 48759 |

[macOS CPU 跑分](https://browser.geekbench.com/v5/cpu/861892) | [macOS GPU 跑分](https://browser.geekbench.com/v5/compute/364190)
[Windows CPU 跑分](https://browser.geekbench.com/v5/cpu/861352) | [Windows GPU 跑分](https://browser.geekbench.com/v5/compute/363947)

**结论**：CPU 性能在两个平台上基本持平，macOS 单核略占优势；GPU 性能 Windows 平台更优，差距约 47%。

## 使用建议

1. **BIOS 设置**：
   - 开启 **Above 4G Decoding**
   - 关闭 **Secure Boot**
   - 开启 **VT-d**（如果需要直通）
   - 设置 **CSM** 为 Disabled

2. **EFI 更新**：定期关注 GitHub 仓库获取最新的 EFI 配置

3. **系统升级**：升级 macOS 前请备份 EFI 文件，确认新版本兼容性

4. **电源管理**：建议使用 SSDT 实现更好的电源管理，降低待机功耗

5. **日常使用**：macOS 在办公、设计、开发等场景体验优秀，视频渲染建议使用 Windows 平台

---

**总结**：B450M MORTAR MAX + Ryzen 5 3600 组合是性价比很高的 Hackintosh 配置，日常使用体验接近原生 Mac。虽然在某些专业场景下与 Windows 存在差距，但对于大多数用户来说完全够用。