return {
  {
    -- Provide syntax parsing, highlighting, and indentation.
    "nvim-treesitter/nvim-treesitter",
    -- Update language parsers when the plugin is updated.
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Install parsers for supported languages.
        ensure_installed = {
          "go",
          "rust",
          "lua",
          "proto",
          "markdown",
          "markdown_inline",
        },

        -- Install missing parsers automatically.
        auto_install = true,

        -- Enable syntax highlighting.
        highlight = {
          enable = true,
        },

        -- Enable syntax-aware indentation.
        indent = {
          enable = true,
        },
      })
    end,
  },
}
