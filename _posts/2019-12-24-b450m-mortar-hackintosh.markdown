---
layout: post
title: B450M迫击炮OC引导EFI分享
date: 2019-12-24 23:59:59 +0800
img: Hackintosh-b450.jpg
tags: [MAC,野生技术协会]
categories: 分享
---

# MSI B450M MORTAR MAX (MS-7B89)

通过 UEFI → rEFInd → Open Core 0.5.2 → macOS 10.15.2  实现多系统引导

> 同步更新地址：<a href="https://github.com/techysy/B450M-MORTAR-Hackintosh" target="_blank">https://github.com/techysy/B450M-MORTAR-Hackintosh</a>   （EFI文件也在这）
        
## 具体配置：

        处理器 : AMD® Ryzen5 3600 （电压-0.05v 运行 迫击炮默认电压太高）
 
        显卡 : AMD® Radeon RX 580 8G （硬解可用）
    
        内存 : 16G DDR4 2666 （光威® 2 * 8g  2400 c17 → 2666 c18 ）
        
        网卡 : Realtek® RTL8111H-CG
        
        无线 : BCM943602CS (免驱 蓝牙+2.4G+5G 可用)

        声卡 : Realtek® ALC892 Codec

## 已知bug：

        3.5mm 麦克风🎤 没声音 （目前解决方案外置USB免驱声卡）

        3.5mm 🎧耳机还是走面板或者背板

        mortar Windows 下也不好用 UWP那个驱动感觉不是常驻后台 
        
  ~~插耳机🎧或者麦克风🎤系统不会识别~~

  ~~音质木耳都能听出区别，也可以算推力不够 我还是开UWP吧~~        
    
## 达芬奇导出视频对比实测

> macOS 10.15.2 AMD_Vanilla + DaVinci Resolve 16
    
    
#### 原始素材 : mp*4* h.*264* *1080*p *50*fps *50*m *01:40:39*
    
#### 导出视频 : mp*4* *1080*p *50*fps *6000kb* 

        编码 : h.264 完成时间 : 01:25

        编码 : h.265 完成时间 : 00:43

        编码 : h.264 开启硬件加速 完成时间 : 01:20

    
> Windows 10 1909 + DaVinci Resolve 16
   
    
#### 原始素材 : mp*4* h.*264* *1080*p *50*fps *50*m *01:40:39*
    
#### 导出视频 : mp*4* *1080*p *50*fps *6000kb* 

        编码 : h.264 原生 完成时间 : 00:54

        编码 : h.265 AMD 完成时间 : 00:28

        编码 : h.264 AMD 完成时间 : 00:48

## Geekbench 跑分

### Geekbench 4 

> macOS 10.15.2 AMD_Vanilla
            
        CPU 单核 5595 多核 29783  

        https://browser.geekbench.com/v4/cpu/15066696

        GPU 122623   
        
        https://browser.geekbench.com/v4/compute/4677747

> Windowns 10 1909

        CPU 单核 5319 多核 26963  
        
        https://browser.geekbench.com/v4/cpu/    15066532

        GPU 138227
        
         https://browser.geekbench.com/v4/compute/4677679

### Geekbench 5
    
> macOS 10.15.2 AMD_Vanilla

        CPU 单核 1230 多核 6898 
          
        https://browser.geekbench.com/v5/cpu/861892

        GPU 33202 
            
        https://browser.geekbench.com/v5/compute/364190

> Windowns 10 1909

        CPU 单核 1207 多核 6890 
            
        https://browser.geekbench.com/v5/cpu/861352
    
        GPU 48759 
            
        https://browser.geekbench.com/v5/compute/363947