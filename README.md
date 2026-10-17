# WildBound

**荒野归途（Wildbound）** 是一款第一人称的海岛荒野生存游戏。你住在加勒比海岛的小渔村里，从家里出门，到沙滩、栈桥和村北的森林里采集、制作工具、对付矛头蝮这类毒蛇，天黑前要想办法回家，或者在野外扎帐篷过夜。死在野外会丢掉背包和随身装备，仓库里的东西和金币会保留。

**Wildbound** is a first-person island survival game. Leave your home in a small Caribbean fishing village, forage on the beaches and in the forest, craft tools, deal with venomous snakes, and make it back home — or pitch a tent for the night. Dying in the wild costs you your backpack and the gear you carry; your storage chest and gold stay safe.

> 当前为 Alpha 试玩版，之后的版本可能会重置存档。This is an alpha build; saves may be reset by later versions.

## 下载 · Download

到 [Releases 页面](https://github.com/Sandglass-vic/WildBound/releases) 下载最新版本：

- macOS：`Wildbound-<版本>-macos.zip`
- Windows：`Wildbound-<版本>-windows-x64.zip`

Download the latest build from the [Releases page](https://github.com/Sandglass-vic/WildBound/releases).

## 系统要求 · System requirements

| 平台 | 要求 |
| --- | --- |
| macOS | macOS 12 或更高；通用版本，Apple Silicon 和 Intel 都能运行 |
| Windows | Windows 10 / 11 64 位；显卡需支持 Vulkan 或 Direct3D 12 |

建议使用独立显卡或较新的集成显卡。A recent GPU is recommended.

## 打开游戏 · How to open

### macOS

1. 解压 zip，把 `Wildbound.app` 拖到「应用程序」（或任意文件夹）。
2. 这个版本没有经过 Apple 签名公证，第一次打开时：在 `Wildbound.app` 上**右键 → 打开**，再在弹窗里点「打开」。
3. 如果提示「已损坏，无法打开」，在终端里运行：

   ```sh
   xattr -cr /Applications/Wildbound.app
   ```

The app is not notarized: right-click → Open the first time, or run `xattr -cr Wildbound.app` if macOS says it is damaged.

### Windows

1. 解压 zip，进入 `Wildbound` 文件夹，双击 `Wildbound.exe`。
2. 如果出现 SmartScreen 提示「Windows 已保护你的电脑」，点**更多信息 → 仍要运行**。

The exe is not code-signed: in the SmartScreen dialog click "More info" → "Run anyway".

## 操作 · Controls

WASD 移动，Shift 冲刺，空格跳跃，C / Ctrl 蹲下，鼠标视角，F 交互 / 采集，Tab 背包，1–4 手上装备，E 甩开咬住的蛇，O 切换第三人称，B 扎帐篷，G 发动随从能力。

## 反馈 · Feedback

遇到问题欢迎在 [Issues](https://github.com/Sandglass-vic/WildBound/issues) 里反馈，附上系统版本和显卡型号。
