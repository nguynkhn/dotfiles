local autocmd = vim.api.nvim_create_autocmd
local augroup = function (group)
  return vim.api.nvim_create_augroup(group, { clear = true })
end

autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function ()
    vim.highlight.on_yank({ timeout = 500 })
  end,
})

autocmd("BufWritePre", {
  group = augroup("auto_create_dir"),
  callback = function (event)
    if event.match:match("^%w%w+://") then
      return
    end
    local file = vim.loop.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

autocmd("BufWritePre", {
  group = augroup("trim_whitespace"),
  command = ":%s/\\s\\+$//e",
})

autocmd("ModeChanged", {
	pattern = "*",
	group = augroup("luasnip_extra"),
	callback = function ()
		local luasnip = require("luasnip")
		local buf = vim.api.nvim_get_current_buf()
		if ((vim.v.event.old_mode == "s" and vim.v.event.new_mode == "n")	or vim.v.event.old_mode == "i")	and luasnip.session.current_nodes[buf] and not luasnip.session.jump_active then
			luasnip.unlink_current()
		end
	end
})

autocmd("LspAttach", {
	group = augroup("lspconfig_extra"),
	callback = function (ev)
		vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
		local opts = { buffer = ev.buf }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
		vim.keymap.set({ "i", "v", "n" }, "<C-k>", vim.lsp.buf.signature_help, opts)
		vim.keymap.set("n", "<space>wa", vim.lsp.buf.add_workspace_folder, opts)
		vim.keymap.set("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, opts)
		vim.keymap.set("n", "<space>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, opts)
		vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, opts)
		vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
		vim.keymap.set({ "n", "v" }, "<space>ca", vim.lsp.buf.code_action, opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
		vim.keymap.set("n", "<space>f", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})
