-- if true then return end

-- This will run last in the setup process and is a good place to configure
-- things like custom filetypes. This just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

vim.cmd "colo astrodark"
-- vim.cmd "colo catppuccin-mocha"

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "rust", "python", "go", "c", "cpp", "sql" },
  callback = function()
    vim.schedule(function() vim.cmd "set tabstop=4 shiftwidth=4 expandtab autoindent" end)
  end,
})

-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "python" },
--   callback = function()
--     vim.schedule(function() vim.cmd "set tabstop=4 shiftwidth=4 expandtab autoindent" end)
--   end,
-- })
--
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = { "go" },
--   callback = function()
--     vim.schedule(function() vim.cmd "set tabstop=4 shiftwidth=4 expandtab autoindent" end)
--   end,
-- })

if vim.g.neovide then
  -- vim.cmd "SmearCursorToggle"
  vim.g.smoothie_enabled = 0
  -- vim.g.neovide_opacity = 0.9
end
