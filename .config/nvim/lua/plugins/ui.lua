return {
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			defaults = {
				layout_config = {
					preview_width = 0.5,
				},
			},
			pickers = {
				find_files = {
					find_command = {
						"rg",
						"--ignore",
						"--hidden",
						"--files",
						"--glob",
						"!**/.git/*",
					},
				},
			},
		},
		keys = {
			{
				"<leader>ff",
				"<cmd>Telescope find_files<cr>",
				"Telescope: Find files",
			},
			{
				"<leader>fg",
				"<cmd>Telescope live_grep<cr>",
				"Telescope: Live grep",
			},
		},
	},
}
