<h1 align="center">
    nvimdots
    <br>
    <a href="https://github.com/neovim/neovim/releases/tag/nightly">
    <img
        alt="NeoVim Version Capability"
        src="https://img.shields.io/badge/SUPPORTS_NVIM-V0.10-green?style=for-the-badge&logo=neovim&logoColor=D9E0EE&labelColor=363A4F&color=A6D895">
    </a>
    <img
        alt="Code Size"
        src="https://img.shields.io/badge/CODE_SIZE-664KB-purple?style=for-the-badge&logo=gitlfs&logoColor=D9E0EE&labelColor=363A4F&color=DDB6F2">
</h1>

## 🪷 Introduction

This repo hosts our [NeoVim](https://neovim.io/) configuration for Linux [(with NixOS support)](#nixos-support), macOS, and Windows. `init.lua` is the config entry point.

Branch info:

<div align="center">

| Branch | Supported neovim version |
| :----: | :----------------------: |
|  main  |       nvim 0.10 dev      |
|  main   |         nvim 0.9        |

</div>

We currently manage plugins using [lazy.nvim](https://github.com/folke/lazy.nvim).

Chinese introduction is [here](https://zhuanlan.zhihu.com/p/382092667).

### 🎐 Features

- **Fast.** Less than **30ms** to start (Depends on SSD and CPU, tested on Zephyrus G14 2022 version).
- **Simple.** Run out of the box.
- **Modern.** Pure `lua` config.
- **Modular.** Easy to customize.
- **Powerful.** Full functionality to code.

## 🏗 How to Install

Just run the following interactive bootstrap command, and you're good to go 👍

- **Windows** _(Note: This script REQUIRES `pwsh` > `v7.1`)_

```pwsh
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/yjy66630/nvimdots/HEAD/scripts/install.ps1'))
```

- **\*nix**

```sh
if command -v curl >/dev/null 2>&1; then
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/yjy66630/nvimdots/HEAD/scripts/install.sh)"
else
    bash -c "$(wget -O- https://raw.githubusercontent.com/yjy66630/nvimdots/HEAD/scripts/install.sh)"
fi
```

It's strongly recommended to read [Wiki: Prerequisites](https://github.com/ayamir/nvimdots/wiki/Prerequisites) before starting, especially for \*nix users.

## ⚙️ Configuration & Usage

<h3 align="center">
    🗺️ Keybindings
</h3>
<p align="center">See <a href="https://github.com/ayamir/nvimdots/wiki/Keybindings" rel="nofollow">Wiki: Keybindings</a> for details</p>
<br>

<h3 align="center">
    🔌 Plugins & Deps
</h3>
<p align="center">See <a href="https://github.com/ayamir/nvimdots/wiki/Plugins" rel="nofollow">Wiki: Plugins</a> for details <br><em>(You can also find a deps diagram there!)</em></p>
<br>

<h3 align="center">
    🔧 Usage & Customization
</h3>
<p align="center">See <a href="https://github.com/ayamir/nvimdots/wiki/Usage" rel="nofollow">Wiki: Usage</a> for details</p>
<br>

<h3 align="center" id="nixos-support" name="nixos-support">
    ❄️  NixOS Support
</h3>
<p align="center">See <a href="https://github.com/ayamir/nvimdots/wiki/NixOS-Support" rel="nofollow">Wiki: NixOS Support</a> for details</p>
<br>

<h3 align="center">
    🤔 FAQ
</h3>
<p align="center">See <a href="https://github.com/ayamir/nvimdots/wiki/Issues" rel="nofollow">Wiki: FAQ</a> for details</p>

## ✨ Features

<h3 align="center">
    ⏱️  Startup Time
</h3>

<p align="center">
  <img src="https://github.com/yjy66630/nvimdots/assets/62711034/7dd42d94-26c1-46d3-b400-588925940a1c"
  width = "80%"
  alt = "StartupTime"
  />
</p>

<h3 align="center">
    📸 Screenshots
</h3>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/6557f0a8-4989-4730-b558-2a2babc80093" alt="Dashboard">
    <em>Dashboard</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/e7edeb41-8334-40e3-b581-be36059fb345" alt="Telescope">
    <em>Telescope</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/f4333982-a367-4a4b-a412-665de68549a5" alt="Coding">
    <em>Coding</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/db2997b1-354d-4dfb-b94f-709c46566a00" alt="Code Action">
    <em>Code Action</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/d9bdaa4b-a5d6-49fb-b5aa-f12ace39a7e1" alt="Debugging">
    <em>Debugging</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/10382522-49c2-4e8f-8975-e36ab35f16d2" alt="CMakeTools">
    <em>CMakeTools</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/44424332-df5e-4d6c-94c2-8a1b82e30224" alt="Lazygit">
    <em>Lazygit with built-in Terminal</em>
</p>
<br>

<p align="center">
    <img src="https://github.com/yjy66630/nvimdots/assets/62711034/118cfd35-896d-46d6-b451-0a65c40f3723" alt="Command quickref">
    <em>Command quickref</em>
</p>

## 👐 Contributing

- If you find anything that needs improving, do not hesitate to point it out or create a PR.
- If you come across an issue, you can first use `:checkhealth` command provided by nvim to trouble-shoot yourself.
  - If you still have such problems, feel free to open a new issue!

## ❤️ Thanks to

- [ayamir](https://github.com/ayamir)

## 📜 License

This NeoVim configuration is released under the MIT license, which grants the following permissions:

- Commercial use
- Distribution
- Modification
- Private use
