-- Visual representation of the undo history,
-- allowing users to navigate and
-- manipulate undo branches.
return {
  'mbbill/undotree',
  vim.keymap.set('n', '<leader>cu', vim.cmd.UndotreeToggle, { desc = '[C]ode [U]ndo tree (toggle)' }),

  'debugloop/telescope-undo.nvim',
  dependencies = { -- note how they're inverted to above example
    {
      'nvim-telescope/telescope.nvim',
      dependencies = { 'nvim-lua/plenary.nvim' },
    },
  },
  keys = {
    { -- lazy style key map
      '<leader>cu',
      '<cmd>Telescope undo<cr>',
      desc = '[C]ode [U]ndo history',
    },
  },
  opts = {
    -- don't use `defaults = { }` here, do this in the main telescope spec
    extensions = {
      undo = {
        -- telescope-undo.nvim config, see below
      },
      -- no other extensions here, they can have their own spec too
    },
  },
  config = function(_, opts)
    -- Calling telescope's setup from multiple specs does not hurt, it will happily merge the
    -- configs for us. We won't use data, as everything is in it's own namespace (telescope
    -- defaults, as well as each extension).
    require('telescope').setup(opts)
    require('telescope').load_extension('undo')
  end,
}
