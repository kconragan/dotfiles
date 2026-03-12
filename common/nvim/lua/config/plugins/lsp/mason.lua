return {
  "mason-org/mason.nvim",  -- Updated from "williamboman/mason.nvim"
  dependencies = {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
  },
  config = function()
    local mason = require("mason")
    local mason_tool_installer = require("mason-tool-installer")

    -- Enable mason and configure icons
    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- Auto-install formatters/linters (add prettierd for Markdown/Astro)
    mason_tool_installer.setup({
      ensure_installed = {
        "prettierd",  -- For Markdown, Astro, etc. (faster than prettier)
        "prettier",   -- Fallback
        "stylua",     -- Lua
        "black",      -- Python
        "isort",      -- Python
        "eslint_d",   -- JS/TS linter
        "pylint",     -- Python linter
      },
    })
  end,
}
