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
