require "nvchad.options"
local autocmd = vim.api.nvim_create_autocmd

-- this shouild be run after the all the plugins are loaded

-- make sure we always have a vim.g.rustfmt_options = "--edition 2021"
-- see https://github.com/rust-lang/rust.vim/issues/464
autocmd("FileType", {
  pattern = { "rs" },
  callback = function()
      if not (not vim.g.rustfmt_options == nil and string.find(vim.g.rustfmt_options, "--edition")) then
        vim.g.rustfmt_options = "--edition 2021"
      end
  end
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
-- dont start with everything folded
vim.opt.foldenable = false
-- no idea
vim.opt.foldlevel = 99

