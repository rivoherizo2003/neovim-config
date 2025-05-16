return {
  {
    'adalessa/laravel.nvim',
    dependencies = {
      'nvim-telescope/telescope.nvim',
      'tpope/vim-dotenv', -- Utile pour charger les variables .env pour Artisan
      'kevinhwang91/promise-async',
    },
    -- cmd = { "Artisan", "Routes", "Make", "Model", "Migration", "Test", "Dusk" },
    -- OU utilisez 'event' pour un chargement moins agressif si vous préférez :
    event = 'VeryLazy', -- ou "BufReadPre", "BufNewFile" pour les fichiers PHP/Laravel
    opts = {
      -- C'est ici que vous devez définir les options.
      -- NE PAS faire de `require("laravel.options.xxx")` ici.
      -- Référez-vous à la section 'Options' de la documentation sur GitHub (pas celle que vous avez liée pour le setup initial)
      -- ou aux valeurs par défaut du plugin si vous ne voulez rien changer.

      -- Exemple d'options que vous pourriez vouloir configurer (vérifiez les noms exacts dans la doc officielle sur GitHub):
      -- Par exemple, pour les options de Telescope (si elles sont structurées comme ça)
      telescope = {
        enable = true, -- Assurez-vous que l'intégration Telescope est activée si vous le souhaitez
        navigation = {
          -- options de navigation
        },
        -- etc.
      },

      -- Pour les "command_options" et "ui", si ces clés sont directement utilisables dans `opts`,
      -- vous définiriez des tables simples ici.
      -- Exemple FICTIF (basé sur ce que vous essayiez de faire, mais la structure réelle peut différer):
      -- ui_options = { -- Nom de clé hypothétique
      --   border = "rounded",
      --   icons = true,
      -- },
      -- command_config = { -- Nom de clé hypothétique
      --   artisan_default_flags = { "--no-interaction" }
      -- }

      -- **Important** : Si vous ne savez pas quelles options mettre ici,
      -- commencez avec une table `opts` vide ou omettez-la complètement
      -- pour utiliser les valeurs par défaut du plugin.
      -- opts = {}, -- Pour utiliser toutes les valeurs par défaut
    },
    config = function(_, opts)
      -- La variable `opts` ici contiendra la table que vous avez définie ci-dessus.
      -- La fonction setup du plugin est appelée avec ces options.
      require('laravel').setup(opts)

      -- Charger l'extension Telescope
      -- Il est bon de le mettre dans un pcall au cas où Telescope ne serait pas encore chargé
      -- ou si l'extension change de nom ou est retirée.
      local status_ok, _ = pcall(require, 'telescope')
      if status_ok then
        pcall(require('telescope').load_extension, 'laravel')
      end

      -- Définissez vos keymaps ici si nécessaire, comme dans la doc que vous avez liée
      -- ou dans la documentation GitHub.
      local keymap = vim.keymap.set
      local map_opts = { noremap = true, silent = true }

      keymap('n', '<leader>la', '<cmd>Artisan<CR>', map_opts)
      keymap('n', '<leader>lr', '<cmd>Routes<CR>', map_opts)
      keymap('n', '<leader>lt', '<cmd>Test<CR>', map_opts)
      keymap('n', '<leader>lm', '<cmd>Make<CR>', map_opts)
      keymap('n', '<leader>ld', '<cmd>Dusk<CR>', map_opts)
      keymap('n', '<leader>li', '<cmd>Sail<CR>', map_opts)

      -- Keymaps pour Telescope (s'assurer que l'extension est chargée)
      keymap('n', '<leader>lra', '<cmd>Telescope laravel artisan<CR>', map_opts)
      keymap('n', '<leader>lrr', '<cmd>Telescope laravel routes<CR>', map_opts)
      keymap('n', '<leader>lre', '<cmd>Telescope laravel events<CR>', map_opts)
      keymap('n', '<leader>lrv', '<cmd>Telescope laravel views<CR>', map_opts)
      keymap('n', '<leader>lrc', '<cmd>Telescope laravel config<CR>', map_opts)
      keymap('n', '<leader>lrg', '<cmd>Telescope laravel commands<CR>', map_opts)
      keymap('n', '<leader>lrq', '<cmd>Telescope laravel queues<CR>', map_opts)
    end,
  },
}
