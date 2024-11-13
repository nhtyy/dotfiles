return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
    opts = {
      setup = {
        -- dont setup rust analyzer, per rustaceanvim
        rust_analyzer = function()
          return true
        end,
      },
    },
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      -- Mapping tab is already used by NvChad
      vim.g.copilot_no_tab_map = true;
      vim.g.copilot_assume_mapped = true;
      vim.g.copilot_tab_fallback = "";
      -- The mapping is set to other key, see mappings,lua
      -- or run <leader>ch to see copilot mapping section
    end
  },

  -- rust lsp
  -- must have rust-analyzer installed
  {
    'mrcjkb/rustaceanvim',
    version = '^5',
    lazy = false,
    ft = "rust",
    config = function ()
      vim.g.rustaceanvim = {
        server = {
          on_attach = function(_, _)
            -- Display inlay hints always
            vim.lsp.inlay_hint.enable(true)
            vim.api.nvim_set_hl(0, "Comment", { link = "@comment" })
            vim.api.nvim_set_hl(0, "LspInlayHint", { bg = "#4a4a4a", fg = "#b3b3b3" })
          end,
        },
      }
    end
  },

  -- nvim lua types
  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  -- auto fmt / clippy 
  {
    'rust-lang/rust.vim',
    ft = "rust",
    init = function ()
      vim.g.rustfmt_autosave = 1
    end,
  },

  -- cargo toml information tool
  {
    'saecki/crates.nvim',
    ft = {"toml"},
    config = function()
      require("crates").setup {
        completion = {
          cmp = {
            enabled = true
          },
        },
      }
      require('cmp').setup.buffer({
        sources = { { name = "crates" }}
      })
    end
  },

  -- syntax highlighting
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    opts = {
      ensure_installed = {
        "tsx",
        "typescript",
        "go",
        "lua",
        "rust",
        "html",
        "css",
        "c",
        "solidity"
      }
    }
  }
}
