-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Cycle through quickfix list items
vim.keymap.set('n', ']e', '<Cmd>try | cnext | catch | cfirst | catch | endtry<CR>')
vim.keymap.set('n', '[e', '<Cmd>try | cprevious | catch | clast | catch | endtry<CR>')

-- Simple keymaps
vim.keymap.set('n', '<leader>t', ':tabnew<CR>')
vim.keymap.set('n', '<M-[>', ':tabprev<CR>')
vim.keymap.set('n', '<M-]>', ':tabnext<CR>')
vim.keymap.set('n', '<leader><down>', ':sp<CR>')
vim.keymap.set('n', '<leader><right>', ':vsp<CR>')
vim.keymap.set('n', '<M-t>', ':term<CR>')
vim.keymap.set('t', '<esc>', '<C-\\><C-N>')
vim.keymap.set('n', '<leader>4', ':bufdo bd<CR>')
vim.keymap.set('n', '<leader>3', ':bd<CR>')
vim.keymap.set('n', ']p', ':bnext<CR>')
vim.keymap.set('n', '[p', ':bprev<CR>')

vim.keymap.set('n', ']w', ':vertical resize +3<CR>')
vim.keymap.set('n', '[w', ':vertical resize -3<CR>')

vim.keymap.set('n', ']W', ':vertical resize +7<CR>')
vim.keymap.set('n', '[W', ':vertical resize -7<CR>')

vim.keymap.set('n', ']h', ':resize +3<CR>')
vim.keymap.set('n', '[h', ':resize -3<CR>')

vim.keymap.set('n', ']H', ':resize +7<CR>')
vim.keymap.set('n', '[H', ':resize -7<CR>')

-- Native LSP
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { desc = '[R]e[n]ame' })
vim.keymap.set('n', ']g', vim.diagnostic.goto_next, { desc = '[G]oto Next Diagnostic' })
vim.keymap.set('n', '[g', vim.diagnostic.goto_prev, { desc = '[G]oto Previous Diagnostic' })
vim.keymap.set('n', '<leader>ga', vim.lsp.buf.code_action, { desc = '[G]oto Code [A]ction' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]oto [D]eclaration' })

-- fzf.lua
-- Buffer and files
vim.keymap.set('n', '<leader>sb', ':FzfLua buffers<CR>', { desc = '[S]earch [B]uffers' })
vim.keymap.set('n', '<leader>qf', ':FzfLua quickfix<CR>', { desc = '[Q]uick [F]ix List' })
vim.keymap.set('n', '<leader>bs', ':FzfLua treesitter<CR>', { desc = '[B]uffer [S]ymbols' })
vim.keymap.set('n', '<leader>of', ':FzfLua oldfiles<CR>', { desc = '[O]pened [F]iles History' })
vim.keymap.set('n', '<leader>.', ':FzfLua files<CR>', { desc = 'Search Files (cwd)' })
vim.keymap.set('n', '<leader>>', ':FzfLua files cwd=/<CR>', { desc = 'Search Files' })

-- Search
vim.keymap.set('n', '<leader>/', ':FzfLua live_grep_native<CR>', { desc = 'Live Grep (fuzzy)' })
vim.keymap.set('n', '<leader>?', function()
  vim.ui.input({
    prompt = 'Enter a directory: ',
    completion = 'dir',
  }, function(input)
    if input then
      local dir = vim.fs.normalize(input)
      local stat = vim.uv.fs_stat(dir)
      if stat and stat.type == 'directory' then
        require('fzf-lua').live_grep_native { cwd = dir }
      else
        print 'Invalid directory.'
      end
    end
  end)
end, { desc = 'Dynamic Live Grep (fuzzy)' })

-- Git
vim.keymap.set('n', '<leader>xs', ':FzfLua git_status<CR>', { desc = '[G]it [S]tatus' })
vim.keymap.set('n', '<leader>xf', ':FzfLua git_files<CR>', { desc = '[G]it [F]iles' })
vim.keymap.set('n', '<leader>xd', ':FzfLua git_diff<CR>', { desc = '[G]it [D]iff' })
vim.keymap.set('n', '<leader>xc', ':FzfLua git_commits<CR>', { desc = '[G]it [C]ommits' })
vim.keymap.set('n', '<leader>xbc', ':FzfLua git_bcommits<CR>', { desc = '[G]it [B]uffer [C]ommits' })
vim.keymap.set('n', '<leader>xb', ':FzfLua git_branches<CR>', { desc = '[G]it [B]ranches' })
vim.keymap.set('n', '<leader>xt', ':FzfLua git_tags<CR>', { desc = '[G]it [T]ags' })
vim.keymap.set('n', '<leader>xS', ':FzfLua git_stash<CR>', { desc = '[G]it [S]tash' })

-- LSP/Diagnostics
vim.keymap.set('n', '<leader>sE', ':FzfLua diagnostics_document<CR>', { desc = '[S]earch Document [E]rrors' })
vim.keymap.set('n', '<leader>se', ':FzfLua diagnostics_workspace<CR>', { desc = '[S]earch Workspace [E]rrors' })
vim.keymap.set('n', 'gr', ':FzfLua lsp_references<CR>', { desc = '[G]o to [R]eferences' })
vim.keymap.set('n', 'gd', ':FzfLua lsp_definitions<CR>', { desc = '[G]o to [D]efinitions' })
vim.keymap.set('n', 'gD', ':FzfLua lsp_declarations<CR>', { desc = '[G]o to [D]eclarations' })
vim.keymap.set('n', 'gi', ':FzfLua lsp_implementations<CR>', { desc = '[G]o to [I]mplementations' })
vim.keymap.set('n', '<leader>ds', ':FzfLua lsp_document_symbols<CR>', { desc = '[D]ocument [S]ymbols' })
vim.keymap.set('n', '<leader>wS', ':FzfLua lsp_workspace_symbols<CR>', { desc = '[W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>ws', ':FzfLua lsp_live_workspace_symbols<CR>', { desc = 'Live [W]orkspace [S]ymbols' })
vim.keymap.set('n', '<leader>ic', ':FzfLua lsp_incoming_calls<CR>', { desc = 'LSP [I]ncoming [C]alls' })
vim.keymap.set('n', '<leader>oc', ':FzfLua lsp_outgoing_calls<CR>', { desc = 'LSP [O]utgoing [C]alls' })
vim.keymap.set(
  { 'n', 'v' },
  'ga',
  ':lua vim.lsp.buf.code_action({ context = { only = { "source", "refactor", "quickfix" } } })<CR>',
  { desc = 'LSP [G]o to Code [A]ctions' }
)
vim.keymap.set('n', '<leader>lf', ':FzfLua lsp_finder<CR>', { desc = '[L]SP [F]inder' })

-- Misc
vim.keymap.set('n', '<leader>fb', ':FzfLua builtin<CR>', { desc = '[F]zf-lua [B]uiltins' })
vim.keymap.set('n', '<leader>sd', ':FzfLua helptags<CR>', { desc = '[S]earch [D]ocs' })
vim.keymap.set('n', '<leader>sM', ':FzfLua manpages<CR>', { desc = '[M]an [P]ages' })
vim.keymap.set('n', '<leader>cs', ':FzfLua colorschemes<CR>', { desc = '[C]olor [S]chemes' })
vim.keymap.set('n', '<leader>cS', ':FzfLua awesome_colorschmes<CR>', { desc = '[A]wesome [C]olor [S]chemes' })
vim.keymap.set('n', '<leader>nc', ':FzfLua commands<CR>', { desc = '[N]vim [C]ommands' })
vim.keymap.set('n', '<leader>sm', ':FzfLua marks<CR>', { desc = '[S]earch [M]arks' })
vim.keymap.set('n', '<leader>sr', ':FzfLua registers<CR>', { desc = '[S]earch [R]egisters' })
vim.keymap.set('n', '<leader>no', ':FzfLua nvim_options<CR>', { desc = '[N]vim [O]ptions' })
vim.keymap.set('n', '<leader>sk', ':FzfLua keymaps<CR>', { desc = '[S]earch [K]eymaps' })

-- luasnip
local ls = require 'luasnip'

vim.keymap.set({ 'i', 's' }, '<C-L>', function()
  ls.jump(1)
end, { silent = true })
vim.keymap.set({ 'i', 's' }, '<C-J>', function()
  ls.jump(-1)
end, { silent = true })

vim.keymap.set({ 'i', 's' }, '<C-E>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

-- codecompanion
vim.keymap.set({ 'n', 'v' }, '<LocalLeader>cc', '<cmd>CodeCompanionActions<cr>', { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<LocalLeader>ct', '<cmd>CodeCompanionChat Toggle<cr>', { noremap = true, silent = true })
vim.keymap.set('v', 'cca', '<cmd>CodeCompanionChat Add<cr>', { noremap = true, silent = true })
vim.keymap.set('v', '<leader>dt', function()
  require('codecompanion').prompt 'recette'
end, { desc = '[D]escribe [T]ests' })
vim.cmd [[cab cc CodeCompanion]]

-- nvim-surround
vim.keymap.set('v', 'S', '<Plug>(nvim-surround-visual)')
