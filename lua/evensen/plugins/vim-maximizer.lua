-- Maximize and restore the current
-- active window in the editor.
return {
  'szw/vim-maximizer',
  keys = {
    { '<leader>sm', '<cmd>MaximizerToggle<CR>', desc = 'Maximize/minimize a split' },
  },
}
