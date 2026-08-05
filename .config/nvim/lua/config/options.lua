-- Set the leader keys before loading plugins.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Disable the built-in file explorer.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- Display absolute and relative line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Right-align absolute and relative line numbers.
vim.opt.statuscolumn = "%=%{v:relnum?v:relnum:v:lnum} "

-- Highlight the line containing the cursor.
vim.opt.cursorline = true

-- Keep context visible above and below the cursor.
vim.opt.scrolloff = 5

-- Display floating windows with rounded borders.
vim.opt.winborder = "rounded"

-- Hide the sign column.
vim.opt.signcolumn = "no"

-- Hide end-of-buffer markers.
vim.opt.fillchars = { eob = " " }

-- Preserve undo history across sessions.
vim.opt.undofile = true

-- Keep mouse interactions outside Neovim.
vim.opt.mouse = ""

-- Indent with tabs displayed as two columns.
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2

-- Apply basic indentation rules automatically.
vim.opt.smartindent = true

-- Disable line wrapping by default.
vim.opt.wrap = false

-- Share text with the system clipboard.
vim.opt.clipboard = "unnamedplus"

-- Reduce the delay for idle editor events.
vim.opt.updatetime = 250

-- Reduce the delay for mapped key sequences.
vim.opt.timeoutlen = 300

-- Preview substitutions in a separate split.
vim.opt.inccommand = "split"

-- Hide partially typed commands.
vim.opt.showcmd = false

-- Create folds from the syntax tree.
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Use Neovim's modern fold text.
vim.opt.foldtext = ""

-- Open all folds when entering a buffer.
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

-- Enable prose-friendly editing for Markdown files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- Wrap long lines at word boundaries.
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    -- Move by displayed lines instead of physical lines.
    vim.keymap.set("n", "j", "gj", { buffer = true })
    vim.keymap.set("n", "k", "gk", { buffer = true })
  end,
})