# Home 配置

这个仓库保存多台 macOS 共用的 dotfiles。配置文件放在 `~/Home`，chezmoi 根据 `chezmoi/` 中的清单，把主目录中的配置软链接到仓库。Git 管理配置内容，chezmoi 管理链接；修改仓库文件后，本机通过软链接立即生效。

## 一、新 Mac 安装

### 1. 配置 chezmoi

先确保已安装 Git 和 Homebrew，再运行：

```sh
brew install chezmoi
chezmoi --source "$HOME/Home" init --recurse-submodules https://github.com/tangrui/home
chezmoi diff
chezmoi apply
chezmoi verify
```

这些命令可在任意目录运行。`init` 把仓库克隆到 `~/Home`，连同 Vundle 子模块一起检出，并在 `~/.config/chezmoi/chezmoi.toml` 中记录仓库位置。`diff` 预览将建立或更改的链接；确认后运行 `apply`，最后用 `verify` 检查链接。如果主目录已有同名文件，先查看差异，再处理 chezmoi 给出的提示。

仓库根目录的 `.chezmoiroot` 指向 `chezmoi/`：那里只声明需要安装哪些配置。

### 2. 配置 Oh My Zsh

此仓库管理 `.zshrc`，不管理 Oh My Zsh 程序本身。先检查 `~/.oh-my-zsh/oh-my-zsh.sh` 是否存在；仅在尚未安装时运行：

```sh
git clone https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
```

`.zshrc` 从该目录加载 Oh My Zsh，并启用 `git`、`uv`、`zsh-syntax-highlighting` 和 `zsh-autosuggestions` 插件。使用 `uv` 命令还需要在新 Mac 上另行安装 `uv`。没有安装 Oh My Zsh 时，`.zshrc` 会跳过加载，基础 Shell 仍可启动。自定义目录使用 Oh My Zsh 默认的 `~/.oh-my-zsh/custom`，不另行指定 `ZSH_CUSTOM`。

### 3. 配置 Vim

chezmoi 将 `~/.vimrc` 和整个 `~/.vim` 目录链接到 `~/Home`。Vim 配置使用 Vundle：`Vundle.vim` 是仓库中的 Git 子模块，其他插件按配置下载，不提交到 Git。

新 Mac 执行前面的 `init --recurse-submodules` 后，运行：

```sh
vim +PluginInstall +qall
```

插件会下载到 `~/Home/.vim/bundle/`；该目录中的下载内容被 Git 忽略，换一台 Mac 时重新安装即可。

### 4. 配置 Ghostty

chezmoi 将 `~/.config/ghostty/config.ghostty` 链接到仓库。当前配置使用 Ghostty 自带的 `Catppuccin Frappe` 主题、`Maple Mono NF CN` 字体和字号 `13`。新 Mac 如尚未安装 Ghostty 和字体，可运行：

```sh
brew install --cask ghostty
brew install --cask font-maple-mono-nf-cn
```

字体需单独安装；仅同步配置文件不会安装字体。安装命令可在 [Ghostty](https://formulae.brew.sh/cask/ghostty) 和 [Maple Mono NF CN](https://formulae.brew.sh/cask/font-maple-mono-nf-cn) 的 Homebrew 页面核对。Ghostty 在 macOS 上还会读取 `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`，该文件中的同名选项会覆盖仓库配置；如果它有内容，请合并设置，避免在两处分别修改。

配置还启用了 `ssh-env` 和 `ssh-terminfo`：在 Ghostty 的交互式 Shell 中运行 `ssh` 时，会转发终端环境，并在需要时尝试为远端安装 Ghostty 的 terminfo。参见 [Ghostty SSH 文档](https://ghostty.org/docs/features/ssh)。

### 5. 配置 Yazi

chezmoi 将 `~/.config/yazi/yazi.toml` 和 `~/.config/yazi/package.toml` 链接到仓库。当前配置使用 Yazi 官方的 `piper` 插件调用 `glow` 预览 Markdown；插件版本由 `package.toml` 记录。新 Mac 安装所需程序和插件：

```sh
brew install yazi glow
ya pkg install
```

`brew install yazi` 同时提供 `yazi` 和插件管理命令 `ya`。`ya pkg install` 根据已链接的 `package.toml` 下载 `piper`；下载的插件保存在本机 `~/.config/yazi/plugins/`，不加入仓库。插件管理方式见 [Yazi 官方文档](https://yazi-rs.github.io/docs/cli/)。

### 6. 配置 GitHub CLI

chezmoi 只将 `~/.config/gh/config.yml` 链接到仓库，其中保存 HTTPS 协议、交互偏好和 `gh co` 别名；`~/.config/gh` 目录按私有目录管理，目标权限为 `0700`。新 Mac 如尚未安装 GitHub CLI，可运行：

```sh
brew install gh
gh auth login
```

`gh auth login` 需要在每台 Mac 上分别完成。登录状态保存在本机凭据存储或 `~/.config/gh/hosts.yml`，后者不加入仓库；同步 `config.yml` 不会同步登录信息。配置项见 [GitHub CLI 文档](https://cli.github.com/manual/gh_config)。

### 7. 配置全局 AGENTS.md

`global-agent-rules.md` 是 Codex 与 OpenCode 共用的全局规则正文。chezmoi 分别将 `~/.codex/AGENTS.md` 和 `~/.config/opencode/AGENTS.md` 链接到它；修改仓库中的这一份文件即可同步本机两个入口。仓库根目录特意不命名为 `AGENTS.md`，避免在处理本仓库时把同一份规则再作为项目规则加载。

新 Mac 执行 `chezmoi apply` 后即可建立两个链接。规则通常在新会话开始时读取，修改后请启动新会话验证。项目自己的 `AGENTS.md` 仍留在对应项目中，负责补充该项目的要求。参见 [Codex 文档](https://learn.chatgpt.com/docs/agent-configuration/agents-md) 和 [OpenCode 文档](https://docs.opencode.ai/docs/rules/)。

### 8. 配置 Claude Code

chezmoi 还将 `~/.claude/CLAUDE.md` 链接到同一份 `global-agent-rules.md`。这样 Claude Code 在各个项目中使用与你的 Codex、OpenCode 一致的全局规则，无需维护第三份正文。新 Mac 如尚未安装 Claude Code，可运行：

```sh
brew install --cask claude-code
claude
```

首次运行 `claude` 时按提示登录；链接不会同步登录状态。安装方式见 [Claude Code 官方文档](https://code.claude.com/docs/en/setup)。

`~/.claude/settings.json` 保留在本机：其中的 DevToys 钩子使用本机路径，状态栏依赖另行安装的 `ccline`。`~/.claude.json`、技能、插件和运行记录也不由这个仓库接管。项目中的 `CLAUDE.md` 或 `AGENTS.md` 继续由各项目管理；Claude Code 在新会话开始时加载规则，可在会话中用 `/memory` 查看已加载的文件。参见 [Claude Code 规则文档](https://code.claude.com/docs/en/memory)。

### 9. 配置 OpenCode

chezmoi 将 `~/.config/opencode/opencode.json` 链接到仓库，保留当前自定义提供商及模型列表。配置使用 OpenCode 2 的 `providers` 格式。新 Mac 如使用桌面版，从 [OpenCode 官网](https://opencode.ai/desktop)下载对应的 macOS 安装包；如使用命令行版，可运行：

```sh
brew install anomalyco/tap/opencode-v2
```

提供商密钥和专属接口地址不放进仓库。每台 Mac 分别创建 `~/.config/opencode/provider-api-key` 和 `~/.config/opencode/provider-base-url`：文件内容只写实际值，不写 `KEY=` 前缀，并将权限设为 `0600`。`opencode.json` 使用 `{file:~/.config/opencode/...}` 在运行时读取它们；从终端或桌面图标启动都不依赖 Zsh 环境变量。只同步仓库而未创建这两个本机文件时，自定义提供商无法使用。参见 [OpenCode 2 安装说明](https://opencode.ai/v2/docs/)和[配置说明](https://opencode.ai/v2/docs/config/)。

`service.json` 和旧的备选配置 `opencode.json.anthropic` 保留在本机，不由 chezmoi 管理。

## 二、已有 Mac 安装（已克隆仓库）

如果这台 Mac 已有 `~/Home`，先确认仓库中已经包含 `.chezmoiroot` 和 `chezmoi/`，并保留尚未提交的本地修改。Oh My Zsh、Vim、Ghostty、Yazi、`glow`、GitHub CLI、Claude Code、OpenCode 和 Maple Mono 字体若已在使用，无需重新安装；chezmoi 尚未安装时，先运行 `brew install chezmoi`。

在任意目录执行以下命令，预览并接管主目录中的链接。原有配置若是普通文件，`chezmoi diff` 会显示把它们改为软链接；先确认仓库中的对应文件包含想保留的设置。尤其要先比较现有的两份 `AGENTS.md` 和 `~/.claude/CLAUDE.md`，将独有规则合并到 `global-agent-rules.md`；如果现有 `opencode.json` 写有密钥和专属接口地址，先将它们分别存入本机的 `provider-api-key` 和 `provider-base-url`，再运行 `chezmoi apply`：

```sh
chezmoi --source "$HOME/Home" init
chezmoi diff
chezmoi apply
chezmoi verify
```

这里的 `init` 使用已有仓库，不会重新克隆。原来指向 `~/Home` 的正确软链接会保留；若主目录中有同名普通文件，先通过 `diff` 查看差异，再处理 `apply` 给出的提示。已初始化过 chezmoi 的机器无需重复运行 `init`。

如果 Vim 的 `Vundle.vim` 子模块尚未检出，运行 `git -C "$HOME/Home" submodule update --init --recursive`；其他 Vim 插件尚未安装时，再运行 `vim +PluginInstall +qall`。

Yazi 若只缺少 `piper` 插件，运行 `ya pkg install` 即可恢复。

## 三、日常维护

直接编辑 `~/Home` 中的配置文件，用 Git 查看差异、提交并推送；由于主目录使用软链接，内容改动无需再次运行 `chezmoi apply`。另一台 Mac 可以运行 `chezmoi update` 拉取仓库改动并应用链接。

`git status` 查看配置内容的改动，`chezmoi status` 或 `chezmoi verify` 检查主目录链接是否符合清单。新增或移除受管理的文件时，修改 `chezmoi/` 中的清单，再运行 `chezmoi diff` 和 `chezmoi apply`。

每台机器独有的 Git 设置放在 `~/.gitconfig.local`，Vim 设置放在 `~/.vimrc.local`；这两个文件不由本仓库管理。`.npmrc` 也不纳入仓库。
