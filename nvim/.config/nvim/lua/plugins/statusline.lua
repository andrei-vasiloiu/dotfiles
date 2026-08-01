return {
  {
    "nvim-mini/mini.statusline",
    version = "*",
    event = "VeryLazy",

    config = function()
      require("mini.statusline").setup({
        use_icons = false,
      })
    end,
  },
}
