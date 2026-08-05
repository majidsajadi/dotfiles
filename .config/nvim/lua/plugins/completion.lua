return {
  {
    -- Complete symbols and filesystem paths while typing.
    "hrsh7th/nvim-cmp",
    -- Load completion when entering Insert mode.
    event = "InsertEnter",
    dependencies = {
      -- Expand snippet-formatted language server completions.
      "L3MON4D3/LuaSnip",
      -- Provide language server completions.
      "hrsh7th/cmp-nvim-lsp",
      -- Provide filesystem path completions.
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        -- Expand snippet-formatted completion items.
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- Configure completion key bindings.
        mapping = cmp.mapping.preset.insert({
          -- Select the next completion item.
          ["<C-j>"] = cmp.mapping.select_next_item(),
          -- Select the previous completion item.
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          -- Accept only an explicitly selected completion.
          ["<CR>"] = cmp.mapping.confirm({
            select = false,
          }),
        }),

        -- Hide the completion scrollbar.
        window = {
          completion = {
            scrollbar = false,
          },
        },

        -- Complete from language servers and filesystem paths.
        sources = {
          { name = "nvim_lsp" },
          { name = "path" },
        },
      })
    end,
  },
}
