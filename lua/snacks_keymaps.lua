local map = vim.keymap.set
local Snacks = require "snacks"

-- Snacks keymaps
map("n", "<leader><space>", Snacks.picker.smart, { desc = "Smart Find Files" })
map("n", "<leader>,", Snacks.picker.buffers, { desc = "Buffers" })
map("n", ",.", Snacks.picker.grep, { desc = "Grep" })
map("n", "<leader>:", Snacks.picker.command_history, { desc = "Command History" })
map("n", "<leader>n", Snacks.picker.notifications, { desc = "Notification History" })
map("n", "<leader>e", "<cmd> lua Snacks.explorer()<CR>", { desc = "File Explorer" })

-- Snacks find keymaps
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map(
  "n",
  "<leader>fc",
  function() Snacks.picker.files { cwd = vim.fn.stdpath "config" } end,
  { desc = "Find Config File" }
)
map("n", "<leader>ff", Snacks.picker.files, { desc = "Find Files" })
map("n", "<leader>fg", Snacks.picker.git_files, { desc = "Find Git Files" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
map("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })

-- Snacks git keymaps
map("n", "<leader>gb", Snacks.picker.git_branches, { desc = "Git Branches" })
map("n", "<leader>gl", Snacks.picker.git_log, { desc = "Git Log" })
map("n", "<leader>gL", Snacks.picker.git_log_line, { desc = "Git Log Line" })
map("n", "<leader>gs", Snacks.picker.git_status, { desc = "Git Status" })
map("n", "<leader>gS", Snacks.picker.git_stash, { desc = "Git Stash" })
map("n", "<leader>gd", Snacks.picker.git_diff, { desc = "Git Diff (Hunks)" })
map("n", "<leader>gf", Snacks.picker.git_log_file, { desc = "Git Log File" })

-- Snacks grep keymaps
map("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
map("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", Snacks.picker.grep, { desc = "Grep" })
map("n", "<leader>sw", Snacks.picker.grep_word, { desc = "Visual selection or word" })

-- Snacks search keymaps
map("n", '<leader>s"', Snacks.picker.registers, { desc = "Registers" })
map("n", "<leader>s/", Snacks.picker.search_history, { desc = "Search History" })
map("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocommands" })
map("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
map("n", "<leader>sc", Snacks.picker.command_history, { desc = "Command History" })
map("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sC", Snacks.picker.commands, { desc = "Commands" })
map("n", "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", Snacks.picker.help, { desc = "Help Pages" })
map("n", "<leader>sH", Snacks.picker.highlights, { desc = "Highlights" })
map("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
map("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map("n", "<leader>sp", Snacks.picker.lazy, { desc = "Search For Plugin Spec" })
map("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
map("n", "<leader>sR", Snacks.picker.resume, { desc = "Resume" })
map("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })

-- Snacks LSP keymaps
map("n", "gd", Snacks.picker.lsp_definitions, { desc = "LSP Definitions" })
map("n", "gD", Snacks.picker.lsp_declarations, { desc = "LSP Declarations" })
map("n", "gr", Snacks.picker.lsp_references, { nowait = true, desc = "LSP References" })
map("n", "gI", Snacks.picker.lsp_implementations, { desc = "LSP Implementations" })
map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "LSP Type Definitions" })

map("n", "<leader>ls", Snacks.picker.lsp_symbols, { desc = "LSP Symbols" })
map("n", "<leader>lS", Snacks.picker.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })

-- Snacks Other keymaps
map("n", "<leader>.", function() Snacks.scratch() end, { desc = "Scratch Buffer" })
map("n", "<leader>S", function() Snacks.scratch.select() end, { desc = "Scratch Buffer" })

map("n", "<leader>n", Snacks.notifier.show_history, { desc = "Notification History" })
map("n", "<leader>un", Snacks.notifier.hide, { desc = "Dismiss All Notifications" })

map("n", "<leader>as", Snacks.picker.spelling, { desc = "Spelling Suggestions" })
