-- Enhances the built-in LSP formatting capabilities by
-- providing better diff handling and
-- enabling range formatting for all formatters.
return {
  'stevearc/conform.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local conform = require('conform')

    conform.setup({
      formatters_by_ft = {
        javascript = { { 'prettierd', 'prettier' } },
        typescript = { { 'prettierd', 'prettier' } },
        javascriptreact = { { 'prettierd', 'prettier' } },
        typescriptreact = { { 'prettierd', 'prettier' } },
        markdown = { { 'prettierd', 'prettier' } },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        lua = { 'stylua' },
        python = { 'isort', 'black' },
        php = { 'phpcs', 'phpcbf' },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    -- Format current file
    vim.keymap.set({ 'n', 'v' }, '<leader>fm', function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = '[F]or[m]at Current Buffer' })
  end,
}
