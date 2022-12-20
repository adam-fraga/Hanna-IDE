local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer close and reopen Neovim...")
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
})

-- Install your plugins here
return packer.startup(function(use)

  -- PERSONNAL PLUGINS
  use("/Users/adamfraga/plugins/test.nvim")
  --[[ use("/Users/adamfraga/plugins/nvim-gpt.nvim") ]]

  -- ESSENTIALS
  use("wbthomason/packer.nvim") -- Have packer manage itself
  use("nvim-lua/popup.nvim") -- An implementation of the Popup API from vim in Neovim
  use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
  use("lewis6991/impatient.nvim") -- Increase NVIM performance

  -- Productivity
  use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })
  use("ahmedkhalf/project.nvim")
  use("folke/which-key.nvim")
  use("folke/lua-dev.nvim")
  use("numToStr/Comment.nvim") -- Easily comment stuff
  use("JoosepAlviste/nvim-ts-context-commentstring")
  use("kyazdani42/nvim-tree.lua")
  use("moll/vim-bbye") -- Buffer close

  --UI & Customization
  use("goolord/alpha-nvim")
  use("lukas-reineke/indent-blankline.nvim")
  use("kyazdani42/nvim-web-devicons")
  use("akinsho/bufferline.nvim")
  use("tiagovla/tokyodark.nvim")
  use({ "catppuccin/nvim", as = "catppuccin" }) -- COLORSCHEME
  use("nvim-lualine/lualine.nvim")
  use("andweeb/presence.nvim")
  use("rcarriga/nvim-notify") --Notify

  -- Debugging
  use("mfussenegger/nvim-dap")
  use("theHamsta/nvim-dap-virtual-text")
  use("rcarriga/nvim-dap-ui")
  use("mfussenegger/nvim-dap-python")
  use("nvim-telescope/telescope-dap.nvim")


  -- Cmp plugins
  use("hrsh7th/nvim-cmp") -- The completion plugin
  use("hrsh7th/cmp-nvim-lsp")
  use 'simrat39/rust-tools.nvim'
  use("hrsh7th/cmp-buffer") -- buffer completions
  use("hrsh7th/cmp-path") -- path completions
  use("hrsh7th/cmp-cmdline") -- cmdline completions
  use("saadparwaiz1/cmp_luasnip") -- snippet completions

  -- Snippets
  use("L3MON4D3/LuaSnip") --snippet engine
  use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

  -- LSP
  use("williamboman/mason.nvim") --lsp package manager
  use("williamboman/mason-lspconfig.nvim")
  use("neovim/nvim-lspconfig") -- enable LSP
  use("tamago324/nlsp-settings.nvim") -- language server settings defined in json for
  use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
  use("mfussenegger/nvim-jdtls") --Support for JAVA langage
  use("antoinemadec/FixCursorHold.nvim") -- This is needed to fix lsp doc highlight
  use "b0o/schemastore.nvim"
  -- Finder
  use("nvim-telescope/telescope.nvim")
  use("ThePrimeagen/harpoon")

  -- Treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  })

  -- GIT

  use('lewis6991/gitsigns.nvim')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
