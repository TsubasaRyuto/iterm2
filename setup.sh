#!/bin/bash

# Homebrewがインストールされているか確認
if ! command -v brew &> /dev/null
then
    echo "Homebrewがインストールされていません。Homebrewをインストールします"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/xxx/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Git, Node.jsのインストール
if ! command -v git &> /dev/null; then
    echo "Gitをインストールしています..."
    brew install git
fi

if ! command -v node &> /dev/null; then
    echo "Node.jsをインストールしています..."
    brew install node
fi

# Oh My Zshのインストール
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Oh My Zshをインストールしています..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# zsh-autosuggestionsのインストール
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ]; then
    echo "zsh-autosuggestionsをインストールしています..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

# zsh-syntax-highlightingのインストール
if [ ! -d "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting" ]; then
    echo "zsh-syntax-highlightingをインストールしています..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

cp ./zsh/.zshrc ~/.zshrc

# LSPサーバーのインストール (例: pyright, typescript-language-server)
echo "LSPサーバーをインストールしています..."
npm install -g pyright typescript-language-server

# tmuxのインストール
echo "tmuxをインストールしています..."
brew install tmux

# Neovimのインストール
echo "Neovimをインストールしています..."
brew install neovim

# Packerのインストール
if [ ! -d "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim ]; then
    echo "Packerをインストールしています..."
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/pack/packer/start/packer.nvim
fi

# .tmux.confをコピー
cp ./tmux/.tmux.conf ~/.tmux.conf

# 設定ファイルのコピー
NVIM_CONFIG_DIR="$HOME/.config/nvim"

if [ ! -d "$NVIM_CONFIG_DIR" ]; then
    mkdir -p "$NVIM_CONFIG_DIR"
fi

# init.luaと他の設定ファイルをコピー
echo "設定ファイルをコピーしています..."
cp ./neovim/init.lua "$NVIM_CONFIG_DIR"
cp ./neovim/lazyvim.json "$NVIM_CONFIG_DIR"
cp ./neovim/lazy-lock.json "$NVIM_CONFIG_DIR"

# ディレクトリ構成をコピー
echo "ディレクトリ構成をコピーしています..."
cp -r ./neovim/pack "$NVIM_CONFIG_DIR"
cp -r ./neovim/starter "$NVIM_CONFIG_DIR"
cp -r ./nowvim/lua "$NVIM_CONFIG_DIR"
cp -r ./neovim/plugin "$NVIM_CONFIG_DIR"

# Neovimを起動し、Packerを使ってプラグインをインストールするコマンドを実行
nvim --headless +PackerInstall +qall

# Gitの設定ファイルをコピー
cp ./git/.gitconfig ~/.gitconfig

echo "セットアップが完了しました。"
