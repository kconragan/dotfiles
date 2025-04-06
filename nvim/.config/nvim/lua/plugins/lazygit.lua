return {
  "kdheepak/lazygit.nvim",
  cmd = { "LazyGit", "LazyGitConfig" },
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<leader>gg", "<cmd>LazyGit<cr>", desc = "Open LazyGit" },
  },
}
