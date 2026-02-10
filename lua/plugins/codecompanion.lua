return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      acp = {
        codex = function()
          return require('codecompanion.adapters').extend('codex', {
            defaults = {
              auth_method = 'chatgpt',
            },
          })
        end,
      },
      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          schema = {
            model = {
              default = 'gpt-5',
            },
          },
        })
      end,
    },
    interactions = {
      chat = {
        adapter = 'codex',
        variables = {
          ['buffer'] = {
            opts = {
              default_params = 'diff',
            },
          },
        },
      },
      inline = {
        adapter = 'openai',
      },
      cmd = {
        adapter = 'openai',
      },
    },
    rules = {
      dev_rules = {
        description = 'Default rules for dev project',
        files = {
          {
            path = '~/dev/.rules',
            files = '*.md',
          },
        },
      },
      opts = {
        chat = {
          autoload = { 'default', 'dev_rules' },
        },
      },
    },
    prompt_library = {
      markdown = {
        dirs = {
          '~/dev/.prompts',
        },
      },
    },
    display = {
      action_palette = {
        provider = 'fzf_lua',
        opts = {
          title = 'Actions',
          show_prompt_library_builtins = false,
        },
      },
      chat = {
        intro_message = '✨',
        separator = '─',
        show_header_separator = true,
        show_settings = false,
        show_token_count = true,
        show_tools_processing = true,
        start_in_insert_mode = true,
        fold_reasoning = false,
        show_reasoning = true,
        auto_scroll = false,
      },
    },
    opts = {
      log_level = 'DEBUG',
    },
  },
}
