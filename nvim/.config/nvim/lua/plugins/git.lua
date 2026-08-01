return {
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },

    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "?" },
      },

      current_line_blame = false,

      on_attach = function(buffer)
        local gs = package.loaded.gitsigns
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, {
            buffer = buffer,
            desc = desc,
          })
        end

        map("n", "]c", function()
          if vim.wo.diff then
            return "]c"
          end

          vim.schedule(gs.next_hunk)
          return "<Ignore>"
        end, "Next Git hunk")

        map("n", "[c", function()
          if vim.wo.diff then
            return "[c"
          end

          vim.schedule(gs.prev_hunk)
          return "<Ignore>"
        end, "Previous Git hunk")

        map("n", "<leader>gp", gs.preview_hunk, "Preview Git hunk")
        map("n", "<leader>gs", gs.stage_hunk, "Stage Git hunk")
        map("n", "<leader>gr", gs.reset_hunk, "Reset Git hunk")
        map("n", "<leader>gB", gs.blame_line, "Blame current line")
        map("n", "<leader>gd", gs.diffthis, "Diff current file")
        map("v", "<leader>gs", function()
          gs.stage_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "Stage selected Git hunk")

        map("v", "<leader>gr", function()
          gs.reset_hunk({
            vim.fn.line("."),
            vim.fn.line("v"),
          })
        end, "Reset selected Git hunk")
      end,
    },
  },
}
