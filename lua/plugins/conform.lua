return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      python = {
        'ruff_fix',
        'ruff_format',
        'ruff_organize_imports',
      },
      javascript = { 'prettierd', stop_after_first = true },
      typescript = { 'prettierd', stop_after_first = true },
      typescriptreact = { 'prettierd', stop_after_first = true },
      javascriptreact = { 'prettierd', stop_after_first = true },
      json = { 'prettierd', stop_after_first = true },
      html = { 'prettierd', stop_after_first = true },
      css = { 'prettierd', stop_after_first = true },
      scss = { 'prettierd', stop_after_first = true },
    },
  },
}
