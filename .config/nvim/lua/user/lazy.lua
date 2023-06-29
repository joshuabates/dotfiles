local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "nvim-lua/plenary.nvim", -- Useful lua functions used by lots of plugins
  "folke/neodev.nvim",
  "windwp/nvim-autopairs", -- Autopairs, integrates with both cmp and treesitter
  "numToStr/Comment.nvim",
  {
    "kyazdani42/nvim-web-devicons",
    config = function()
      require("nvim-web-devicons").setup({})
    end
  },
  -- "kyazdani42/nvim-tree.lua",

  "nvim-lualine/lualine.nvim",
  "akinsho/toggleterm.nvim",
  "lukas-reineke/indent-blankline.nvim",
  "kylechui/nvim-surround",

  -- split/join via treesitter <leader-m>toggle
  {
    'Wansmer/treesj',
    requires = { 'nvim-treesitter' },
    config = function()
      require('treesj').setup({--[[ your config ]]})
    end,
  },
  'kevinhwang91/nvim-bqf',
  -- "gabrielpoca/replacer.nvim",
  -- uje { "stefandtw/quickfix-reflector.vim" }
  "goolord/alpha-nvim",
  -- Colorschemes
  {
    "sainnhe/gruvbox-material",
    tag = "v1.2.4"
  },
  "lunarvim/darkplus.nvim",
  "rcarriga/nvim-notify",

  -- cmp plugins
  "hrsh7th/nvim-cmp", -- The completion plugin
  "hrsh7th/cmp-buffer", -- buffer completions
  "hrsh7th/cmp-path", -- path completions
  "saadparwaiz1/cmp_luasnip", -- snippet completions
  "hrsh7th/cmp-nvim-lsp",
  "hrsh7th/cmp-nvim-lua",

  -- snippets
  "L3MON4D3/LuaSnip", --snippet engine
  -- "rafamadriz/friendly-snippets", -- a bunch of snippets to use

  -- LSP
  "neovim/nvim-lspconfig", -- enable LSP
  "williamboman/nvim-lsp-installer", -- simple to use language server installer
  "jose-elias-alvarez/null-ls.nvim", -- for formatters and linters
  -- "RRethy/vim-illuminate",
  'ray-x/lsp_signature.nvim',
  'jose-elias-alvarez/typescript.nvim',

  -- Telescope
  "nvim-telescope/telescope.nvim",
  -- use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  "natecraddock/telescope-zf-native.nvim",
  "nvim-telescope/telescope-file-browser.nvim",
  'tknightz/telescope-termfinder.nvim',
  'nvim-telescope/telescope-ui-select.nvim',

  -- Treesitter
  "nvim-treesitter/nvim-treesitter",
  'nvim-treesitter/playground', 
  "RRethy/nvim-treesitter-textsubjects",
  "JoosepAlviste/nvim-ts-context-commentstring",
  "RRethy/nvim-treesitter-endwise",
  "github/copilot.vim",
  -- Git
  "lewis6991/gitsigns.nvim",
  {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("gitlinker").setup()
    end
  },

  -- use { 'rhysd/git-messenger.vim' }
  -- use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' },

  'tpope/vim-fugitive',

  'famiu/nvim-reload',
  "vim-ruby/vim-ruby",

  -- Navigation

  'knubie/vim-kitty-navigator',
  {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup {
        dimming = {
          alpha = 0.5, -- amount of dimming
        },
        expand = { -- for treesitter, we we always try to expand to the top-most ancestor with these types
          "function",
          "method",
          "table",
          "if_statement",
          "method_definition",
      },
      }
    end
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("zen-mode").setup {
        window = {
          width = .5,
          backdrop = 0.5,
        },
        plugins = {
          twilight = { enabled = false },
          kitty = {
            enabled = true,
            font = "+4",
          }
        },
        on_open = function(win)
          local cmd = "kitty @ --to %s goto_layout stack"
          local socket = vim.fn.expand("$KITTY_LISTEN_ON")
          vim.fn.system(cmd:format(socket))
        end,
        on_close = function()
          local cmd = "kitty @ --to %s kitten zoom_toggle.py"
          local socket = vim.fn.expand("$KITTY_LISTEN_ON")
          vim.fn.system(cmd:format(socket, opts.font))
        end
      }
    end
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
  {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  },
}, {})
