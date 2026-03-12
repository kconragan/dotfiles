return {
  {
    "stevearc/conform.nvim",
    opts = function(_, opts)
      opts.formatters_by_ft = vim.tbl_extend("force", opts.formatters_by_ft or {}, {
        markdown = { "prettier" },
        markdown_inline = { "prettier" },
      })
      opts.formatters = vim.tbl_extend("force", opts.formatters or {}, {
        prettier = {
          prepend_args = { "--prose-wrap", "preserve", "--print-width", "100" },
        },
      })
      -- Optional: disable autoformat-on-save for markdown only
      -- opts.format_on_save = function(buf)
      --   if vim.bo[buf].filetype == "markdown" then return nil end
      --   return { lsp_fallback = true, timeout_ms = 1000 }
      -- end
    end,
  },
}
