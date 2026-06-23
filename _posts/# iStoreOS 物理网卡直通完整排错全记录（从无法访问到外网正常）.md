# iStoreOS 物理网卡直通完整排错全记录（从无法访问到外网正常）

本文记录了我在 iStoreOS 虚拟机中使用单张物理网卡直通后，从“能够 ping 通但无法登录”到“恢复外网访问并成功安装 OpenClash”的完整排错过程。目标是把这次问题梳理成一篇可复用的排查指南。

## 一、环境与问题描述

- 系统：iStoreOS 24.10.7（OpenWrt 内核）
- 部署方式：虚拟机，单张物理网卡直通
- 直通网卡枚举为：`eth0`
- 上级主路由网段：`192.168.31.0/24`
- 上级网关：`192.168.31.1`

### 初始故障表现

- Windows 电脑可以 ping 通 iStoreOS 临时 DHCP IP `192.168.31.93`
- FinalShell SSH 连接 22 端口提示 `Connection refused`
- iStoreOS Web 管理后台无法打开
- 修复内网后，执行 OpenClash 安装脚本时提示外网无法连接，出现 `Network unreachable`

## 二、第一阶段：SSH 无法连接，先打开远程管理入口

这一步的目标是让 iStoreOS 能够接受 SSH 登录并进入系统继续排查。

### 1. 启用 Dropbear SSH 并允许 root 登录

编辑 Dropbear 配置：

```bash
vi /etc/config/dropbear
```

写入以下内容：

```conf
config dropbear main
        option enable '1'
        option PasswordAuth 'on'
        option RootPasswordAuth 'on'
        option Port '22'
```

设置 root 密码：

```bash
passwd root
```

重启 Dropbear 并设置开机自启：

```bash
/etc/init.d/dropbear restart
/etc/init.d/dropbear enable
```

检查是否监听 22 端口：

```bash
netstat -tulpn | grep 22
```

如果输出包含 `dropbear`，并且监听地址为 `0.0.0.0:22`，说明 SSH 服务已经启动。

### 2. 放行 LAN 网段的 SSH 流量

OpenWrt 默认防火墙可能会拦截来自 LAN 的 SSH 连接。添加一个防火墙规则：

```bash
uci add firewall rule
uci set firewall.@rule[-1].name='Allow-LAN-SSH'
uci set firewall.@rule[-1].src='lan'
uci set firewall.@rule[-1].proto='tcp'
uci set firewall.@rule[-1].dest_port='22'
uci set firewall.@rule[-1].target='ACCEPT'
uci commit firewall
/etc/init.d/firewall reload
```

### 3. 找到核心问题：网段隔离与网桥丢失

当时的关键问题是：

- iStoreOS 默认 LAN 网桥 `br-lan` 静态网段是 `192.168.100.1/24`
- 直通网卡通过 DHCP 得到的是 `192.168.31.x`
- 两个网段不一致，导致 LAN 接口无法正确信任物理网卡流量
- 删除 OVS 虚拟网卡后，`br-lan` 网桥配置也丢失了，系统没有有效的 LAN 接口

也就是说，物理网卡本身虽然连通，但 OpenWrt 的网络接口和防火墙配置已经不匹配。

### 4. 最简修复方案：单网卡直通时删除网桥，直接把 eth0 设置为 LAN

将直通物理网卡 `eth0` 绑定到 LAN 接口，并直接使用上级网段：

```bash
uci set network.lan.device='eth0'
uci set network.lan.proto='static'
uci set network.lan.ipaddr='192.168.31.102'
uci set network.lan.netmask='255.255.255.0'
uci set network.lan.gateway='192.168.31.1'
uci set network.lan.dns='192.168.31.1'
uci commit network
/etc/init.d/network restart
```

这一步的重点是：

- 不要保留 `br-lan` 这种虚拟网桥结构
- 直接把物理网卡纳入 LAN
- 同时补齐网关和 DNS，否则后面外网访问会失败

### 5. 验证内网连通

在 Windows 上测试 SSH 端口是否可连通：

```powershell
Test-NetConnection 192.168.31.102 -Port 22
```

如果返回 `TcpTestSucceeded: True`，即可继续使用 FinalShell 登录。

浏览器访问：

```text
http://192.168.31.102
```

进入 iStoreOS 管理后台。

## 三、第二阶段：内网正常但外网不可用

接下来排查外网不可访问的问题，重点在于路由与网关配置。

### 1. 报错情况

- 拉取 OpenClash 脚本失败：

```bash
curl: (7) Failed to connect to go.sky9119.cc port 443
```

- 测试公网时出现：

```bash
ping 8.8.8.8
ping: sendto: Network unreachable
```

### 2. 根因：静态 IP 但缺少默认路由

由于LAN接口只配置了静态 IP，而没有正确设置默认网关，系统缺少外网出口路由。结果是本地网络可用，但没有任何公网转发路径。

### 3. 修复外网路由

如果之前的 `network.lan` 配置中没有添加 gateway 和 dns，请补全：

```bash
uci set network.lan.gateway='192.168.31.1'
uci set network.lan.dns='192.168.31.1'
uci commit network
/etc/init.d/network restart
```

### 4. 验证外网访问

```bash
ping 192.168.31.1
ping 8.8.8.8
curl www.baidu.com
```

如果以上命令都正常返回，说明外网已经恢复。

## 四、恢复后安装 OpenClash

外网正常后，可以选择以下两种方式安装 OpenClash：

### 方式一：一键脚本安装

```bash
curl -fsSL 'https://go.sky9119.cc/openclash' | sh
```

### 方式二：推荐的图形化安装

登录 iStoreOS 网页后台，进入左侧菜单【iStore】插件商店，搜索 `OpenClash` 并使用一键安装。该方式依赖后台的国内镜像，稳定性更高。

## 五、全程经验总结

- ping 通不等于服务可用。物理连通只是第一步，防火墙和 LAN 网段才决定 TCP 连接是否能通过。
- 删除虚拟网卡后，网桥配置可能被破坏。单网卡直通场景下，避免保留旧的 `br-lan` 网桥，直接绑定 `eth0` 更可靠。
- `ifconfig` 临时配置不能作为长期方案。正确的修改方式是通过 `uci` 写入配置文件并重启网络。
- 直通网卡名可能变化。排查时要确认当前物理网卡实际名称是否仍是 `eth0`。
- 没有默认路由会导致 `Network unreachable`。即使 IP 正确，缺少 gateway 也无法访问公网。
- 直通只是二层连接，三层路由和防火墙配置仍然决定着整个网络是否可用。

## 六、建议和后续优化

1. 目前单张物理网卡直通适合做旁路由；
2. 如果 iStoreOS 需要担当主路由，建议再创建一个虚拟网卡作为 WAN 接口，对接光猫；
3. 修复完成后在后台导出网络、防火墙配置备份，避免日后配置丢失；
4. 进一步加强 SSH 安全，后台设置仅允许 LAN 段访问，不要直接暴露 22 端口到外网。

通过本次排查，我把问题拆成了两大类：先保证远程管理入口，再修复网关与路由。最终从“只能 ping”到“外网正常”，整个过程清晰可复用。