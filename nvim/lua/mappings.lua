require "nvchad.mappings"

local map = vim.keymap.set

-- Note: These mappings are applied as "very last step" of setting up vim

------------------------------------
--- Helpers ---
------------------------------------

--- true if all the buffers were succsessfully closed
--- @return boolean 
local close_all_saved_bufs = function()
    -- Get the list of all buffers
    local buffers = vim.api.nvim_list_bufs()

    for _, buf in ipairs(buffers) do
      -- Only close the buffer if it is loaded and not modified
      if not vim.bo[buf].modified and vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
        -- Close the buffer
        vim.api.nvim_buf_delete(buf, {})
      end
    end

    -- make sure were not on a modified buffer
    return not vim.bo[vim.api.nvim_get_current_buf()].modified
  end

--- the buffers that are listed, generally these are user buffers for editing
--- @return integer[] 
local listed_buffers = function()
  --  create a new arr to store the listed buffers
  local listed = {}

  local buffers = vim.api.nvim_list_bufs()
  for _, buf in ipairs(buffers) do
    if vim.api.nvim_get_option_value("buflisted", { buf = buf }) then
      listed[#listed + 1] = buf;
    end
  end

  return listed
end

--- Check if the buf is valid and listed
--- @param buf integer
--- @return boolean
local is_good_buffer = function(buf)
  return vim.api.nvim_buf_is_valid(buf) and
    vim.api.nvim_get_option_value("buflisted", { buf = buf })
end

------------------------------------
--- Mappings ---
------------------------------------

-- Close the current buffer if its not modified and switch to the last visited buffer
map("n", "<leader>d",
  function()
    local to_close = vim.api.nvim_get_current_buf()
    local target_previous = vim.fn.bufnr("#")
    local listed = listed_buffers()

    -- Only close the buffer if it is loaded and not modified
    if not vim.bo[to_close].modified then
      -- we should have a listed buffer otherwise we need to focus the tree
      -- the previous buffer should be a listed buffer
      -- if we have that we can switch to it 
      -- otherwise we focus the tree
      if #listed > 1 then
        if to_close ~= target_previous and
          is_good_buffer(target_previous) then
            vim.cmd("buffer " .. target_previous)
            vim.api.nvim_buf_delete(to_close, {})

            return true
        end

        -- we got a bad buffer (ie its not listed)
        -- so focus the last listed buffer before we close this buffer so we dont close the buffer window 
        vim.cmd("buffer " .. listed[#listed - 1])
      end

      vim.cmd("NvimTreeFocus")

      -- Close the buffer
      vim.api.nvim_buf_delete(to_close, {})
    else
      print("This file has unsaved modifications")
    end
  end,
  { desc = "Close current buffer if its not modified and switch to the last visited buffer"})

--- Close all saved buffers
map("n", "<leader>%d",
  function()
    if close_all_saved_bufs() then
      vim.cmd("NvimTreeFocus")
    end

    print("Closed all saved buffers.")
  end,
{ desc = "Close all unmodfied buffers", noremap = true, silent = true })

-- Quit nvim if there are no unsaved files, closes all saved ones
map("n", "<leader>q",
  function()
    if close_all_saved_bufs() then
      vim.cmd("q | q")
    else
      vim.cmd("NvimTreeFocus")
      print("Couldnt quit becuase of unsaved bufffers")
    end
  end,
{ desc = "Quit nvim if there are no unsaved files, closes all saved ones", noremap = true, silent = true })

-- Open diagnosttics in a floating window
map("n", "<S-CR>",
  function()
    vim.diagnostic.open_float()
  end,
{ desc = "Open diagnostic info in a pop up window"})


-- Display lsp info when you press enter
map("n", "<CR>",
  function()
    vim.lsp.buf.hover()
  end,
{ desc = "Open the LSP info pop up window"})


-- Focus the tree when you double press esc
map("n", "<ESC><ESC>", function() vim.cmd("NvimTreeFocus") end)


map('i', '<C-l>', 'copilot#Accept("\\<CR>")', {
  expr = true,
  replace_keycodes = false,
  desc = "Copilot Accept"
})


------------------------------------
-- Disable Block --
------------------------------------

-- Disable any keybindings below
local disable = vim.keymap.del

-- Pretty useless by default and annoying cause you have to hit enter when closing tabs with this setup
disable("n", "<leader>ds")


