return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<leader>ff",
				"<cmd>Telescope find_files theme=dropdown<cr>",
				"Telescope: Find files",
			},
			{
				"<leader>fg",
				"<cmd>Telescope live_grep theme=dropdown<cr>",
				"Telescope: Live grep",
			},
		},
	},
}
