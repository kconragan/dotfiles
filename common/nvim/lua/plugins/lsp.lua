return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Lua (for Neovim config)
        lua_ls = {
          settings = { Lua = { diagnostics = { globals = { "vim" } } } },
        },

        -- Python
        basedpyright = {},
        ruff = {},

        -- Shell
        bashls = {},

        -- Web core
        html = {},
        cssls = {},

        -- JS/TS (prefer vtsls; otherwise tsserver)
        vtsls = {}, -- npm i -g @vtsls/language-server
        -- tsserver = {},

        -- Astro
        astro = {},

        -- Markdown
        marksman = {},

        -- Useful extras
        dockerls = {},
        jsonls = {},
        yamlls = {},

        -- If you want ESLint diagnostics (incl. MDX rules):
        -- eslint = {},
      },
    },
  },
}
