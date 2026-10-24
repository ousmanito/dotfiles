return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'MunifTanjim/nui.nvim',
  },
  lazy = false,
  ---@module "neo-tree"
  ---@type neotree.Config?
  opts = {
    filesystem = {
      filtered_items = {
        hide_dotfiles = false,
        follow_current_file = {
          enabled = true,
        },
        always_show_by_pattern = {
          '.env',
          '.env.*',
          '*.env',
        },
      },
    },
  },
  keys = {
    { '<leader>1', ':Neotree toggle<CR>', desc = '[T]oggle [F]ile Explorer ' },
    { '<leader>2', ':Neotree focus<CR>', desc = '[T]oggle [F]ile Explorer ' },
  },
}
