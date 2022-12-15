local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

local servers = mason_lspconfig.get_installed_servers()

mason.setup()
mason_lspconfig.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

local opts = {}

for _, server in pairs(servers) do

  opts = {
    on_attach = require("adamfraga.lsp.handlers").on_attach,
    capabilities = require("adamfraga.lsp.handlers").capabilities,
  }

  if server == "yamlls" then
    local yamlls_opts = require "adamfraga.lsp.settings.yamlls"
    opts = vim.tbl_deep_extend("force", yamlls_opts, opts)
  end

  if server == "tsserver" then
    local tsserver_opts = require "adamfraga.lsp.settings.tsserver"
    opts = vim.tbl_deep_extend("force", tsserver_opts, opts)
  end

  if server == "pyright" then
    local pyright_opts = require "adamfraga.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "emmet_ls" then
    print(vim.inspect(server))
    local emmet_ls_opts = require "adamfraga.lsp.settings.emmet_ls"
    opts = vim.tbl_deep_extend("force", emmet_ls_opts, opts)
  end

  if server == "sumneko_lua" then
    local lua_dev_status, lua_dev = pcall(require, "neodev")
    if not lua_dev_status then
      return
    end
    -- local sumneko_opts = require "adamfraga.lsp.settings.sumneko_lua"
    -- opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
    -- opts = vim.tbl_deep_extend("force", require("lua-dev").setup(), opts)
    local luadev = lua_dev.setup {
      --   -- add any options here, or leave empty to use the default settings
      -- lspconfig = opts,
      lspconfig = {
        on_attach = opts.on_attach,
        capabilities = opts.capabilities,
        --   -- settings = opts.settings,
      },
    }
    lspconfig.sumneko_lua.setup(luadev)
    --[[ goto continue ]]
  end

  if server == "rust_analyzer" then
    local rust_opts = require "adamfraga.lsp.settings.rust"
    -- opts = vim.tbl_deep_extend("force", rust_opts, opts)
    local rust_tools_status_ok, rust_tools = pcall(require, "rust-tools")
    if not rust_tools_status_ok then
      return
    end

    rust_tools.setup(rust_opts)
    goto continue
  end

  lspconfig[server].setup(opts)
  ::continue::
end
