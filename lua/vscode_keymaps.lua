-- Keymaps for vscode-neovim. Plugin-specific bindings (Snacks, smart-splits,
-- noice, ZenMode, etc.) replaced with vscode.action commands. Buffer-editing
-- keys (move lines, escape, hop, dial) preserved.

local map = vim.keymap.set
local ok, vscode = pcall(require, "vscode")
if not ok then return end

local function act(cmd, opts) return function() vscode.action(cmd, opts) end end

-- Increment / Decrement
map("n", "<leader>]", "<C-a>", { desc = "Increment number" })
map("n", "<leader>[", "<C-x>", { desc = "Decrement number" })

-- Diagnostics toggle (delegate to VSCode problems panel)
map("n", ",d", act "workbench.actions.view.problems", { desc = "Show problems panel" })
map("n", ",D", act "editor.action.marker.next", { desc = "Next diagnostic" })

-- Scroll + center
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })

-- Splits via VSCode
map("n", ",,", act "workbench.action.focusNextGroup", { desc = "Cycle editor groups" })
map("n", ",\\", act "workbench.action.splitEditorRight", { desc = "Split right" })
map("n", ",|", act "workbench.action.splitEditorDown", { desc = "Split down" })
map("n", ",=", act "workbench.action.evenEditorWidths", { desc = "Even split sizes" })
map("n", ",x", act "workbench.action.closeActiveEditor", { desc = "Close editor" })

-- Directional split nav (editor groups + sidebar/panel)
map("n", "<C-h>", act "workbench.action.navigateLeft", { desc = "Focus left group" })
map("n", "<C-j>", act "workbench.action.navigateDown", { desc = "Focus down group" })
map("n", "<C-k>", act "workbench.action.navigateUp", { desc = "Focus up group" })
map("n", "<C-l>", act "workbench.action.navigateRight", { desc = "Focus right group" })

-- Buffer / tab nav
map("n", "<A-]>", act "workbench.action.nextEditor", { desc = "Next editor" })
map("n", "<A-[>", act "workbench.action.previousEditor", { desc = "Previous editor" })

map("n", "<A-j>", act "editor.action.moveLinesDownAction", { desc = "Move line down" })
-- Move lines (VSCode native command works on selection / line)
map("n", "<A-j>", act "editor.action.moveLinesDownAction", { desc = "Move line down" })
map("n", "<A-k>", act "editor.action.moveLinesUpAction", { desc = "Move line up" })
map("i", "<A-j>", act "editor.action.moveLinesDownAction", { desc = "Move line down" })
map("i", "<A-k>", act "editor.action.moveLinesUpAction", { desc = "Move line up" })
map("v", "<A-j>", act "editor.action.moveLinesDownAction", { desc = "Move selection down" })
map("v", "<A-k>", act "editor.action.moveLinesUpAction", { desc = "Move selection up" })

-- Zen / maximize
map("n", "<leader>zw", act "workbench.action.toggleZenMode", { desc = "Toggle zen mode" })
map("n", "<leader>zz", act "workbench.action.toggleMaximizeEditorGroup", { desc = "Maximize editor group" })

-- Easy escape
map("i", "jk", "<ESC>", { desc = "Escape insert" })

-- Hop (still useful inside the buffer)
map("n", "<leader>sc", "<cmd>HopChar2<CR>", { desc = "Hop 2 chars" })
map("n", "<leader>ss", "<cmd>HopWord<CR>", { desc = "Hop word" })
map("n", "<leader>sa", "<cmd>HopAnywhere<CR>", { desc = "Hop anywhere" })
map("n", "<leader>sl", "<cmd>HopAnywhereCurrentLine<CR>", { desc = "Hop on line" })

-- Insert datetime
map("n", "<M-t>", "<cmd>pu=strftime('%d/%m/%y %H:%M:%S')<CR>", { desc = "Insert datetime" })
map("i", "<M-t>", "<cmd>pu=strftime('%d/%m/%y %H:%M:%S')<CR>", { desc = "Insert datetime" })

-- Pickers via VSCode
map("n", "<leader><space>", act "workbench.action.quickOpen", { desc = "Quick open files" })
map("n", "<leader>,", act "workbench.action.showAllEditors", { desc = "Show open editors" })
map("n", ",.", act "workbench.action.findInFiles", { desc = "Find in files" })
map("n", "<leader>:", act "workbench.action.showCommands", { desc = "Command palette" })
map("n", "<leader>e", act "workbench.view.explorer", { desc = "File explorer" })
map("n", "<leader>ff", act "workbench.action.quickOpen", { desc = "Find files" })
map("n", "<leader>fg", act "workbench.action.quickOpenView", { desc = "Quick open view" })
map("n", "<leader>fr", act "workbench.action.openRecent", { desc = "Recent" })
map("n", "<leader>fb", act "workbench.action.showAllEditors", { desc = "Buffers" })
map("n", "<leader>sg", act "workbench.action.findInFiles", { desc = "Grep" })
map("n", "<leader>sw", act "editor.action.addSelectionToNextFindMatch", { desc = "Select word" })
map("n", "<leader>sd", act "workbench.actions.view.problems", { desc = "Diagnostics" })
map("n", "<leader>sk", act "workbench.action.openGlobalKeybindings", { desc = "Keymaps" })

-- Git
map("n", "<leader>gb", act "git.checkout", { desc = "Git branches" })
map("n", "<leader>gs", act "workbench.view.scm", { desc = "Git status (SCM view)" })
map("n", "<leader>gd", act "git.openChange", { desc = "Git diff for file" })

-- LSP via VSCode
map("n", "gd", act "editor.action.revealDefinition", { desc = "Definition" })
map("n", "gD", act "editor.action.revealDeclaration", { desc = "Declaration" })
map("n", "gr", act "editor.action.goToReferences", { desc = "References" })
map("n", "gI", act "editor.action.goToImplementation", { desc = "Implementation" })
map("n", "gy", act "editor.action.goToTypeDefinition", { desc = "Type definition" })
map("n", "K", act "editor.action.showHover", { desc = "Hover" })
map("n", "<leader>ca", act "editor.action.codeAction", { desc = "Code action" })
map("n", "<leader>rn", act "editor.action.rename", { desc = "Rename symbol" })
map("n", "<leader>ls", act "workbench.action.gotoSymbol", { desc = "Document symbols" })
map("n", "<leader>lS", act "workbench.action.showAllSymbols", { desc = "Workspace symbols" })

-- TODO comments → use VSCode todo-tree if installed, else fall back to grep
map("n", "<leader>tt", act("workbench.action.findInFiles", { query = "TODO" }), { desc = "Find TODOs" })

-- Filetype keymaps preserved (work on buffer regardless of host)
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust" },
  callback = function()
    map("i", ";;", "<ESC>A;", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "python" },
  callback = function()
    map("i", ";;", "<ESC>A", { buffer = true })
    map("i", ";'", "<ESC>o", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go" },
  callback = function()
    map("i", "z ", "<ESC>A", { buffer = true })
    map("i", ";'", "<ESC>o", { buffer = true })
    map("i", "<<", "<-", { buffer = true })
    map("i", "<C-=>", ":= ", { buffer = true })
    map("i", "<C-->", "!= ", { buffer = true })
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "tex" },
  callback = function() map("i", ";;", "<ESC>A", { buffer = true }) end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown" },
  callback = function() map("i", ";;", "<br><ESC>o", { buffer = true }) end,
})

-- Indent settings for these filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "python", "go", "c", "cpp", "sql" },
  callback = function() vim.cmd "setlocal tabstop=4 shiftwidth=4 expandtab autoindent" end,
})
