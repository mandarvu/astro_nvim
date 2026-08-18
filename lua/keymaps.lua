local map = vim.keymap.set

local function select_enclosing_delimiter(visual)
  local pairs = {
    { open = "(", close = ")", nested = true },
    { open = "[", close = "]", nested = true },
    { open = "{", close = "}", nested = true },
    { open = "<", close = ">", nested = true },
    { open = '"', close = '"', nested = false },
    { open = "'", close = "'", nested = false },
    { open = "`", close = "`", nested = false },
  }

  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  if vim.tbl_isempty(lines) then return end

  local line_starts = {}
  local offset = 0
  for i, line in ipairs(lines) do
    line_starts[i] = offset
    offset = offset + #line + 1
  end

  local function abs_pos(line, col)
    if not line or line < 1 or not line_starts[line] then return nil end
    return line_starts[line] + col
  end

  local function line_col(abs)
    for line = #line_starts, 1, -1 do
      if abs >= line_starts[line] then return line, abs - line_starts[line] end
    end
    return 1, 0
  end

  local start_abs
  local end_abs

  if visual then
    local cursor = vim.api.nvim_win_get_cursor(0)
    local anchor = vim.fn.getpos "v"
    local selection_start = vim.fn.getpos "'<"
    local selection_end = vim.fn.getpos "'>"
    local cursor_abs = abs_pos(cursor[1], cursor[2])
    local anchor_abs = abs_pos(anchor[2], anchor[3] - 1)

    if cursor_abs and anchor_abs then
      start_abs = math.min(cursor_abs, anchor_abs)
      end_abs = math.max(cursor_abs, anchor_abs)
    else
      start_abs = abs_pos(selection_start[2], selection_start[3] - 1)
      end_abs = abs_pos(selection_end[2], selection_end[3] - 1)
    end
  else
    local cursor = vim.api.nvim_win_get_cursor(0)
    start_abs = abs_pos(cursor[1], cursor[2])
    end_abs = start_abs
  end
  if not start_abs or not end_abs then return end

  local candidates = {}
  local function add_candidate(open_abs, close_abs)
    local inner_start = open_abs + 1
    local inner_end = close_abs - 1
    if inner_start <= start_abs and inner_end >= end_abs and (inner_start < start_abs or inner_end > end_abs) then
      table.insert(candidates, { start_abs = inner_start, end_abs = inner_end, size = close_abs - open_abs })
    end
  end

  local quote_open = {}
  local stacks = {}
  for _, pair in ipairs(pairs) do
    if pair.nested then stacks[pair.open] = {} end
  end

  for line_nr, line in ipairs(lines) do
    local i = 1
    while i <= #line do
      local char = line:sub(i, i)
      local current_abs = abs_pos(line_nr, i - 1)

      for _, pair in ipairs(pairs) do
        if pair.nested then
          if char == pair.open then
            table.insert(stacks[pair.open], current_abs)
          elseif char == pair.close then
            local open_abs = table.remove(stacks[pair.open])
            if open_abs then add_candidate(open_abs, current_abs) end
          end
        elseif char == pair.open then
          local escaped = i > 1 and line:sub(i - 1, i - 1) == "\\"
          if not escaped then
            if quote_open[pair.open] then
              add_candidate(quote_open[pair.open], current_abs)
              quote_open[pair.open] = nil
            else
              quote_open[pair.open] = current_abs
            end
          end
        end
      end

      i = i + 1
    end
  end

  if vim.tbl_isempty(candidates) then return end

  table.sort(candidates, function(a, b) return a.size < b.size end)
  local target = candidates[1]
  local start_line, start_col = line_col(target.start_abs)
  local end_line, end_col = line_col(target.end_abs)

  vim.fn.setpos("'<", { 0, start_line, start_col + 1, 0 })
  vim.fn.setpos("'>", { 0, end_line, end_col + 1, 0 })
  vim.cmd "normal! gv"
end

map("n", "<leader>h", "<CMD>Alpha<CR>")

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

map({ "i", "s" }, "<Tab>", function()
  if vim.snippet and vim.snippet.active { direction = 1 } then
    vim.snippet.jump(1)
    return
  end

  local width = vim.fn.shiftwidth()
  if width == 0 then width = vim.bo.tabstop end
  local text = vim.bo.expandtab and string.rep(" ", width) or "\t"
  vim.api.nvim_put({ text }, "c", true, true)
end, { silent = true, desc = "Tab or snippet jump" })

map({ "i", "s" }, "<S-Tab>", function()
  if vim.snippet and vim.snippet.active { direction = -1 } then vim.snippet.jump(-1) end
end, { silent = true, desc = "Shift-Tab or snippet jump" })

-- select and expand around enclosing delimiters
map("n", "<leader>v", function() select_enclosing_delimiter(false) end, { desc = "Select enclosing delimiter" })
map("x", "<leader>v", function() select_enclosing_delimiter(true) end, { desc = "Expand enclosing delimiter" })

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
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.schedule(function()
      map("i", ";;", "<ESC>A;", opts)
      -- map("i", "..", "::")
      map("n", ",c", "<cmd>Cargo check<CR>", vim.tbl_extend("force", opts, { desc = "Run Cargo Check on Rust file" }))
      map("n", ",r", "<cmd>Cargo run<CR>", vim.tbl_extend("force", opts, { desc = "Run Rust file" }))
      map("n", ",b", "<cmd>Cargo build<CR>", vim.tbl_extend("force", opts, { desc = "Build Rust project" }))
      map("n", ",f", "<cmd>RustFmt<CR>", vim.tbl_extend("force", opts, { desc = "Format Rust file" }))
    end)
  end,
})

-- Python specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.schedule(function()
      map("i", ";;", "<ESC>A", opts)
      map("i", ";'", "<ESC>o", opts)
      map("n", "<leader>r", "<cmd>w|!python3 %<CR>", vim.tbl_extend("force", opts, { desc = "Save and run Python script" }))
      map("n", ",f", "<cmd>Format<CR>", vim.tbl_extend("force", opts, { desc = "Format Python script" }))
      map("n", "<leader>w", "<cmd>w|!ruff format %<CR><CR>", vim.tbl_extend("force", opts, { desc = "Save and Format python file with Ruff" }))
    end)
  end,
})

-- Go specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.schedule(function()
      map("i", "z ", "<ESC>A", opts)
      map("i", ";'", "<ESC>o", opts)
      map("i", "<<", "<-", opts)
      map("i", "<C-=>", ":= ", opts)
      map("i", "<C-->", "!= ", opts)
    end)
  end,
})

-- Tex specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function(args)
    local opts = { buffer = args.buf }
    -- vim.schedule(function() map("i", "mm", "$$<ESC>i") end)
    map("i", ";;", "<ESC>A", opts)
    map("n", "<leader>w", "<cmd>w|!tex-fmt %<CR><CR>", vim.tbl_extend("force", opts, { desc = "Format the LaTex Source File" }))
  end,
})

-- Markdown Specific keymaps
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function()
    vim.schedule(function()
      -- map("i", "mm", "$$<ESC>i", { desc = "Enter math mode without leaving the insert mode in Markdown" })
      -- map("i", ";;", "<br><ESC>o")
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
