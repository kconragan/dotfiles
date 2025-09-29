local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    { import = "lazyvim.plugins.extras.lang.astro" },
    -- import/override with your plugins
    { import = "plugins" },
    {
      "NickvanDyke/opencode.nvim",
      dependencies = {
        -- Recommended for better prompt input, and required to use `opencode.nvim`'s embedded terminal — otherwise optional
        { "folke/snacks.nvim", opts = { input = { enabled = true } } },
      },
      keys = {
        { "<leader>ot", function() require("opencode").toggle() end, { desc = "Toggle opencode" } },
        { "<leader>oA", function() require("opencode").ask() end, { desc = "Ask opencode" } },
        { "<leader>oa", function() require("opencode").ask("@cursor: ") end, { desc = "Ask opencode about this" } },
        { "<leader>oa", function() require("opencode").ask("@selection: ") end, mode = "v", desc = "Ask opencode about selection" },
        { "<leader>on", function() require("opencode").command("session_new") end, { desc = "New opencode session" } },
        { "<leader>oy", function() require("opencode").command("messages_copy") end, { desc = "Copy last opencode response" } },
        { "<S-C-u>", function() require("opencode").command("messages_half_page_up") end, { desc = "Messages half page up" } },
        { "<S-C-d>", function() require("opencode").command("messages_half_page_down") end, { desc = "Messages half page down" } },
        { "<leader>os", function() require("opencode").select() end, { desc = "Select opencode prompt", mode = { "n", "v" } } },
        { "<leader>oe", function() require("opencode").prompt("Explain @cursor and its context") end, { desc = "Explain this code" } },
      },
    },
    {
      "nvim-tree/nvim-web-devicons"
    }
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { "tokyonight", "habamax" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
