-- if true then return {} end

local config = {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.config
  opts = {},

  keys = {
    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash With Treesitter" },
    { "<leader>sr", mode = { "n", "x", "o" }, function() require("flash").remote() end, desc = "Remote Flash" },
    { "<leader>sR", mode = { "n", "x", "o" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<M-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash search" },
  },
}

return config
