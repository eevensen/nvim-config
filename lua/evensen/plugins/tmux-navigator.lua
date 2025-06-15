return {
  'christoomey/vim-tmux-navigator', -- tmux & split window navigation
  lazy = false, -- Keep this loaded for navigation keys
  keys = {
    { '<C-h>', '<cmd>TmuxNavigateLeft<cr>', desc = 'Navigate Left' },
    { '<C-j>', '<cmd>TmuxNavigateDown<cr>', desc = 'Navigate Down' },
    { '<C-k>', '<cmd>TmuxNavigateUp<cr>', desc = 'Navigate Up' },
    { '<C-l>', '<cmd>TmuxNavigateRight<cr>', desc = 'Navigate Right' },
  },
}
