vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.colorcolumn = "100"

opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.softtabstop = 4
opt.smartindent = true

opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.splitbelow = true
opt.splitright = true

opt.undofile = true
opt.swapfile = false
opt.backup = false

opt.termguicolors = true
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }

opt.confirm = true
opt.splitkeep = "screen"
opt.laststatus = 3
opt.showmode = false

opt.spelllang = { "en_us" }

local release = vim.uv.os_uname().release:lower()

if release:find("microsoft", 1, true) then
  vim.g.clipboard = {
    name = "WSL clipboard",
    copy = {
      ["+"] = "/mnt/c/Windows/System32/clip.exe",
      ["*"] = "/mnt/c/Windows/System32/clip.exe",
    },
    paste = {
      ["+"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -Command \'[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))\'',
      ["*"] = '/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoLogo -NoProfile -Command \'[Console]::Out.Write($(Get-Clipboard -Raw).ToString().Replace("`r", ""))\'',
    },
    cache_enabled = 0,
  }
end
opt.clipboard = "unnamedplus"
