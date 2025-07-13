return {
  'gbprod/yanky.nvim',
  dependencies = {
    { 'kkharji/sqlite.lua', enabled = not jit.os:find('Windows') },
  },
  opts = {
    ring = {
      history_length = 100,
      storage = 'shada',
      sync_with_numbered_registers = true,
      cancel_event = 'update',
      ignore_registers = { '_' },
      update_register_on_cycle = false,
    },
    picker = {
      select = {
        action = nil, -- nil to use default put action
      },
      telescope = {
        use_default_mappings = true, -- if default mappings should be used
        mappings = nil, -- nil to use default mappings or no mappings (see `use_default_mappings`)
      },
    },
    system_clipboard = {
      sync_with_ring = true,
    },
    highlight = {
      on_put = true,
      on_yank = true,
      timer = 500,
    },
    preserve_cursor_position = {
      enabled = true,
    },
  },
  keys = {
    -- Yank/paste with yanky
    { 'y', '<Plug>(YankyYank)', mode = { 'n', 'x' }, desc = 'Yank text' },
    { 'p', '<Plug>(YankyPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after cursor' },
    { 'P', '<Plug>(YankyPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before cursor' },
    { 'gp', '<Plug>(YankyGPutAfter)', mode = { 'n', 'x' }, desc = 'Put yanked text after selection' },
    { 'gP', '<Plug>(YankyGPutBefore)', mode = { 'n', 'x' }, desc = 'Put yanked text before selection' },

    -- Cycle through yank history
    { '<c-p>', '<Plug>(YankyPreviousEntry)', desc = 'Select previous entry through yank history' },
    { '<c-n>', '<Plug>(YankyNextEntry)', desc = 'Select next entry through yank history' },

    -- Put and indent
    { ']p', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
    { '[p', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },
    { ']P', '<Plug>(YankyPutIndentAfterLinewise)', desc = 'Put indented after cursor (linewise)' },
    { '[P', '<Plug>(YankyPutIndentBeforeLinewise)', desc = 'Put indented before cursor (linewise)' },

    -- Put and indent with filters
    { '>p', '<Plug>(YankyPutIndentAfterShiftRight)', desc = 'Put and indent right' },
    { '<p', '<Plug>(YankyPutIndentAfterShiftLeft)', desc = 'Put and indent left' },
    { '>P', '<Plug>(YankyPutIndentBeforeShiftRight)', desc = 'Put before and indent right' },
    { '<P', '<Plug>(YankyPutIndentBeforeShiftLeft)', desc = 'Put before and indent left' },

    -- Put and move cursor to end
    { '=p', '<Plug>(YankyPutAfterFilter)', desc = 'Put after applying a filter' },
    { '=P', '<Plug>(YankyPutBeforeFilter)', desc = 'Put before applying a filter' },

    -- Yank history picker using vim.ui.select
    {
      '<leader>cy',
      function()
        local history = require('yanky.history')
        local utils = require('yanky.utils')
        local items = history.all()
        if #items == 0 then
          vim.notify('No yanks in history', vim.log.levels.INFO)
          return
        end

        local formatted_items = {}
        for i, item in ipairs(items) do
          local text = item.regcontents
          if type(text) == 'table' then
            text = table.concat(text, '\n')
          end
          -- Truncate long entries and remove newlines for display
          local display = text:gsub('\n', '\\n'):sub(1, 80)
          if #text > 80 then
            display = display .. '...'
          end
          table.insert(formatted_items, { text = text, display = string.format('%d: %s', i, display) })
        end

        vim.ui.select(formatted_items, {
          prompt = 'Yank History:',
          format_item = function(item)
            return item.display
          end,
        }, function(choice)
          if choice then
            vim.api.nvim_put({ choice.text }, 'c', true, true)
          end
        end)
      end,
      desc = 'Find Yank History',
    },

    -- Clear yank history
    {
      '<leader>yc',
      function()
        require('yanky').clear_history()
      end,
      desc = 'Clear Yank History',
    },
  },
}
