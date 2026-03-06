#!/bin/bash

# 1. 强制设置默认主题为 bootstrap
sed -i 's/luci-theme-argon/luci-theme-bootstrap/g' feeds/luci/collections/luci/Makefile
sed -i 's/luci-theme-material/luci-theme-bootstrap/g' feeds/luci/collections/luci/Makefile

# 2. 修改默认 IP 为 192.168.1.1 (如有需要可自行修改)
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 3. 移除 Passwall 对核心的强制依赖 (实现“不要内核”)
# 这一步会从 Makefile 中剔除 xray, v2ray 等核心包的自动勾选
sed -i 's/DEPENDS:=+xray-core.*//g' package/feeds/passwall_luci/luci-app-passwall/Makefile

# 4. 移除 AdGuardHome 核心依赖
sed -i 's/+adguardhome-core//g' package/feeds/luci/applications/luci-app-adguardhome/Makefile 2>/dev/null || true
