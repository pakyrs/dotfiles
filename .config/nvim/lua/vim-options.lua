vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")
-- set leader key to space
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
-- Key mapping to copy to system clipboard in normal mode
vim.keymap.set('n', '<leader>c', '"+y$')
-- Key mapping to copy to system clipboard in visual mode
vim.keymap.set('v', '<leader>c', '"+y')
-- OSC52 clipboard - not working
--vim.api.nvim_create_autocmd('TextYankPost', {
--    callback = function()
--        vim.highlight.on_yank()
--        local copy_to_unnamedplus = require('vim.ui.clipboard.osc52').copy('+')
--        copy_to_unnamedplus(vim.v.event.regcontents)
--        local copy_to_unnamed = require('vim.ui.clipboard.osc52').copy('*')
--        copy_to_unnamed(vim.v.event.regcontents)
--    end
--})

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

