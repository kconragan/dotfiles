return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
        mdx = { "markdownlint" },
      },
      linters = {
        markdownlint = {
          args = { "--disable", "MD013", "MD033", "--" },
        },
      },
    },
  },
}
