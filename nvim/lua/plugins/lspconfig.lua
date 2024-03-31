local servers = { "pyright", "tsserver", "cssls", "html", "emmet_language_server" }
local lsp_setup = function ()
	local lspconfig = require("lspconfig")
	local capabilities = require("cmp_nvim_lsp").default_capabilities()
	for _, server in pairs(servers) do
		lspconfig[server].setup({ capabilities = capabilities })
  end
	lspconfig.clangd.setup({
		cmd = { "clangd", "-header-insertion=never", "--background-index" },
		capabilities = capabilities,
	})
	local lua_setiings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	}
	lspconfig.lua_ls.setup({
		on_init = function(client)
			local path = client.workspace_folders[1].name
			if not vim.loop.fs_stat(path .. "/.luarc.json") and not vim.loop.fs_stat(path .. "/.luarc.jsonc") then
				client.config.settings = vim.tbl_deep_extend("force", client.config.settings, lua_setiings)
			client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
			end
			return true
		end,
		capabilities = capabilities,
	})
end

return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function ()
      require("mason").setup()
      require("mason-lspconfig").setup()
      lsp_setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lsp-signature-help",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-d>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.close(),
        ["<CR>"] = cmp.mapping.confirm({
          select = true,
        }),
        ["<Tab>"] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else fallback() end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else fallback() end
        end, { "i", "s" })
      })
      cmp.setup({
        snippet = {
          expand = function (args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = mapping,
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "nvim_lsp_signature_help" }
        }, { { name = "buffer" } }),
      })
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" },
        }, {
          { name = "buffer" },
        })
      })
      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } }
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" }
        }, {
          { name = "cmdline" }
        }),
        matching = { disallow_symbol_nonprefix_matching = false }
      })
      local cmp_autopairs =
        require("nvim-autopairs.completion.cmp")
      cmp.event:on(
        "confirm_done",
        cmp_autopairs.on_confirm_done()
      )
    end
  },
}
