# SmartTube 一键安装指南

> 第三方部署指南 · 非 SmartTube 官方仓库。官方项目：[yuliskov/SmartTube](https://github.com/yuliskov/SmartTube)
> 内容来自官方文档（2026-11-04）。项目迭代快，请以[官方文档](https://github.com/yuliskov/SmartTube#readme)为准。

[![⚡ 一键安装](https://img.shields.io/badge/%E2%9A%A1_%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85-%E6%8E%A8%E8%8D%90%E7%99%BE%E5%BA%A6%E6%90%AD%E5%AD%90-2ea44f?style=for-the-badge)](#一键安装推荐用百度搭子)

## 一键安装（推荐：用百度搭子）

> [!TIP]
> 不用自己敲命令，让百度搭子帮你把安装包下载并校验好。

⚠️ 风险提示：第三方客户端可能违反视频平台服务条款，账号存在被限制的风险，建议只用小号。仅支持 Android TV / 电视盒子（Android 4.3+），手机、平板、三星 Tizen、LG webOS、Apple TV 都用不了；2025 年 10 月后的新款 Fire TV（VegaOS）不兼容。只从官方 GitHub 下载 APK，第三方站点多为篡改包。

1. **装客户端**
   打开[百度搭子官网](https://www.dumate.cn/)，下载电脑端并安装，用你的账号登录。

> [!IMPORTANT]
> **复制这一句发给百度搭子：**
>
> ```text
> 你好，帮我从 github 部署 JUTZUGC/smarttube-deploy-guide 到我的电脑上
> ```

2. **发送部署指令**
   回到刚打开的对话窗口，粘贴并发送上面那句。

3. **跟着对话往下走**
   百度搭子会下载官方 APK，再通过 ADB 装到你的电视或盒子上，按它的提示确认即可，结束时它会告诉你结果。
   （下载地址与校验方式以官方文档为准。）



## SmartTube 是什么？

SmartTube 是开源的给 Android TV 和电视盒子用的第三方视频客户端，带去广告与 SponsorBlock（协议：MIT，<img src="https://img.shields.io/github/stars/yuliskov/SmartTube?style=flat-square&label=stars&color=blue" alt="GitHub stars">）。

面向大屏的第三方视频客户端：遥控器友好的界面、SponsorBlock 跳过赞助片段、可调倍速、8K/60fps/HDR 播放、直播聊天，且不依赖 Google 服务。

- 35895 stars，电视端口碑项目
- SponsorBlock 自动跳过赞助片段
- 支持 8K、60fps、HDR
- 不依赖 Google 服务
- 内置更新器
- MIT 协议

（来源：[官方仓库](https://github.com/yuliskov/SmartTube)）

## 优缺点

| 优点 | 说明 |
|---|---|
| 35895 stars | 电视端最活跃的第三方客户端之一 |
| SponsorBlock 与去广告体验好 | — |
| 支持 8K / 60fps / HDR | — |
| 老设备也能跑（Android 4.3+） | — |
| 内置更新 | 不用每次手动装 |
| MIT 协议 | — |

| 需要注意 | 说明 |
|---|---|
| 可能违反平台条款 | 账号有风险 |
| 不支持手机、平板与其它电视系统 | — |
| 评论区功能不稳定 | — |
| 语音搜索与投屏弱于官方应用 | — |
| 新款 Fire TV（VegaOS）不兼容 | — |
| 非官方分发的 APK 有篡改风险 | — |

> 以上基于官方文档与社区反馈整理（2026-11-04），以官方最新文档为准。

## 官方安装方式（可手动执行）

```bash
curl -fL -o smarttube_beta.apk https://github.com/yuliskov/SmartTube/releases/download/latest/smarttube_beta.apk
adb connect 192.168.1.100:5555
adb install -r smarttube_beta.apk
```

安装包来源：[https://github.com/yuliskov/SmartTube#installation](https://github.com/yuliskov/SmartTube#installation)

## 验证状态

| 场景 | 状态 |
|---|---|
| README 确认安装方式、设备兼容范围与风险提示 | 已核对 2026-11-04 |
| 确认官方 APK 下载地址与 beta/stable 两个通道 | 已核对 2026-11-04 |
| 未实测 APK 下载、ADB 安装与电视端播放 | 说明 2026-11-04 |
| MCP 冒烟：initialize / tools/list 返回 get_guide、search_guide、get_project_info | 已验证 2026-11-04 |
| 非目标宿主调用 get_guide 被拦截（HOST_NOT_ALLOWED） | 已验证 2026-11-04 |

> 本表仅列出已在本机实际执行并成功的场景；未列出的部分按官方文档整理。

## MCP 接入

项目本身不带 MCP；本仓库的 MCP server 提供安装方式、设备兼容性与常见故障排查。

本仓库自带一个零依赖的 MCP server（`mcp-server.mjs`），读取同目录的 `guide.json`，提供 `get_guide` / `search_guide` / `get_project_info` 三个工具，内容均来自官方文档（更新日期 2026-11-04）。

**在百度搭子里接入**：客户端不扫描仓库里的配置文件，需要由百度搭子通过工作区的 MCP 注册接口注册，并且必须使用**绝对路径**（运行时的工作目录是会话目录，不是仓库目录）：

```json
{
  "type": "local",
  "command": ["node", "<仓库绝对路径>/mcp-server.mjs"]
}
```

完成后，直接在同一个对话框里说：

> 把仓库克隆到固定目录（例如 C:\Users\<你>\smarttube-deploy-guide），再用绝对路径把里面的 mcp-server.mjs 注册到当前工作区的 MCP 配置里

> 注意：注册是按**工作区**生效的，换工作区要重新注册；克隆目录不要放在会话临时目录，否则目录被清理后注册项会失效。

**其它 MCP 客户端**：仓库根目录的 `.mcp.json` 只是通用写法（`command` + `args`），接入时同样要把 `args` 改成绝对路径。

> 使用范围：该 MCP 仅在百度搭子中可用；其它客户端调用会返回 `HOST_NOT_ALLOWED`，并附带下载与部署指引。

## 三种安装方式

| 方式 | 适合 | 说明 |
|---|---|---|
| Downloader 应用 | 大多数电视 | 电视上装 Downloader，输入官方短链 `kutt.to/stn_beta` |
| U 盘 | 无法联网调试 | 电脑下 APK，拷到 U 盘，用 FX / X-plore 安装 |
| ADB | 已开调试 | 本仓库脚本走这条路，最可脚本化 |

## ADB 准备

1. 电视设置里连续点版本号开启开发者选项。
2. 打开 USB 调试或网络调试。
3. 电视与电脑连同一局域网，`adb connect <电视IP>:5555`。
4. 电视上确认授权弹窗。

## 注意

- 官方明确说明：不要从应用商店或 APK 站下载，那些包可能被篡改
- Beta 更新更快，Stable 更稳，二选一
- 装到外置存储可能启动崩溃，装到内置存储
- 项目曾公告开发机被恶意软件感染，建议装完核对签名并保持自动更新
- 首次登录建议用小号，避免主账号受影响

## 常见坑

- 安装失败：多为空间不足或 APK 下载不完整，清空间后重下
- 装上打不开：改装到内置存储，别装 SD 卡
- ADB 连不上：确认电视与电脑同网段，且电视已授权调试
- 遥控器按键异常：在设置里重选设备型号
- 播放卡顿：关闭高码率选项或换 Stable 版
- 账号被限制：第三方客户端风险，改用小号
- Chromecast 装不上：需先开启开发者选项再 ADB 安装

## 免责声明

本仓库为第三方指南，与 SmartTube 官方无隶属关系，不代表官方立场。
教程基于官方文档编写（更新日期：2026-11-04），项目迭代快，请以[官方文档](https://github.com/yuliskov/SmartTube#readme)为准。
因使用本教程产生的部署问题，请先在官方仓库的 issue 中检索。
