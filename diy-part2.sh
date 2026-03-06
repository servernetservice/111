#!/bin/bash

# 1. 设置默认 IP
sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate

# 2. 强制使用 Bootstrap 主题
sed -i 's/luci-theme-bootstrap/luci-theme-bootstrap/g' feeds/luci/collections/luci/Makefile

# 3. 核心瘦身：移除 PassWall 对 Xray/V2ray 的强依赖
# 这样编译出的 ipk 就不包含那几十兆的内核文件
find package/feeds/passwall_luci/ -name "Makefile" | xargs sed -i 's/+xray-core//g'
find package/feeds/passwall_luci/ -name "Makefile" | xargs sed -i 's/+v2ray-core//g'

# 4. 移除 AdGuardHome 核心依赖
find feeds/luci/applications/luci-app-adguardhome/ -name "Makefile" | xargs sed -i 's/+adguardhome-core//g'
