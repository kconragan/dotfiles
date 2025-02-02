return {
	{
		"rebelot/kanagawa.nvim",
		name = "kanagawa",
		transparent = true,
		priority = 1000,
		config = function()
			vim.cmd("colorscheme kanagawa-wave")
		end,
	},
}
