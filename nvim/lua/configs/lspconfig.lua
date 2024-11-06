-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"
local default_configs = require "nvchad.configs.lspconfig"

-- setup the language server, note we will override
-- some opts below
local servers = {
  gopls = {},
  solidity = {}
}

-- setup solidity config
require("lspconfig.configs").solidity = {
  default_config = {
    cmd = {'nomicfoundation-solidity-language-server', '--stdio'},
    filetypes = { 'solidity' },
    root_dir = lspconfig.util.find_git_ancestor,
    single_file_support = true,
  },
}

for name, opts in pairs(servers) do
  opts.on_init = default_configs.on_init
  opts.on_attach = default_configs.on_attach
  opts.capabilities = default_configs.capabilities

  lspconfig[name].setup(opts)
end
