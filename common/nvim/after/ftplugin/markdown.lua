-- ~/.config/nvim/after/ftplugin/markdown.lua
vim.opt_local.wrap = true
vim.opt_local.linebreak = true
vim.opt_local.breakindent = true
vim.opt_local.showbreak = "  "
vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"

-- belt & suspenders: disable markdown conceal globally + enforce locally
vim.g.markdown_syntax_conceal = 0 -- stops runtime markdown conceal
vim.opt_local.conceallevel = 0
vim.opt_local.concealcursor = ""

-- if another plugin still flips it after this file, override again at the end of the event loop
vim.defer_fn(function()
  vim.opt_local.conceallevel = 0
  vim.opt_local.concealcursor = ""
end, 0)

-- Quieter diagnostics for prose
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = false,
})
