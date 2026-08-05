return {
  {
    -- Show available key bindings.
    "folke/which-key.nvim",
    -- Load WhichKey after startup when Neovim becomes idle.
    event = "VeryLazy",
    opts = {
      -- Match the Helix-style popup layout.
      preset = "helix",

      win = {
        -- Hide the popup title.
        title = false,
      },

      icons = {
        -- Display plain text without mapping icons.
        mappings = false,
      },

      -- Hide the help shown in the footer.
      show_help = false,

      -- Hide the currently pressed keys shown in the footer.
      show_keys = false,
    },
  },
}