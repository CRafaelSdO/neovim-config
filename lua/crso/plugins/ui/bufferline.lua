return {
	{
		"tiagovla/scope.nvim",

		event = "VeryLazy",
		config = true,
	},

	{
		"akinsho/bufferline.nvim",

		version = "*",
		event = "VeryLazy",
		dependencies = "nvim-tree/nvim-web-devicons",

		opts = {
			options = {
				mode = "buffers",
				separator_style = "slant",
				close_icon = "",
				buffer_close_icon = "",
				modified_icon = "",
				left_trunc_marker = "",
				right_trunc_marker = "",
			},
		},
	},
}
