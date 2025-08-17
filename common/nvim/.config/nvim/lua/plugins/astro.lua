return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "astro-language-server",
      },
    },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        astro = {},
      },
      setup = {
        astro = function(_, opts)
          require("lspconfig").astro.setup(opts)
        end,
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { "astro" })
    end,
  },
}
