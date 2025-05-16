return {
  { -- Autoformat
    'stevearc/conform.nvim',
    event = { 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_format = 'fallback' }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local format_enabled_by_ft = { c = true, cpp = true, php = true, blade = true, javascript = true, typescript = true }
        local lsp_format_opt = 'never'
        if format_enabled_by_ft[vim.bo[bufnr].filetype] then
          lsp_format_opt = 'fallback'
        end
        return {
          timeout_ms = 500,
          lsp_format = lsp_format_opt,
        }
      end,
      formatters_by_ft = {
        lua = { 'stylua' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use 'stop_after_first' to run the first available formatter from the list
        javascript = { 'prettierd', 'prettier', stop_after_first = true },
        typescript = { 'prettierd', 'prettier', stop_after_first = true },
        php = { 'pint' },
        -- php = { 'php_cs_fixer' },
        blade = { 'blade-formatter' },
      },
      formatters = {
        pint = {
          condition = function(ctx)
            return vim.fs.find({ 'pint.json' }, { upward = true, path = ctx.filename, type = 'file' })[1]
              or vim.fs.find({ 'vendor/bin/pint' }, { upward = true, path = ctx.filename, type = 'file' })[1]
          end,
        },
        php_cs_fixer = {
          condition = function(ctx)
            return vim.fs.find({ '.php-cs-fixer.dist.php', '.php-cs-fixer.php' }, { upward = true, path = ctx.filename, type = 'file' })[1]
          end,
          -- args = { "--config=.php-cs-fixer.dist.php" } -- si vous devez spécifier le fichier de config
        },
        ['blade-formatter'] = {
          -- S'assurer qu'il est trouvable, sinon spécifier cmd
        },
      },
    },
  },
}
