-- bootstrap lazy.nvim, LazyVim and your plugins
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.api.nvim_command("packadd packer.nvim")
end

require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-treesitter/nvim-treesitter'
  use 'dracula/vim'
  use 'hoob3rt/lualine.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'tpope/vim-fugitive'
end)

-- 基本設定
vim.o.backspace = "indent,eol,start"

-- Emmet-vimの設定
vim.g.user_emmet_leader_key = "<c-f>"

-- その他の主要な設定
vim.o.encoding = "utf-8"
vim.o.scriptencoding = "utf-8"
vim.o.nobackup = true
vim.o.noswapfile = true
vim.o.autoread = true
vim.o.clipboard = "unnamed"
vim.o.belloff = "all"
vim.o.mouse = "a"

-- 外観の設定
vim.o.number = true
vim.o.relativenumber = true
vim.o.cursorline = true
vim.o.smartindent = true
vim.o.showmatch = true
vim.o.listchars = "tab:^\\ ,trail:~"
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.title = true
vim.o.display = "lastline"
vim.o.list = true
vim.o.completeopt = "menuone"

-- 検索設定
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.smartcase = true
vim.o.wrapscan = true

-- 矢印キーを無効にする
vim.api.nvim_set_keymap("n", "<Up>", "<Nop>", {})
vim.api.nvim_set_keymap("n", "<Down>", "<Nop>", {})
vim.api.nvim_set_keymap("n", "<Left>", "<Nop>", {})
vim.api.nvim_set_keymap("n", "<Right>", "<Nop>", {})
vim.api.nvim_set_keymap("i", "<Up>", "<Nop>", {})
vim.api.nvim_set_keymap("i", "<Down>", "<Nop>", {})
vim.api.nvim_set_keymap("i", "<Left>", "<Nop>", {})
vim.api.nvim_set_keymap("i", "<Right>", "<Nop>", {})

vim.cmd [[
  augroup colorscheme_setup
    autocmd!
    autocmd VimEnter * colorscheme dracula
  augroup end
]]
