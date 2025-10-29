return {
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        -- LSP
        "lua-language-server",
        "basedpyright",
        "ruff",
        "bash-language-server",
        "html-lsp",
        "css-lsp",
        "astro-language-server",
        "vtsls", -- or "typescript-language-server"
        "marksman",
        "dockerfile-language-server",
        "json-lsp",
        "yaml-language-server",
        -- "eslint-lsp",

        -- Formatters
        "stylua",
        "prettierd",
        "black",
        "shfmt",
        "gofumpt",
        "goimports",
        "taplo",
        "clang-format",
        "rustfmt",

        -- Linters
        "ruff",
        "shellcheck",
        "markdownlint",
        "hadolint",
      },
      run_on_start = true,
    },
  },
}
