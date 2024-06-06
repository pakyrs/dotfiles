vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
vim.g.mapleader = " "
vim.g.background = "light"

-- Disable swap file
vim.opt.swapfile = false

-- Enable line numbers for the current window
vim.wo.number = true

-- Enable line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse support
vim.opt.mouse = 'a'

-- Enable clipboard support
vim.opt.clipboard = 'unnamedplus'

-- Set tab width and spaces
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- Enable syntax highlighting
vim.cmd('syntax on')

-- Enable true color support
vim.opt.termguicolors = true

-- Enable line wrapping
vim.opt.wrap = false

-- Set search options
vim.opt.ignorecase = true
vim.opt.smartcase = true

