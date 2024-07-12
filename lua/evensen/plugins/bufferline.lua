-- enhances buffer management by displaying buffers
-- as a visually appealing and customizable tabline.
return {
  'akinsho/bufferline.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  version = '*',
  opts = {
    options = {
      mode = 'tabs',
    },
  },
}
