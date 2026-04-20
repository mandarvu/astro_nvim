local map = vim.keymap.set

-- Increment and Decrement numbers
map("n", "<leader>]", "<C-a>", { desc = "Increment number" })
map("n", "<leader>[", "<C-x>", { desc = "Decrement number" })

-- Disable/enable annoying lsp warnings
map("n", ",d", "<cmd>lua vim.diagnostic.enable(false)<CR>", { desc = "Disable annoying diagnostics" })
map("n", ",D", "<cmd>lua vim.diagnostic.enable(true)<CR>", { desc = "Enable annoying diagnostics when needed" })

-- scrolling and centering content in one go
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll and center content DOWNWARD" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll and center content UPWARDS" })

-- Control splits
map("n", ",,", "<C-w>w", { desc = "Cycle between splits" })
map("n", ",\\", "<C-w>v", { desc = "Split windows vertically" })
map("n", ",|", "<C-w>s", { desc = "Split windows horizontally" })
map("n", ",=", "<C-w>=", { desc = "Make splits of equal size" })
map("n", ",x", "<cmd>close<CR>", { desc = "Close current split" })

-- Move between buffers
map("n", "<A-]>", "<cmd>bn<CR>", { desc = "Move to next open buffer" })
map("n", "<A-[>", "<cmd>bp<CR>", { desc = "Move to previous open buffer" })

-- Move Lines
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move Up" })

-- Toggle ZenMode
map("n", "<leader>zw", "<cmd>ZenMode<CR>", { desc = "Toggle zen mode" })
map("n", "<leader>zz", "<cmd>WindowsMaximize<CR>", { desc = "Toggle Maximize window" })

-- Easy escape from insert mode
map("i", "jk", "<ESC>", { desc = "Escape Insert mode" })

-- hopping around in the visible window
map("n", "<leader>sc", "<cmd>HopChar2<CR>", { desc = "Hop 2 characters" })
map("n", "<leader>ss", "<cmd>HopWord<CR>", { desc = "Hop word" })
map("n", "<leader>sa", "<cmd>HopAnywhere<CR>", { desc = "Hop anywhere in current window" })
map("n", "<leader>se", "<cmd>HopAnywhereMW<CR>", { desc = "Hop anywhere in any window" })
map("n", "<leader>sl", "<cmd>HopAnywhereCurrentLine<CR>", { desc = "Hop anywhere on current line" })

-- insert date and time
map("n", "<M-t>", "<cmd>pu=strftime('%d/%m/%y %H:%M:%S')<CR>", { desc = "Insert date and time in normal mode" })
map("i", "<M-t>", "<cmd>pu=strftime('%d/%m/%y %H:%M:%S')<CR>", { desc = "Insert date and time in insert mode" })

-- Scrolling in insert mode
map("i", "<M-Space>", "<C-X><C-E>", { desc = "Scroll Down without leaving position in insert mode" })
map("i", "<C-M-Space>", "<C-X><C-Y>", { desc = "Scroll Up without leaving position in insert mode" })

-- Scrolling in Normal mode
map("n", "<M-Space>", "<C-E>", { desc = "Scroll Down without leaving position in insert mode" })
map("n", "<C-M-Space>", "<C-Y>", { desc = "Scroll Up without leaving position in insert mode" })

-- Jump to next line in insert mode without leaving the insert mode
-- map("i", "<C-m>", "<ESC>o", { desc = "Go to new line without leaving insert mode" })

map("t", "<C-\\>", "<C-\\><C-n>", { desc = "Escape terminal mode" })

map("n", "<leader>tt", "<cmd>TodoTelescope<CR>", { desc = "Search for TODO comments" })
-- Rust specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    vim.schedule(function()
      map("i", ";;", "<ESC>A;")
      -- map("i", "..", "::")
      map("n", ",c", "<cmd>Cargo check<CR>", { desc = "Run Cargo Check on Rust file" })
      map("n", ",r", "<cmd>Cargo run<CR>", { desc = "Run Rust file" })
      map("n", ",b", "<cmd>Cargo build<CR>", { desc = "Build Rust project" })
      map("n", ",f", "<cmd>RustFmt<CR>", { desc = "Format Rust file" })
    end)
  end,
})

-- Python specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    vim.schedule(function()
      map("i", ";;", "<ESC>A")
      map("i", ";'", "<ESC>o")
      map("n", "<leader>r", "<cmd>w|!python3 %<CR>", { desc = "Save and run Python script" })
      map("n", ",f", "<cmd>Format<CR>", { desc = "Format Python script" })
      map("n", "<leader>w", "<cmd>w|!ruff format %<CR><CR>", { desc = "Save and Format python file with Ruff" })
    end)
  end,
})

-- Go specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    vim.schedule(function()
      map("i", "z ", "<ESC>A")
      map("i", ";'", "<ESC>o")
      map("i", "<<", "<-")
      map("i", "<C-=>", ":=")
    end)
  end,
})

-- Tex specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function()
    -- vim.schedule(function() map("i", "mm", "$$<ESC>i") end)
    map("i", ";;", "<ESC>A")
    map("n", "<leader>w", "<cmd>w|!tex-fmt %<CR><CR>", { desc = "Format the LaTex Source File" })
  end,
})

-- Markdown Specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.schedule(function()
      -- map("i", "mm", "$$<ESC>i", { desc = "Enter math mode without leaving the insert mode in Markdown" })
      map("i", ";;", "<br><ESC>o")
    end)
  end,
})

map("n", "<C-h>", require("smart-splits").move_cursor_left)
map("n", "<C-j>", require("smart-splits").move_cursor_down)
map("n", "<C-k>", require("smart-splits").move_cursor_up)
map("n", "<C-l>", require("smart-splits").move_cursor_right)

map({ "n", "i", "s" }, "<c-f>", function()
  if not require("noice.lsp").scroll(4) then return "<c-f>" end
end, { silent = true, expr = true })

map({ "n", "i", "s" }, "<c-b>", function()
  if not require("noice.lsp").scroll(-4) then return "<c-b>" end
end, { silent = true, expr = true })
