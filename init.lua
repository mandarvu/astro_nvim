-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  local result = vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
  if vim.v.shell_error ~= 0 then
    -- stylua: ignore
    vim.api.nvim_echo({ { ("Error cloning lazy.nvim:\n%s\n"):format(result), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
    vim.fn.getchar()
    vim.cmd.quit()
  end
end

vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

if vim.g.neovide then
  -- vim.o.guifont = "JetBrainsMono Nerd Font:h18:i"
  vim.o.guifont = "FiraCode Nerd Font:h17"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_cursor_vfx_mode = "railgun"
  vim.g.neovide_cursor_trail_size = 0.7
  vim.g.neovide_cursor_vfx_particle_speed = 8.0
  vim.g.neovide_cursor_vfx_particle_phase = 3
  vim.g.neovide_cursor_vfx_particle_curl = 1.3
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.0
  vim.g.neovide_scale_factor = 1
  local change_scale_factor = function(delta) vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta end
  vim.keymap.set("n", "<C-=>", function() change_scale_factor(1.1) end)
  vim.keymap.set("n", "<C-->", function() change_scale_factor(1 / 1.1) end)
  vim.keymap.set("n", "<D-s>", ":w<CR>")
  vim.keymap.set("v", "<D-c>", '"+y')
  vim.keymap.set("n", "<D-v>", '"P')
  vim.keymap.set("v", "<D-v", '"+P')
  vim.keymap.set("c", "<D-v>", "<C-R>+")
  vim.keymap.set("i", "<C-v>", '<ESC>l"+Pli')
end

vim.cmd "set clipboard=unnamedplus"
--vim.cmd "colo tokyonight"
require "lazy_setup"
require "polish"
require "snacks_keymaps"
require "keymaps"
