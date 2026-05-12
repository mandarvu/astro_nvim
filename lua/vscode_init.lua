-- Minimal config for use under vscode-neovim extension.
-- VSCode handles UI: file explorer, pickers, statusline, LSP, completions, diagnostics.
-- Only buffer-editing plugins loaded here.

vim.g.mapleader = " "
vim.g.maplocalleader = ","
vim.opt.clipboard = "unnamedplus"
vim.opt.ignorecase = true
vim.opt.smartcase = true

local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy-vscode/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  local result = vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  }
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" } }, true, {})
    return
  end
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  {
    "kylechui/nvim-surround",
    version = "^4.0.0",
    event = "VeryLazy",
    config = function() require("nvim-surround").setup {} end,
  },
  { "tpope/vim-repeat", event = "VeryLazy" },
  {
    "monaqa/dial.nvim",
    keys = { "<C-a>", "<C-x>", { "<C-a>", mode = "v" }, { "<C-x>", mode = "v" } },
  },
  {
    "smoka7/hop.nvim",
    version = "*",
    cmd = { "HopWord", "HopChar2", "HopAnywhere", "HopAnywhereCurrentLine", "HopAnywhereMW" },
    opts = { keys = "etovxqpdygfblzhckisuran" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "modern",
      delay = 300,
      icons = { mappings = false },
      win = { border = "single" },
    },
  },
}, {
  root = vim.fn.stdpath "data" .. "/lazy-vscode",
  lockfile = vim.fn.stdpath "config" .. "/lazy-lock-vscode.json",
  ui = { backdrop = 100 },
  install = { colorscheme = { "habamax" } },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "zipPlugin",
        "matchit",
        "matchparen",
      },
    },
  },
})

require "vscode_keymaps"
