return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          ["<Leader>r"] = { "<cmd>AstroReload<cr>", desc = "Reload window" },
          -- toggle term
          -- https://github.dev/AstroNvim/AstroNvim > lua > astronvim > plugins > toggleterm.lua
          ["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
          ["<Leader>fl"] = {
            function() require("telescope").extensions.live_grep_args.live_grep_args() end,
            desc = "Live grep args",
          },
        },
        t = {
          -- toggle term
          ["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
          ["<C-q>"] = { "<C-\\><C-n>", desc = "escape when in terminal" },
        },
        i = {
          -- toggle term
          ["<C-'>"] = { '<Cmd>execute v:count . "ToggleTerm"<CR>', desc = "Toggle terminal" },
        },
      },
    },
  },
  -- to disable tsserver formatting
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local lspconfig = require "lspconfig"
      require("mason-lspconfig").setup_handlers {
        tsserver = function()
          lspconfig.tsserver.setup {
            on_attach = function(client, bufnr)
              client.server_capabilities.documentFormattingProvider = false
              client.server_capabilities.documentRangeFormattingProvider = false
            end,
          }
        end,
      }
    end,
  },
  {
    "AstroNvim/astrolsp",
    ---@type AstroLSPOpts
    opts = {
      mappings = {
        n = {
          -- this mapping will only be set in buffers with an LSP attached
          K = {
            function() vim.lsp.buf.hover() end,
            desc = "Hover symbol details",
          },
          -- condition for only server with declaration capabilities
          gD = {
            function() vim.lsp.buf.declaration() end,
            desc = "Declaration of current symbol",
            cond = "textDocument/declaration",
          },
        },
      },
    },
  },
}
