return {
  "mikavilpas/yazi.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  event = "VeryLazy",
  keys = {
    {
      "<leader>fy",
      function()
        require("yazi").yazi()
      end,
      desc = "Open yazi at current file",
    },
    {
      "<leader>fY",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open yazi in cwd",
    },
    {
      "<leader>e",
      function()
        require("yazi").yazi()
      end,
      desc = "Open yazi at current file",
    },
    {
      "<leader>E",
      function()
        require("yazi").yazi(nil, vim.fn.getcwd())
      end,
      desc = "Open yazi in cwd",
    },
  },
  opts = {
    open_for_directories = false,
    floating_window_scaling_factor = 0.9,
    yazi_floating_window_winblend = 0,
    keymaps = {
      show_help = "<f1>",
    },
  },
}
