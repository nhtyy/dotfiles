-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "ashes",

	hl_override = {
		Visual = { bg = "#9e9e9e", fg = "#ffffff" },
    LineNr = { fg = "#949494" },

    TelescopeMatching = { bg = "#949494", fg = "#ff7070" },
    TelescopeSelection = { link = "Visual" },
    TelescopeBorder = { link = "Visual" },
    TelescopeResultsTitle = { link = "Visual" },
    TelescopeResultsLineNr = { link = "Visual" },

    -- Tree Selection and graphics
    NvimTreeCursorLine = { bg = "#949494", fg = "#ffffff" },
    NvimTreeIndentMarker = { fg = "#ffffff" },
    NvimTreeFolderArrowOpen = { fg = "#ffffff" },
    NvimTreeFolderArrowClosed = { fg = "#ffffff" },

    -- LSP --
    DiagnosticUnnecessary = { fg = "#949494" },
    DiagnosticDeprecated = { fg = "#949494" },
    ["@comment"] = { fg = "#949494" },
    -- a few possible options for inlay hints
    -- also overriden by rusteaceanvim
    ["@lsp.inlayHint"] = { bg = "#4a4a4a", fg = "#b3b3b3" },
		LspInlayHint = { bg = "#4a4a4a", fg = "#b3b3b3" },
    ["@text.inlay"] = { bg = "#4a4a4a", fg = "#b3b3b3" }
  },
}

return M
