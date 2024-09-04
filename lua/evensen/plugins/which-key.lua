-- Displays a popup with available keybindings when
-- you start typing a key sequence, helping you
-- discover and remember commands more easily.
-- which-key helps you remember key bindings by showing a popup
-- with the active keybindings of the command you started typing.
return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup({
      icons = {
        -- set icon mappings to true if you have a Nerd Font
        mappings = vim.g.have_nerd_font,
        -- If you are using a Nerd Font: set icons.keys to an empty table which will use the
        -- default whick-key.nvim defined Nerd Font icons, otherwise define a string table
        keys = vim.g.have_nerd_font and {} or {
          Up = '<Up> ',
          Down = '<Down> ',
          Left = '<Left> ',
          Right = '<Right> ',
          C = '<C-…> ',
          M = '<M-…> ',
          D = '<D-…> ',
          S = '<S-…> ',
          CR = '<CR> ',
          Esc = '<Esc> ',
          ScrollWheelDown = '<ScrollWheelDown> ',
          ScrollWheelUp = '<ScrollWheelUp> ',
          NL = '<NL> ',
          BS = '<BS> ',
          Space = '<Space> ',
          Tab = '<Tab> ',
          F1 = '<F1>',
          F2 = '<F2>',
          F3 = '<F3>',
          F4 = '<F4>',
          F5 = '<F5>',
          F6 = '<F6>',
          F7 = '<F7>',
          F8 = '<F8>',
          F9 = '<F9>',
          F10 = '<F10>',
          F11 = '<F11>',
          F12 = '<F12>',
        },
      },
    })

    -- Document existing key chains
    require('which-key').add({
      { '<leader>b', group = 'Buffer' },
      { '<leader>c', group = 'Code' },
      -- { '<leader>d', group = 'Document' },
      { '<leader>e', group = 'Explore files' },
      { '<leader>f', group = 'Find/search' },
      { '<leader>r', group = 'Rename' },
      { '<leader>s', group = 'Split' },
      { '<leader>w', group = 'Workspace' },
      { '<leader>t', group = 'Toggle' },
      -- { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
    })
  end,
}
