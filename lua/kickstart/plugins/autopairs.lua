-- autopairs
-- https://github.com/windwp/nvim-autopairs

return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  -- Optional dependency
  -- dependencies = { 'hrsh7th/nvim-cmp' },
  opts = {
    -- This is the crucial option to enable Treesitter-based pairing
    check_ts = true,
    -- Configure Treesitter pairing for specific filetypes
    ts_config = {
      lua = { 'string' },
      javascript = { 'template_string' },
      java = false, -- Disable for java
    },
  },
  -- The `config` function runs *after* the setup with `opts` is done.
  -- Use it for extra configuration steps, like integrating with other plugins.
  config = function(_, opts)
    -- The require('nvim-autopairs').setup(opts) is handled automatically by lazy.nvim.
    -- We just need to add the cmp integration logic.
    local autopairs = require 'nvim-autopairs'
    local cmp_autopairs = require 'nvim-autopairs.completion.cmp'
    local cmp = require 'cmp'
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
