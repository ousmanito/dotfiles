return {
  'olimorris/codecompanion.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    adapters = {
      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          schema = {
            model = {
              default = 'o4-mini',
            },
          },
        })
      end,
    },
    strategies = {
      chat = {
        adapter = 'openai',
        slash_commands = {
          buffer = {
            opts = {
              provider = 'fzf_lua', -- default|telescope|mini_pick|fzf_lua
            },
          },
        },
      },
      inline = {
        adapter = 'openai',
      },
    },

    prompt_library = {
      ['Describe Test Cases'] = {
        strategy = 'chat',
        description = 'Documente les tests unitaires afin de compléter le cahier de recettes.',
        opts = {
          modes = { 'v' },
          short_name = 'recette',
          user_prompt = false,
          auto_submit = true,
          stop_context_insertion = true,
        },
        prompts = {
          {
            role = 'system',
            content = function(context)
              return 'Je veux que tu agisses en tant que développeur senior en '
                .. context.filetype
                .. ". Génèrant un document Markdown de cas de test (en français) structuré pour les tests d'une application logicielle.\n"
                .. " J'aimerais que tu fasses un saut de ligne avant le contenu de chaque section pour que ce soit plus simple de copier le contenu via vim (Y), pour cette raison je ne veux aucune identation."
                .. 'Le texte généré doit inclure les sections suivantes :\n\n'
                .. '1. Cas de test : La catégorie ou le contexte général du test (par ex. "Authentification utilisateur", "Configuration de l\'API").\n'
                .. '2. Nom du test : Un nom descriptif et unique pour chaque test individuel (par ex. `test_connexion_utilisateur_reussie`).\n'
                .. '3. Description du scénario : Une brève explication de ce qui est testé et pourquoi.\n'
                .. "4. Prérequis : Les conditions ou la configuration nécessaires avant d'exécuter le test (par ex. dépendances installées, services en cours d'exécution).\n"
                .. '5. Résultat attendu : Le résultat attendu qui confirme que le test a réussi.\n'
                .. '6. Commentaire : Notes supplémentaires facultatives, comme des liens vers la documentation ou des conseils de débogage.\n\n'
            end,
            opts = {
              visible = true,
            },
          },
          {
            role = 'user',
            content = function(context)
              local text = require('codecompanion.helpers.actions').get_code(context.start_line, context.end_line)
              return "Voici le fichier avec mes tests unitaires que j'aimerais documenter selon l'invite système."
                .. '\n'
                .. context.filetype
                .. '\n'
                .. text
                .. '\n```\n\n'
            end,
            opts = {
              contains_code = true,
            },
          },
        },
      },
    },

    display = {
      action_palette = {
        provider = 'fzf_lua', -- default|telescope|mini_pick
      },
      chat = {
        intro_message = '✨',
        show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
        separator = '─', -- The separator between the different messages in the chat buffer
        show_references = true, -- Show references (from slash commands and variables) in the chat buffer?
        show_settings = true, -- Show LLM settings at the top of the chat buffer?
        show_token_count = true, -- Show the token count for each response?
        start_in_insert_mode = false, -- Open the chat buffer in insert mode?
      },
    },
    opts = {
      log_level = 'DEBUG',
    },
  },
}
