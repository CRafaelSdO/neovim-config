return {
	{
		"saghen/blink.cmp",

		version = "*",
		event = "VeryLazy",

		dependencies = {
			"rafamadriz/friendly-snippets",
			"L3MON4D3/LuaSnip",
		},

		opts = {
			completion = {
				menu = { border = "rounded" },
				ghost_text = { enabled = true },

				accept = {
					auto_brackets = { enabled = true },
				},

				documentation = {
					window = { border = "rounded" },
				},

				list = {
					selection = {
						preselect = true,
						auto_insert = false,
					},
				},
			},

			signature = {
				window = { border = "rounded" },
			},

			snippets = { preset = "luasnip" },

			keymap = { preset = "super-tab" },

			cmdline = {
				keymap = { preset = "inherit" },

				completion = {
					menu = { auto_show = true },
					ghost_text = { enabled = true },

					list = {
						selection = {
							preselect = true,
							auto_insert = false,
						},
					},
				},
			},
		},
	},
}
