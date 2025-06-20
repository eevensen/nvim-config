-- Highlight, edit, and navigate code
-- Enhanced parsing and analysis of code using tree-sitter,
-- enabling features like better syntax highlighting
-- and advanced code manipulation.
return {
  'nvim-treesitter/nvim-treesitter',
  event = { 'BufReadPre', 'BufNewFile' },
  build = ':TSUpdate',
  main = 'nvim-treesitter.configs',
  dependencies = {
    'windwp/nvim-ts-autotag',
  },
  opts = {
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    -- List of parsers to ignore installing (or "all")
    ignore_install = {},

    highlight = {
      enable = true,
      disable = { 'csv' },
      -- additional_vim_regex_highlighting = true,
    },

    -- enable indentation
    indent = { enable = true },
    -- enable autotagging (w/ nvim-ts-autotag plugin)
    autotag = {
      enable = true,
    },

    -- ensure these language parsers are installed
    ensure_installed = {
      'json',
      'javascript',
      'typescript',
      'tsx',
      'yaml',
      'html',
      'css',
      'markdown',
      'markdown_inline',
      -- 'graphql',
      'lua',
      'vim',
      'dockerfile',
      'gitignore',
      'query',
      'vimdoc',
      'c',
      'php',
      'dart',
      'python',
      'json',
      'bash',
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>',
        node_incremental = '<C-space>',
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },
  },
}
