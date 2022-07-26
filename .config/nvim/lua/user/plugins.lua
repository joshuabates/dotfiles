local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use { "wbthomason/packer.nvim" } -- Have packer manage itself
  use { "nvim-lua/plenary.nvim" } -- Useful lua functions used by lots of plugins
  use { "windwp/nvim-autopairs" } -- Autopairs, integrates with both cmp and treesitter
  use { "numToStr/Comment.nvim" }
  use { "kyazdani42/nvim-web-devicons" }
  -- use { "kyazdani42/nvim-tree.lua" }

  use { "nvim-lualine/lualine.nvim" }
  use { "akinsho/toggleterm.nvim" }
  use { "lukas-reineke/indent-blankline.nvim" }
  use({
    "kylechui/nvim-surround",
    -- TODO: Can this handle ruby symbol to string?
    config = function()
      require("nvim-surround").setup({})
    end
  })
  use {'kevinhwang91/nvim-bqf'}
  -- use {
  --   "folke/trouble.nvim",
  --   requires = "kyazdani42/nvim-web-devicons",
  -- }
  use { "goolord/alpha-nvim" }
  -- Colorschemes
  use { "sainnhe/gruvbox-material" }
  use { "lunarvim/darkplus.nvim" }

  -- cmp plugins
  use { "hrsh7th/nvim-cmp" } -- The completion plugin
  use { "hrsh7th/cmp-buffer" } -- buffer completions
  use { "hrsh7th/cmp-path" } -- path completions
  use { "saadparwaiz1/cmp_luasnip" } -- snippet completions
  use { "hrsh7th/cmp-nvim-lsp" }
  use { "hrsh7th/cmp-nvim-lua" }

  -- snippets
  use { "L3MON4D3/LuaSnip" } --snippet engine
  -- use { "rafamadriz/friendly-snippets" } -- a bunch of snippets to use

  -- LSP
  use { "neovim/nvim-lspconfig" } -- enable LSP
  use { "williamboman/nvim-lsp-installer" } -- simple to use language server installer
  use { "jose-elias-alvarez/null-ls.nvim" } -- for formatters and linters
  -- use { "RRethy/vim-illuminate" }
  use { 'ray-x/lsp_signature.nvim' }
  use { 'jose-elias-alvarez/typescript.nvim' }

  -- Telescope
  use { "nvim-telescope/telescope.nvim" }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {'tknightz/telescope-termfinder.nvim' }
  use {'nvim-telescope/telescope-ui-select.nvim' }

  -- Treesitter
  use { "nvim-treesitter/nvim-treesitter" }
  use { "RRethy/nvim-treesitter-textsubjects" }
  use { "JoosepAlviste/nvim-ts-context-commentstring", commit = "88343753dbe81c227a1c1fd2c8d764afb8d36269" }
  use { "RRethy/nvim-treesitter-endwise" }

  -- Git
  use { "lewis6991/gitsigns.nvim" }
  use {
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("gitlinker").setup()
    end
  }
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use { 'emmanueltouzery/agitator.nvim' }

  use { "vim-ruby/vim-ruby" }

  -- Navigation

  use { 'knubie/vim-kitty-navigator' }--, { 'commit': '08a792' }
  -- DAP
  -- use { "mfussenegger/nvim-dap" }
  -- use { "rcarriga/nvim-dap-ui" }
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
  -- use { "klen/nvim-test" }
  use { "janko/vim-test" }
  -- use { "ravenxrz/DAPInstall.nvim" }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
