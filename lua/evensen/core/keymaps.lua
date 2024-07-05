-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
-- vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<Esc>', '<cmd>noh<CR>', { desc = 'general clear highlights' })

-- leave insert mode with jk
vim.keymap.set('i', 'jk', '<Esc>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "switch window left" })
-- vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "switch window right" })
-- vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "switch window down" })
-- vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "switch window up" })

-- scroll down and center cursor
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<PageUp>', '<C-u>')
vim.keymap.set('n', '<PageDown>', '<C-d>')

vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')

vim.keymap.set('x', '<leader>p', '"_dP')
-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('i', '<C-b>', '<ESC>^i', { desc = 'move beginning of line' })
vim.keymap.set('i', '<C-e>', '<End>', { desc = 'move end of line' })
vim.keymap.set('i', '<C-h>', '<Left>', { desc = 'move left' })
vim.keymap.set('i', '<C-l>', '<Right>', { desc = 'move right' })
vim.keymap.set('i', '<C-j>', '<Down>', { desc = 'move down' })
vim.keymap.set('i', '<C-k>', '<Up>', { desc = 'move up' })

vim.keymap.set('n', '<C-s>', '<cmd>w<CR>', { desc = 'file save' })
vim.keymap.set('n', '<C-c>', '<cmd>%y+<CR>', { desc = 'file copy whole' })

-- vim.keymap.set("n", "<leader>n", "<cmd>set nu!<CR>", { desc = "toggle line number" })
-- vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<CR>", { desc = "toggle relative number" })
vim.keymap.set('n', '<leader>ch', '<cmd>NvCheatsheet<CR>', { desc = 'toggle nvcheatsheet' })

vim.keymap.set('n', '<leader>fm', function()
  require('conform').format { lsp_fallback = true }
end, { desc = 'format files' })

-- global lsp mappings
vim.keymap.set('n', '<leader>ds', vim.diagnostic.setloclist, { desc = 'lsp diagnostic loclist' })

-- tabufline
vim.keymap.set('n', '<leader>b', '<cmd>enew<CR>', { desc = 'buffer new' })

-- vim.keymap.set('n', '<tab>', function()
--   require('nvchad.tabufline').next()
-- end, { desc = 'buffer goto next' })

-- vim.keymap.set('n', '<S-tab>', function()
--   require('nvchad.tabufline').prev()
-- end, { desc = 'buffer goto prev' })

-- vim.keymap.set('n', '<leader>x', function()
--   require('nvchad.tabufline').close_buffer()
-- end, { desc = 'buffer close' })

-- Comment
vim.keymap.set('n', '<leader>/', 'gcc', { desc = 'comment toggle', remap = true })
vim.keymap.set('v', '<leader>/', 'gc', { desc = 'comment toggle', remap = true })

-- nvimtree
vim.keymap.set('n', '<C-n>', '<cmd>NvimTreeToggle<CR>', { desc = 'nvimtree toggle window' })
vim.keymap.set('n', '<leader>ej', '<cmd>NvimTreeFocus<CR>', { desc = 'nvimtree focus window' })

-- terminal
vim.keymap.set('t', '<C-x>', '<C-\\><C-N>', { desc = 'terminal escape terminal mode' })

-- new terminals
-- vim.keymap.set('n', '<leader>h', function()
--   require('nvchad.term').new { pos = 'sp' }
-- end, { desc = 'terminal new horizontal term' })
--
-- vim.keymap.set('n', '<leader>v', function()
--   require('nvchad.term').new { pos = 'vsp' }
-- end, { desc = 'terminal new vertical window' })
--
-- -- toggleable
-- vim.keymap.set({ 'n', 't' }, '<A-v>', function()
--   require('nvchad.term').toggle { pos = 'vsp', id = 'vtoggleTerm' }
-- end, { desc = 'terminal toggleable vertical term' })
--
-- vim.keymap.set({ 'n', 't' }, '<A-h>', function()
--   require('nvchad.term').toggle { pos = 'sp', id = 'htoggleTerm' }
-- end, { desc = 'terminal new horizontal term' })
--
-- vim.keymap.set({ 'n', 't' }, '<A-i>', function()
--   require('nvchad.term').toggle { pos = 'float', id = 'floatTerm' }
-- end, { desc = 'terminal toggle floating term' })

-- whichkey
vim.keymap.set('n', '<leader>wK', '<cmd>WhichKey <CR>', { desc = 'whichkey all keymaps' })

vim.keymap.set('n', '<leader>wk', function()
  vim.cmd('WhichKey ' .. vim.fn.input 'WhichKey: ')
end, { desc = 'whichkey query lookup' })

-- blankline
vim.keymap.set('n', '<leader>cc', function()
  local config = { scope = {} }
  config.scope.exclude = { language = {}, node_type = {} }
  config.scope.include = { node_type = {} }
  local node = require('ibl.scope').get(vim.api.nvim_get_current_buf(), config)

  if node then
    local start_row, _, end_row, _ = node:range()
    if start_row ~= end_row then
      vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start_row + 1, 0 })
      vim.api.nvim_feedkeys('_', 'n', true)
    end
  end
end, { desc = 'blankline jump to current context' })
