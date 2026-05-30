return {
  "milanglacier/minuet-ai.nvim",
  event = "InsertEnter",
  enabled = true,
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    provider = "openai_fim_compatible",
    n_completions = 1,
    context_window = 512,
    request_timeout = 30,
    throttle = 400,
    debounce = 200,
    virtualtext = {
      auto_trigger_ft = { "rust", "lua", "python", "javascript", "typescript", "go", "c", "cpp", "sh" },
      keymap = {
        accept = "<A-y>",
        accept_line = "<A-a>",
        accept_word = "<A-w>",
        dismiss = "<A-e>",
      },
    },
    provider_options = {
      openai_fim_compatible = {
        api_key = "TERM",
        name = "Ollama",
        end_point = "http://127.0.0.1:11434/v1/completions",
        model = "qwen2.5-coder:1.5b-base",
        stream = true,
        template = {
          prompt = function(prefix, suffix)
            return "<|fim_prefix|>" .. prefix .. "<|fim_suffix|>" .. suffix .. "<|fim_middle|>"
          end,
          suffix = false,
        },
        optional = {
          max_tokens = 128,
          top_p = 0.9,
          stop = { "<|fim_pad|>", "<|endoftext|>", "<|repo_name|>", "<|file_sep|>", "<|im_end|>" },
        },
      },
    },
  },
}
