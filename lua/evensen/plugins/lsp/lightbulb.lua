return {
  {
    'kosayoda/nvim-lightbulb',
    event = 'LspAttach',
    dependencies = {
      'neovim/nvim-lspconfig',
    },
    config = function()
      require('nvim-lightbulb').setup({
        autocmd = { enabled = true },
      })
    end,
  },
}
