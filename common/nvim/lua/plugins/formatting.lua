return {
  -- Auto-format on save with Conform
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    opts = {
      notify_on_error = true,
      format_on_save = function(_)
        return { lsp_fallback = true, timeout_ms = 1500 }
      end,
      -- First available formatter wins
      formatters_by_ft = {
        lua = { "stylua" },

        -- Python
        python = { "ruff_format", "black" },

        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },

        -- Web / Astro / MDX / Markdown
        javascript = { "prettierd", "prettier" },
        typescript = { "prettierd", "prettier" },
        javascriptreact = { "prettierd", "prettier" },
        typescriptreact = { "prettierd", "prettier" },
        vue = { "prettierd", "prettier" },
        svelte = { "prettierd", "prettier" },
        astro = { "prettierd", "prettier" },
        html = { "prettierd", "prettier" },
        css = { "prettierd", "prettier" },
        scss = { "prettierd", "prettier" },
        json = { "prettierd", "prettier" },
        jsonc = { "prettierd", "prettier" },
        yaml = { "prettierd", "prettier" },
        markdown = { "prettierd", "prettier" },
        mdx = { "prettierd", "prettier" },

        -- Extras
        toml = { "taplo" },
        terraform = { "terraform_fmt" },
        c = { "clang_format" },
        cpp = { "clang_format" },
        go = { "gofumpt", "goimports" },
        rust = { "rustfmt" },
      },
    },
  },

  -- Lightweight lint on save / insert-leave
  {
    "mfussenegger/nvim-lint",
    event = { "BufWritePost", "InsertLeave", "BufReadPost", "BufNewFile" },
    opts = {
      linters_by_ft = {
        python = { "ruff" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        markdown = { "markdownlint" },
        dockerfile = { "hadolint" },
        -- For JS/TS/MDX you can use eslint-lsp instead of nvim-lint.
      },
    },
    config = function(_, opts)
      local lint = require("lint")
      lint.linters_by_ft = opts.linters_by_ft or {}
      vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
}
