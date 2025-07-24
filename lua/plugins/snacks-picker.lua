return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      matcher = {
        frecency = true,
      },
      formatters = {
        file = {
          filename_first = false, -- Display filename before the file path
          icons = true,
          truncate = 100, -- Show longer paths
        },
      },
      sources = {
        files = {
          hidden = true, -- Show hidden files (.dotfiles)
          ignored = true, -- Show files ignored by git (.gitignore)
          matcher = {
            frecency = true, -- Use frecency scoring
            sort_empty = true, -- Sort by frecency even when empty
          },
        },
      },
    },
  },
  keys = {
    {
      "<leader>,",
      function()
        Snacks.picker.buffers({
          -- I always want my buffers picker to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = "buffers",
          format = "buffer",
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ["d"] = "bufdelete",
              },
            },
            list = { keys = { ["d"] = "bufdelete" } },
          },
        })
      end,
      desc = "[P]Snacks picker buffers",
    },
    {
      "<leader>fr",
      function()
        Snacks.picker.recent({
          -- I always want recent files to start in normal mode
          on_show = function()
            vim.cmd.stopinsert()
          end,
        })
      end,
    },
  },
}
