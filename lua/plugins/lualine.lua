return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      -- Override the filename component in lualine_c
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = {
        {
          "filename",
          path = 1, -- Show relative path
          shorting_target = 40, -- Shortens path to leave 40 spaces in the window
        },
      }
      return opts
    end,
  },
}