return {
  -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>F',
      function()
        require('conform').format { async = true, timeout_ms = 500, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[F]ormat buffer',
    },
  },
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = {
        'ruff_fix',
        'ruff_format',
        'ruff_organize_imports',
      },
      javascript = { 'prettier', stop_after_first = true },
      typescript = { 'prettier', stop_after_first = true },
      typescriptreact = { 'prettier', stop_after_first = true },
      javascriptreact = { 'prettier', stop_after_first = true },
      json = { 'prettier', stop_after_first = true },
      html = { 'prettier', stop_after_first = true },
      css = { 'prettier', stop_after_first = true },
      scss = { 'prettier', stop_after_first = true },
    },
  },
}
