return {
  {
    -- Apply the Black Metal color scheme.
    "metalelf0/black-metal-theme-neovim",
    -- Load the color scheme during startup.
    lazy = false,
    -- Load the color scheme before other interface plugins.
    priority = 1000,
    config = function()
      require("black-metal").setup({
        theme = "windir",
        variant = "dark",

        -- Keep floating windows flat inside their borders.
        plain_float = true,

        -- Hide end-of-buffer markers.
        show_eob = false,

        code_style = {
          -- Display comments without italic styling.
          comments = "none",
        },

        plugin = {
          lualine = {
            -- Keep the status line flat and unbolded.
            bold = false,
            plain = true,
          },

          cmp = {
            -- Keep completion entries visually neutral.
            plain = true,
            reverse = false,
          },
        },

        highlights = {
          -- Blend the file tree separator into the background.
          NeoTreeWinSeparator = {
            fg = "$bg",
            bg = "$bg",
          },
        },
      })

      require("black-metal").load()
    end,
  },
}
