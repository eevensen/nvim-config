-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
vim.o.number = true
vim.o.numberwidth = 2
vim.o.ruler = false
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false
-- vim.opt.cursorline = true
-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.timeoutlen = 400

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 8

-- tabs & indentation
vim.o.tabstop = 2 -- 2 spaces for tabs (prettier default)
vim.o.shiftwidth = 2 -- 2 spaces for indent width
vim.o.expandtab = true -- expand tab to spaces
vim.o.autoindent = true -- copy indent from current line when starting new one

vim.o.wrap = false

-- turn on termguicolors for tokyonight colorscheme to work
-- (have to use iterm2 or any other true color terminal)
vim.o.termguicolors = true
vim.o.background = 'dark' -- colorschemes that can be light or dark will be made dark

-- backspace
vim.opt.backspace = 'indent,eol,start' -- allow backspace on indent, end of line or insert mode start position

-- turn off swapfile
vim.o.swapfile = false

vim.opt.fillchars = { eob = ' ' }

-- disable nvim intro
vim.opt.shortmess:append 'sI'

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
vim.opt.whichwrap:append '<>[]hl'

-- vim.cmd 'let g:netrw_liststyle = 1'
