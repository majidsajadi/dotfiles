-- Load editor options before plugins.
require("config.options")

-- Install lazy.nvim when it is not already available.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end

-- Make lazy.nvim available to Neovim.
vim.opt.rtp:prepend(lazypath)

-- Load plugins from lua/plugins.
require("lazy").setup("plugins", {
  ui = {
    -- Display the plugin manager with a rounded border.
    border = "rounded",
  },
})