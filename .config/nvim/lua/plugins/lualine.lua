return {
  {
    -- Show editor state, file information, diagnostics, and LSP progress.
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          -- Display plain text without icons or separators.
          icons_enabled = false,
          section_separators = "",
          component_separators = "",

          -- Share one status line across all windows.
          globalstatus = true,
        },

        sections = {
          lualine_a = {
            {
              "mode",
              -- Use the theme's subdued text style.
              color = "Comment",
            },
          },

          lualine_b = {
            {
              "branch",
              -- Use the theme's subdued text style.
              color = "Comment",
            },
          },

          lualine_c = {
            {
              "filename",
              -- Display an absolute path with the home directory shortened.
              path = 3,
              -- Use the theme's subdued text style.
              color = "Comment",
            },
          },

          lualine_x = {
            {
              -- Show language server errors and warnings.
              "diagnostics",
              sections = {
                "error",
                "warn",
              },
              colored = false,
              -- Use the theme's subdued text style.
              color = "Comment",
            },
            {
              -- Show active language servers and background progress.
              "lsp_status",
              icon = "",
              -- Use the theme's subdued text style.
              color = "Comment",
            },
          },

          lualine_y = {},
          lualine_z = {},
        },
      })
    end,
  },
}