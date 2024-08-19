-- Highlights, lists, and helps you search
-- for TODOs, FIXMEs, and other similar
-- comments within your code.
-- Finds and lists all of the TODO, HACK, BUG, etc comment
-- in your project and loads them into a browsable list.
return {
  'folke/todo-comments.nvim',
  cmd = { 'TodoTrouble', 'TodoTelescope' },
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {},
    -- stylua: ignore
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },

      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {TODO,FIX,FIXME}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },

      { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Todo" },
      { "<leader>fT", "<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>", desc = "Todo/Fix/Fixme" },
    },
}
