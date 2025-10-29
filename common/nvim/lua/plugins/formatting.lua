return {
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

        -- Web / Astro / Markdown / MDX
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

        -- The important bits for you:
        markdown = { "prettierd", "prettier" },
        mdx = { "prettierd", "prettier" },
        ["markdown.mdx"] = { "prettierd", "prettier" },
        ["markdown.gfm"] = { "prettierd", "prettier" }, -- just in case
      },
    },
    config = function(_, opts)
      local conform = require("conform")
      conform.setup(opts)

      -- Explicit save hooks so markdown/mdx always format
      local aug = vim.api.nvim_create_augroup("ConformMarkdownOnSave", { clear = true })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = aug,
        pattern = { "*.md", "*.mdx" },
        callback = function(args)
          conform.format({ bufnr = args.buf, lsp_fallback = true, timeout_ms = 1500 })
        end,
      })
    end,
  },

  -- keep your nvim-lint block below unchanged
}
