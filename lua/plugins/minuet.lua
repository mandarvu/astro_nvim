return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  enabled = vim.fn.executable "ollama" == 1,
  dependencies = { "nvim-lua/plenary.nvim" },
  keys = {
    { "<Leader>uM", "<Cmd>Minuet virtualtext toggle<CR>", desc = "Toggle Minuet inline suggestions" },
  },
  config = function(_, opts)
    require("minuet").setup(opts)

    local filetypes = opts.virtualtext and opts.virtualtext.auto_trigger_ft or {}
    if vim.tbl_contains(filetypes, "*") or vim.tbl_contains(filetypes, vim.bo.filetype) then
      vim.b.minuet_virtual_text_auto_trigger = true
    end
  end,
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 1024,
    request_timeout = 30,
    throttle = 750,
    debounce = 300,
    virtualtext = {
      auto_trigger_ft = { "rust", "lua", "python", "javascript", "typescript", "go", "c", "cpp", "sh" },
      show_on_completion_menu = true,
      keymap = {
        accept = "<A-o>",
        accept_line = "<A-i>",
        dismiss = "<A-e>",
      },
    },
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM",
        name = "Ollama",
        end_point = "http://127.0.0.1:11434/v1/completions",
        model = "qwen2.5-coder:7b-base",
        stream = false,
        template = {
          prompt = function(prefix, suffix)
            return "<|fim_prefix|>" .. prefix .. "<|fim_suffix|>" .. suffix .. "<|fim_middle|>"
          end,
          suffix = false,
        },
        optional = {
          max_tokens = 96,
          temperature = 0.1,
          top_p = 0.8,
          stop = { "<|fim_pad|>", "<|endoftext|>", "<|repo_name|>", "<|file_sep|>", "<|im_end|>" },
        },
      },
    },
  },
}
