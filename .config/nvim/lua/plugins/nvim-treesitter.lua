return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "rust",
          "go",
          "typescript",
          "javascript",
          "html",
        },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
}
