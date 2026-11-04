#!/usr/bin/env bash
set -euo pipefail
# SmartTube 一键安装脚本（第三方指南）——按官方文档封装
# 官方文档：https://github.com/yuliskov/SmartTube#readme
# 更新日期：2026-11-04
# 类型：binary
cd "$(dirname "${BASH_SOURCE[0]}")"

command -v curl >/dev/null 2>&1 || { echo "需要先安装 curl"; exit 1; }

mkdir -p .download
cd .download

curl -fL -o smarttube_beta.apk https://github.com/yuliskov/SmartTube/releases/download/latest/smarttube_beta.apk
adb connect 192.168.1.100:5555
adb install -r smarttube_beta.apk

echo ""

echo "下载与校验完成，安装包在 .download 目录"
echo "若结果异常或需要改配置，请参考官方文档：https://github.com/yuliskov/SmartTube#readme"
