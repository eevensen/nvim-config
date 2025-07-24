return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    -- Add prettier as formatter for twig files using HTML parser
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.twig = { "prettier" }
    
    return opts
  end,
  dependencies = {
    -- Ensure twig files are recognized
    {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        vim.list_extend(opts.ensure_installed, { "twig" })
        return opts
      end,
    },
  },
}