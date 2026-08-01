return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,

    config = function()
      vim.diagnostic.config({
        severity_sort = true,
        underline = true,
        update_in_insert = false,
        virtual_text = false,
        signs = true,
        float = {
          border = "rounded",
          source = true,
          focusable = false,
        },
      })

      local group = vim.api.nvim_create_augroup("user_lsp", {
        clear = true,
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        group = group,

        callback = function(args)
          local client = vim.lsp.get_client_by_id(args.data.client_id)

          if client and client.name == "ruff" then
            client.server_capabilities.hoverProvider = false
          end

          local map = function(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, {
              buffer = args.buf,
              desc = desc,
            })
          end

          map("n", "gd", vim.lsp.buf.definition, "Go to definition")
          map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
          map("n", "gr", vim.lsp.buf.references, "Find references")
          map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
          map("n", "K", vim.lsp.buf.hover, "Hover documentation")

          map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
          map({ "n", "v" }, "<leader>la", vim.lsp.buf.code_action, "Code action")
          map("n", "<leader>ld", vim.diagnostic.open_float, "Show diagnostic")

          map("n", "[d", function()
            vim.diagnostic.jump({
              count = -1,
              float = true,
            })
          end, "Previous diagnostic")

          map("n", "]d", function()
            vim.diagnostic.jump({
              count = 1,
              float = true,
            })
          end, "Next diagnostic")
        end,
      })

      vim.api.nvim_create_autocmd("CursorHold", {
        group = group,

        callback = function()
          vim.diagnostic.open_float(nil, {
            scope = "cursor",
            focus = false,
          })
        end,
      })

      vim.lsp.config("tsgo", {
        cmd = {
          "pnpm",
          "exec",
          "tsgo",
          "--lsp",
          "--stdio",
        },

        filetypes = {
          "javascript",
          "javascriptreact",
          "typescript",
          "typescriptreact",
        },

        root_markers = {
          "tsconfig.json",
          "jsconfig.json",
          "package.json",
          ".git",
        },
      })

      vim.lsp.config("roslyn", {
        cmd = {
          "roslyn-language-server",
          "--stdio",
          "--autoLoadProjects",
          "--telemetryLevel",
          "off",
        },

        filetypes = { "cs" },

        root_dir = function(bufnr, on_dir)
          local root = vim.fs.root(bufnr, {
            "*.sln",
            "*.slnx",
            "*.csproj",
            "global.json",
            ".git",
          })

          on_dir(root or vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr)))
        end,
      })

      vim.lsp.enable({
        "basedpyright",
        "ruff",
        "tsgo",
        "roslyn",
      })
    end,
  },
}
