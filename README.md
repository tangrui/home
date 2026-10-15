# Home 配置

这个仓库保存多台 macOS 共用的 dotfiles。配置文件放在 `~/Home`，chezmoi 根据 `home/` 中的清单，把主目录中的配置软链接到仓库。Git 管理配置内容，chezmoi 管理链接；修改仓库文件后，本机通过软链接立即生效。

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

这些命令可在任意目录运行。`init` 把仓库克隆到 `~/Home`，连同 Git 子模块一起检出，并在 `~/.config/chezmoi/chezmoi.toml` 中记录仓库位置。`diff` 预览将建立或更改的链接；确认后运行 `apply`，最后用 `verify` 检查链接。如果主目录已有同名文件，先查看差异，再处理 chezmoi 给出的提示。

仓库根目录的 `.chezmoiroot` 指向 `home/`：那里只声明需要安装哪些配置。

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

## 二、已有 Mac 安装（已克隆仓库）

如果这台 Mac 已有 `~/Home`，先确认仓库中已经包含 `.chezmoiroot` 和 `home/`，并保留尚未提交的本地修改。Oh My Zsh 和 Vim 若已在使用，无需重新安装；chezmoi 尚未安装时，先运行 `brew install chezmoi`。

在任意目录执行以下命令，预览并接管主目录中的链接：

```sh
chezmoi --source "$HOME/Home" init
chezmoi diff
chezmoi apply
chezmoi verify
```

这里的 `init` 使用已有仓库，不会重新克隆。原来指向 `~/Home` 的正确软链接会保留；若主目录中有同名普通文件，先通过 `diff` 查看差异，再处理 `apply` 给出的提示。已初始化过 chezmoi 的机器无需重复运行 `init`。

如果 Vim 的 `Vundle.vim` 子模块尚未检出，运行 `git -C "$HOME/Home" submodule update --init --recursive`；其他 Vim 插件尚未安装时，再运行 `vim +PluginInstall +qall`。

## 三、日常维护

直接编辑 `~/Home` 中的配置文件，用 Git 查看差异、提交并推送；由于主目录使用软链接，内容改动无需再次运行 `chezmoi apply`。另一台 Mac 可以运行 `chezmoi update` 拉取仓库改动并应用链接。

`git status` 查看配置内容的改动，`chezmoi status` 或 `chezmoi verify` 检查主目录链接是否符合清单。新增或移除受管理的文件时，修改 `home/` 中的清单，再运行 `chezmoi diff` 和 `chezmoi apply`。

每台机器独有的 Git 设置放在 `~/.gitconfig.local`，Vim 设置放在 `~/.vimrc.local`；这两个文件不由本仓库管理。`.npmrc` 也不纳入仓库。
