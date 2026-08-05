return {
  {
    -- Insert matching brackets and quotes.
    "windwp/nvim-autopairs",
    -- Load automatic pairing when entering Insert mode.
    event = "InsertEnter",
    dependencies = {
      -- Insert matching pairs after accepting a completion.
      "hrsh7th/nvim-cmp",
    },
    config = function()
      -- Use Tree-sitter to improve pairing decisions.
      require("nvim-autopairs").setup({
        check_ts = true,
      })

      local cmp = require("cmp")
      local autopairs = require("nvim-autopairs.completion.cmp")

      -- Insert matching pairs when accepting a completion.
      cmp.event:on("confirm_done", autopairs.on_confirm_done())
    end,
  },
}
