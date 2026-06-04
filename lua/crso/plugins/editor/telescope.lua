return {
	{
		"nvim-telescope/telescope.nvim",

		branch = "master",
		event = "VeryLazy",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
			"LukasPietzschmann/telescope-tabs",
			"nvim-telescope/telescope-ui-select.nvim",
		},

		opts = {
			defaults = {
				prompt_prefix = "   ",
				selection_caret = " ",
				entry_prefix = " ",
				sorting_strategy = "ascending",

				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
					},

					width = 0.87,
					height = 0.80,
				},
			},

			extensions_list = { "fzf", "telescope-tabs", "ui-select" },
			extensions = {},
		},
	},
}
