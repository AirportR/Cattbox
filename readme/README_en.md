<h4 align="right">
  <a href="../README.md">简体中文</a> | <strong>English</strong> | <a href="README_ru.md">Русский</a> | <a href="README_fa.md">فارسی</a> | <a href="README_ja.md">日本語</a> | <a href="README_ko.md">한국어</a>
</h4>

<h1 align="center">⚡ Cattbox</h1>
<p align="center">
  <strong>Another Better Network Toolbox</strong>
</p>

**Cattbox is a cross-platform network traffic routing and DNS debugging tool built on the Mihomo core. It focuses on an outstanding user experience, is built for long-term stable operation, stays lightweight on resources, and collects no data at all.**

This is a fork of [Bettbox](https://github.com/appshubcc/Bettbox) with upstream promotional content removed. Differences are listed below.

[![Latest Release](https://img.shields.io/github/v/release/AirportR/Cattbox?style=for-the-badge&logo=github&color=238636&label=Release)](https://github.com/AirportR/Cattbox/releases/latest) [![Core](https://img.shields.io/github/v/release/MetaCubeX/mihomo?style=for-the-badge&logo=go&logoColor=white&color=8A2BE2&label=Mihomo)](https://github.com/MetaCubeX/mihomo/releases/latest)

<p align="center">
  <img src="../snapshots/home.jpg" alt="Cattbox" />
</p>

## 🔀 Fork-Only Features

* Remote URL profiles support a custom User-Agent.
* Supports additional protocols not yet available in Mihomo (x365, Miu, Ninja).


---
## 🚀 Core Features

* **Out-of-the-Box**: Permission guidance, TUN, and managed routing mode come preconfigured, ready to use right after installation.
* **Lightweight & Smooth**: Low power consumption on mobile, low background usage on desktop, and smooth interface animations.
* **Security & Trustworthy**: The core tracks upstream Mihomo, and each platform requests only the minimum privileges it needs.
* **Stability & Fault Tolerance**: Optimized edge-case behavior in extreme network environments across platforms; dual configuration verification suits long-term operation.
* **Architecture Optimization**: Native ARM64 support on desktop, with continued maintenance of the Compatible edition for legacy devices.
* **Smart Daemon**: Smart start/stop across platforms, adaptation to mobile Doze sleep, and quick controls from the tray on desktop platforms.
* **Visual Settings**: Visual parameter tuning with instant effect, so even beginners never need to edit configuration by hand.
* **Home Widgets**: Several beautifully crafted built-in widgets let you monitor overall operating status right from the home screen.
* **All-in-One Toolbox**: Built-in professional-grade network and DNS routing debugging tools make your network status clear at a glance.
* **Personalization**: Material Design–style color themes, custom icons and titles, and even 30 speedtest animations.
* **Ecosystem & Extension**: External JS override scripts can adapt to a graphical interface, and a high-performance Code-forge editor is built in.
* **Zero Privacy Risk**: Open-source code, no ads, fully automated and publicly auditable CI/CD, and no background data collection.

---
## 🛠️ Installation & Downloads

Please visit the **[[Releases]](https://github.com/AirportR/Cattbox/releases)** page to download the latest installer suitable for your platform and operating system:

* **Desktop Support**: 
  * **Windows 8.1+:** (x64 / arm64)
  * **Linux Kernel 5.4+:** (x64 / arm64)
  * **macOS 12.0+:** (Intel / Apple Silicon)
* **Mobile & Others**: 
  * **Android 8.0+:** (ARMv8 / ARMv7 / x86_64 / Universal) 
  * **Android TV:** Full large-screen adaptation, optional ARMv7 32-bit version
  * **HarmonyOS NEXT:** Can be used stably with [[ZhuoYiTong]](https://harmonyos.cool/android-app)


---
## 💡 Frequently Asked Questions

1. **System Requirements & Compatibility**:
   - For Android devices, ensure sufficient background execution permissions are granted; system must meet Android 8.0+.
   - For legacy desktop hardware, please choose the corresponding Compatible build based on CPU instruction set architecture.
   - Security: Cattbox is open source, transparent, and collects no data.

2. **Desktop Permissions & TUN**:
   - Windows administrator permissions are pre-handled by the installer; daily usage requires no manual re-authorization.
   - When enabling the TUN virtual network adapter on macOS / Linux, enter the correct system password when prompted to complete authorization.
   - For other errors, verify that no conflicting proxy tools are occupying ports in the background, and include debug logs when submitting feedback.

3. **macOS First-Time Installation Guide**:
   - Download and open the `.dmg` installer according to your platform (Intel / Apple Silicon), and drag the Cattbox icon into the Applications folder.
   - **Bypassing System Security Gatekeeper** ([Apple Commercial Developer Certificate is not currently purchased](https://support.apple.com/en-us/102445)):
     - **Recommended**: In "Finder - Applications", **right-click the Cattbox icon and select "Open"**, then click "Open" in the system confirmation prompt.
     - **Alternative**: If blocked, navigate to System "Settings -> Privacy & Security", locate Cattbox, and click "Open Anyway".
   - When enabling TUN mode for the first time, a system password prompt will appear; enter your password to allow the creation of the virtual network interface.

4. **Subscription Import & Troubleshooting**:
   - If import fails, please reset the subscription URL in your service provider's dashboard and try again.
   - If the issue persists, verify the node formats with your provider; if confirmed to be a client issue, feel free to submit an Issue.

---
## 💻 Development, Building & UI Adaptation

Taking Windows build as an example:

* System Requirements: Windows 10 or later
* Dependencies: Git, Visual Studio, Flutter 3.47.x, Golang, Inno Setup, Rust
```bash
* flutter pub get (fetch dependencies)
* dart .\setup.dart windows --arch amd64 --out core (build Core only)
* dart .\setup.dart windows --arch amd64 --out app --compatible (optional compatible build)
* After building, final artifacts are located in the `dist/` directory
```

Custom Script UI Adaptation:

* Cattbox supports graphical UI adaptation for external override scripts. Taking AIsouler's **[Script/Config Repository](https://github.com/AIsouler/MyClash)** as an example, simply add the following declaration at the first line of the script to directly link with built-in visual toggles:
* <code>const Compatible_With_Bettbox = { ruleOptionsEnable: true };</code>
* If the script switches include policy groups and other function switches, you can declare policy group switch names via `policyGroupOptions`; undeclared switches will be automatically grouped under the "⚙️ Other Settings" secondary menu:

```js
const Compatible_With_Bettbox = {
  ruleOptionsEnable: true,
  // Declare switch names belonging to policy groups; must match keys in ruleOptionsEnable exactly
  policyGroupOptions: ['🚀 节点选择', '🛑 广告拦截'],
};
```
* If `policyGroupOptions` is undeclared or names do not match, all toggles will be displayed flat.

---
## ❤️ Acknowledgments

<table>
  <tr>
    <td>
      <img alt="SignPath" src="https://signpath.org/assets/favicon-50x50.png" />
    </td>
    <td>
    Free code signing on Windows provided by <a href="https://signpath.io">SignPath.io</a>, certificate by <a href="https://signpath.org/">SignPath Foundation</a>
    </td>
  </tr>
</table>

* **[FlClash GUI](https://github.com/chen08209/FlClash)** (This project originated from the excellent open-source project FlClash; tribute to the original author's pioneering exploration and contributions)
* **[Mihomo Core](https://github.com/MetaCubeX/mihomo)** (Powerful and flexible core driver)

Thanks to all [Contributors](https://github.com/AirportR/Cattbox/graphs/contributors) who have contributed to this project, as well as the following open-source projects for their inspiration and reference:

[Zashboard](https://github.com/Zephyruso/zashboard), [CMFA](https://github.com/MetaCubeX/ClashMetaForAndroid), [Sparkle](https://github.com/xishang0128/sparkle), [SFA](https://github.com/SagerNet/sing-box-for-android), [HUSI](https://github.com/xchacha20-poly1305/husi), [V2rayN](https://github.com/2dust/v2rayN), [Bett-rules](https://github.com/appshubcc/bett-rules)

---
## 📄 License

This project is licensed under the [GPL-3.0 License](../LICENSE).
