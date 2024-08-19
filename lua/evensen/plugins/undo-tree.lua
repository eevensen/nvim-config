-- Visual representation of the undo history,
-- allowing users to navigate and
-- manipulate undo branches.
return {
  'mbbill/undotree',
  vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = '[U]ndo tree (toggle)' }),
}
