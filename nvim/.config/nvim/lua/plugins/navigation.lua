return {
  {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    keys = {
      { "<leader>ff", "<cmd>FzfLua files<CR>", desc = "Find files" },
      { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
      { "<leader>fb", "<cmd>FzfLua buffers<CR>", desc = "Buffers" },
      { "<leader>fr", "<cmd>FzfLua oldfiles<CR>", desc = "Recent files" },
      { "<leader>fh", "<cmd>FzfLua helptags<CR>", desc = "Help" },
      { "<leader>fk", "<cmd>FzfLua keymaps<CR>", desc = "Keymaps" },
      { "<leader>fd", "<cmd>FzfLua diagnostics_document<CR>", desc = "Diagnostics" },
    },

    opts = {
      { "fzf-native" },
      fzf_colors = true,
      winopts = {
        height = 0.85,
        width = 0.90,
        preview = {
          layout = "flex",
        },
      },
    },
  },
}
