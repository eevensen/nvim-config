return {
  "nvim-treesitter/nvim-treesitter",
  init = function()
    -- Ensure .twig files are recognized
    vim.filetype.add({
      extension = {
        twig = "twig",
      },
    })
  end,
}