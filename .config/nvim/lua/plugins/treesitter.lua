return {
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	"RRethy/nvim-treesitter-textsubjects",
	"JoosepAlviste/nvim-ts-context-commentstring",
	"RRethy/nvim-treesitter-endwise",

	-- split/join via treesitter <leader-m>toggle
	{
		"Wansmer/treesj",
		dependencies = { "nvim-treesitter" },
		keys = {
			{ "gj", ":TSJToggle<cr>", desc = "Split/Join" },
		},
		config = function()
			require("treesj").setup({--[[ your config ]]
				use_default_keymaps = false,
			})
		end,
	},
	{
		"mizlan/iswap.nvim",
		keys = {
			{ "gs", ":ISwapNodeWith<cr>", desc = "Swap node" },
			-- { "<leader>is", ":ISwap<cr>", desc = "Swap many arguments" },
		},
		opts = {},
	},
}
