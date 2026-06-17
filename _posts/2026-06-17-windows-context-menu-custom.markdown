---
layout: post
title: Windows右键菜单自定义：添加PowerShell与管理Git Bash
date: 2026-06-17 16:00:00 +0800
img: context-menu.jpg
tags: [Windows, PowerShell, 注册表]
categories: 分享
---

Windows 的右键菜单（上下文菜单）是日常操作中最高频的入口之一。系统自带了「在此处打开命令提示符」和「在此处打开 PowerShell」，但很多时候我们想要更多——比如以管理员身份直接打开 PowerShell，或者清理掉 Git Bash 安装后自动塞进来的右键项。本文记录了通过修改注册表来实现这些自定义的方法。

## 添加 PowerShell 到右键菜单

### 效果预览

在文件夹空白处右键、文件夹图标上右键、甚至驱动器上右键，都会出现两个新选项：

- **在此处打开 PowerShell** — 普通权限
- **在此处打开 PowerShell (管理员)** — 带 UAC 盾牌图标，点击后弹出管理员权限确认

### 实现原理

Windows 右键菜单由注册表中的 `HKEY_CLASSES_ROOT` 下的 `shell` 子键控制。主要涉及三个位置：

| 注册表路径 | 触发场景 |
|-----------|---------|
| `Directory\Background\shell` | 在文件夹内空白区域右键 |
| `Directory\shell` | 右键点击文件夹图标 |
| `Drive\shell` | 右键点击驱动器（如 C: 盘） |

每个菜单项是一个子键，包含显示名称（默认值）、图标（`Icon`）、位置（`Position`）和执行命令（`command` 子键的默认值）。

### 普通模式

普通模式的命令很简单，直接启动 PowerShell 即可：

```reg
[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHere]
@="在此处打开 PowerShell"
"Icon"="powershell.exe"
"Position"="Bottom"

[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHere\command]
@="powershell.exe -NoLogo -NoExit"
```

`-NoLogo` 隐藏启动版权信息，`-NoExit` 保持窗口不自动关闭。对于文件夹和驱动器场景，需要额外用 `Set-Location` 切换到目标路径：

```reg
@="powershell.exe -NoLogo -NoExit -Command \"Set-Location '%V'\""
```

`%V` 是注册表中的环境变量，代表当前选中的文件夹或驱动器路径。

### 管理员模式

管理员模式需要触发 UAC 提权。如果直接用 `Start-Process -Verb RunAs`，会先闪出一个中间窗口再打开第二个管理员窗口，体验不好。更好的方式是借助 `mshta` 调用 Windows Shell 的 `ShellExecute` 方法：

```reg
@="mshta vbscript:CreateObject(\"Shell.Application\").ShellExecute(\"powershell.exe\",\"-NoLogo -NoExit\",\"\",\"runas\",1)(close)"
```

这段命令的含义：

- `mshta vbscript:` — 用 mshta 执行一段内联 VBScript
- `CreateObject("Shell.Application").ShellExecute(...)` — 调用 Shell 的执行方法
- 第 4 个参数 `"runas"` — 请求管理员权限（触发 UAC）
- 第 5 个参数 `1` — 显示窗口
- `(close)` — 执行完毕后关闭 mshta 自身

对于文件夹和驱动器场景，把第 3 个参数改为 `%V` 即可让管理员 PowerShell 的工作目录指向目标路径。

### 编码注意事项

`.reg` 文件中包含中文时，**必须使用 UTF-16 LE 编码**（带 BOM `FF FE`）。如果用 UTF-8 编码，regedit 导入后中文会变成乱码。可以用 PowerShell 生成正确编码的文件：

```powershell
$content = "Windows Registry Editor Version 5.00`r`n..."
[System.IO.File]::WriteAllText("output.reg", $content, [System.Text.Encoding]::Unicode)
```

### 一键导入脚本

将以下内容保存为 `.reg` 文件（UTF-16 LE 编码），双击导入即可：

```reg
Windows Registry Editor Version 5.00

; === Folder Background (empty space) ===
[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHereAdmin]
@="在此处打开 PowerShell (管理员)"
"Icon"="powershell.exe"
"Position"="Bottom"
"Extended"=""

[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHereAdmin\command]
@="powershell.exe -Command Start-Process powershell.exe -ArgumentList '-NoLogo -NoExit -Command Set-Location ''%V''' -Verb RunAs"

; === Folder ===
[HKEY_CLASSES_ROOT\Directory\shell\PowerShellHereAdmin]
@="在此处打开 PowerShell (管理员)"
"Icon"="powershell.exe"
"Position"="Bottom"
"Extended"=""

[HKEY_CLASSES_ROOT\Directory\shell\PowerShellHereAdmin\command]
@="powershell.exe -Command Start-Process powershell.exe -ArgumentList '-NoLogo -NoExit -Command Set-Location ''%V''' -Verb RunAs"

; === Drive ===
[HKEY_CLASSES_ROOT\Drive\shell\PowerShellHereAdmin]
@="在此处打开 PowerShell (管理员)"
"Icon"="powershell.exe"
"Position"="Bottom"
"Extended"=""

[HKEY_CLASSES_ROOT\Drive\shell\PowerShellHereAdmin\command]
@="powershell.exe -Command Start-Process powershell.exe -ArgumentList '-NoLogo -NoExit -Command Set-Location ''%V''' -Verb RunAs"
```

移除时用以下内容（删除对应的注册表键）：

```reg
Windows Registry Editor Version 5.00

[-HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHereAdmin]
[-HKEY_CLASSES_ROOT\Directory\shell\PowerShellHereAdmin]
[-HKEY_CLASSES_ROOT\Drive\shell\PowerShellHereAdmin]
```

## 移除 Git Bash 右键菜单

安装 Git for Windows 后，右键菜单会自动多出两个选项：「Open Git Bash here」和「Open Git GUI here」。如果日常开发中更习惯用 PowerShell 或 Windows Terminal，这两个选项基本用不到，放在右键菜单里反而显得杂乱。

### Git Bash 注册了什么

Git 安装程序在注册表中写入了以下键：

```
HKEY_CLASSES_ROOT\Directory\Background\shell\git_shell    → Open Git Bash here
HKEY_CLASSES_ROOT\Directory\Background\shell\git_gui     → Open Git GUI here
HKEY_CLASSES_ROOT\Directory\shell\git_shell              → Open Git Bash here
HKEY_CLASSES_ROOT\Directory\shell\git_gui               → Open Git GUI here
```

### 移除方法

保存为 `.reg` 文件（UTF-16 LE），双击导入：

```reg
Windows Registry Editor Version 5.00

[-HKEY_CLASSES_ROOT\Directory\Background\shell\git_shell]
[-HKEY_CLASSES_ROOT\Directory\Background\shell\git_gui]
[-HKEY_CLASSES_ROOT\Directory\shell\git_shell]
[-HKEY_CLASSES_ROOT\Directory\shell\git_gui]
```

如果以后想恢复，重新安装 Git for Windows 或在安装程序中勾选右键菜单相关选项即可。

## 调整右键菜单项的显示位置

### Position 值

注册表中的 `Position` 字符串值控制菜单项在右键菜单中的位置：

| Position 值 | 效果 |
|------------|------|
| `Top` | 靠近菜单顶部 |
| `Bottom` | 靠近菜单底部 |
| （不设置） | 按注册表中的字母顺序排列 |

例如，让 PowerShell 选项出现在菜单顶部：

```reg
[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHere]
"Position"="Top"
```

### 用数值控制精确顺序

如果需要更精细的控制，可以在子键名称前加数字前缀。注册表按子键名字母顺序渲染菜单项：

```
shell
├── 01_PowerShellHere        → 排第 1
├── 02_PowerShellHereAdmin   → 排第 2
├── cmd                      → 系统自带
└── VSCode                    → 其他应用
```

改键名时需要同步更新所有引用该键的路径。另一种更简单的方式是直接修改 `Position` 值为 `Top` 或 `Bottom`，大多数场景下已经够用。

### 隐藏 Shift 触发的扩展菜单

在子键中添加一个名为 `Extended` 的空字符串值，菜单项只会在按住 Shift 键再右键时才显示：

```reg
[HKEY_CLASSES_ROOT\Directory\Background\shell\PowerShellHereAdmin]
"Extended"=""
```

这个技巧适合把「管理员模式」之类的低频操作藏起来，保持右键菜单干净。

## 脚本下载

所有 `.reg` 文件和 PowerShell 安装脚本已整理好，可直接使用：

| 文件 | 说明 |
|-----|------|
| `Add-PowerShell-ContextMenu.reg` | 添加 PowerShell 右键菜单（含管理员模式） |
| `Remove-PowerShell-ContextMenu.reg` | 移除 PowerShell 右键菜单 |
| `Remove-GitBash-ContextMenu.reg` | 移除 Git Bash 右键菜单 |
| `Add-PowerShell-ContextMenu.ps1` | PowerShell 安装脚本（自动请求管理员权限） |

> **提示**：导入 `.reg` 文件前，建议先导出当前注册表备份（`regedit` → 文件 → 导出），以便出问题时回滚。