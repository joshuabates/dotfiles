return {
	"nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
	"folke/neodev.nvim",
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		opts = { check_ts = true },
		config = function(_, opts)
			local ap = require("nvim-autopairs")
			ap.setup(opts)
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			local cmp = require("cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end,
	},
	"numToStr/Comment.nvim",
	-- "kyazdani42/nvim-tree.lua",

	"lukas-reineke/indent-blankline.nvim",
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	-- "gabrielpoca/replacer.nvim",
	-- uje { "stefandtw/quickfix-reflector.vim" }

	"github/copilot.vim",
	"famiu/nvim-reload",
	"vim-ruby/vim-ruby",
	{
		"folke/which-key.nvim",
		opts = {
			plugins = { spelling = true },
			defaults = {
				mode = { "n", "v" },
				["g"] = { name = "+goto" },
				["gz"] = { name = "+surround" },
				["]"] = { name = "+next" },
				["["] = { name = "+prev" },
				-- ["<leader><tab>"] = { name = "+tabs" },
				-- ["<leader>b"] = { name = "+buffer" },
				["<leader>c"] = { name = "+code" },
				["<leader>f"] = { name = "+file/find" },
				["<leader>g"] = { name = "+git" },
				-- ["<leader>gh"] = { name = "+hunks" },
				["<leader>q"] = { name = "+quit/session" },
				-- ["<leader>s"] = { name = "+search" },
				-- ["<leader>u"] = { name = "+ui" },
				["<leader>w"] = { name = "+windows" },
				["<leader>x"] = { name = "+diagnostics/quickfix" },
			},
		},
		config = function(_, opts)
			local wk = require("which-key")
			wk.setup(opts)
			wk.register(opts.defaults)
		end,
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		vscode = true,
		---@type Flash.Config
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "o", "x" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
		},
	},
	-- DAP
	-- "mfussenegger/nvim-dap",
	-- "rcarriga/nvim-dap-ui",
	--
	-- neotest doesn't yet have an adapter to run specs in toggleterm with streaming output but recently added APIs to allow both
	-- https://github.com/nvim-neotest/neotest/pull/70 (streaming output)
	-- https://github.com/nvim-neotest/neotest/discussions/46 (custom consumers)
	-- https://github.com/nvim-neotest/neotest/issues/50
	--
	-- use({
	--   'nvim-neotest/neotest',
	--   requires = {
	--     "nvim-lua/plenary.nvim",
	--     "nvim-treesitter/nvim-treesitter",
	--     "antoinemadec/FixCursorHold.nvim",
	--     'olimorris/neotest-rspec',
	--   },
	-- })
	--
	-- https://github.com/vuki656/package-info.nvim
	--
	"janko/vim-test",
	-- "ravenxrz/DAPInstall.nvim",
}
