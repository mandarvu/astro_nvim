-- Uncomment the following line to diable the plugin
-- if true then return {} end

local config = {}

config = {
  "linux-cultist/venv-selector.nvim",
  lazy = false,
  enabled = vim.fn.executable "fd" == 1 or vim.fn.executable "fdfind" == 1 or vim.fn.executable "fd-find" == 1,
  dependencies = {
    {
      "AstroNvim/astrocore",
      opts = {
        mappings = {
          n = {
            ["<Leader>lv"] = { "<Cmd>VenvSelect<CR>", desc = "Select VirtualEnv" },
          },
        },
      },
    },
  },
  opts = {},
  cmd = "VenvSelect",
}

return config
