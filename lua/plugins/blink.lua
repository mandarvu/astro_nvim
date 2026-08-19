return {
  "saghen/blink.cmp",
  opts = function(_, opts)
    opts.keymap = opts.keymap or {}
    opts.keymap["<Tab>"] = {
      "select_next",
      "snippet_forward",
      function(cmp)
        if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    }
    opts.keymap["<S-Tab>"] = {
      "select_prev",
      "snippet_backward",
      function(cmp)
        if vim.api.nvim_get_mode().mode == "c" then return cmp.show() end
      end,
      "fallback",
    }
    opts.keymap["<CR>"] = { "accept", "fallback" }
  end,
}
