return {
  'folke/zen-mode.nvim',
  opts = {},
  keys = {
    {
      '<leader>z',
      function()
        require('zen-mode').toggle {
          window = {
            width = 0.54,
          },
        }
      end,
    },
  },
}
