return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
    },
    config = function(_, opts)
      -- apply your ft→linter map
      require("lint").linters_by_ft = opts.linters_by_ft

      -- relax markdownlint rules
      local ml = require("lint").linters.markdownlint
      ml.args = {
        "--disable",
        "MD013",
        "MD007", -- no hard wrap & relaxed list indent
        "--", -- keep: tells markdownlint "end of its flags"
      }
    end,
  },
}
