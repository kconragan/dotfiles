return {
  "mfussenegger/nvim-lint",
  opts = {
    linters_by_ft = {
      markdown = { "markdownlint" },
      -- If you also want to apply this to 'markdown.mdx' explicitly:
      markdown_mdx = { "markdownlint" },
    },
  },
  config = function()
    local markdownlint = require("lint").linters.markdownlint
    if markdownlint then
      markdownlint.args = {
        "--disable",
        "MD013",
        "MD007",
        "--", -- Required
      }
    end
  end,
}
