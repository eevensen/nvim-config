return {
  "folke/snacks.nvim",
  opts = {
    explorer = {
      enabled = false, -- Disable snacks explorer
    },
  },
  keys = {
    -- Disable the default <leader>e keymap
    { "<leader>e", false },
    { "<leader>E", false },
  },
}