vim.lsp.enable('ts_ls')

vim.diagnostic.config{
	virtual_lines = { current_line = true }
}

-- don't show diagnostics while I'm making changes
vim.api.nvim_create_augroup('dev', { clear = true })
vim.api.nvim_create_autocmd('BufModifiedSet', {
	group = 'dev',
	callback = function(ev)
		vim.diagnostic.enable(not vim.bo.modified)
	end
})

vim.keymap.set('n', 'gsb', ':Gitsigns blame<CR>')
vim.keymap.set('n', 'gsq', ':Gitsigns setqflist all<CR>')
vim.keymap.set('n', 'gsd', ':Gitsigns diffthis<CR>')
vim.keymap.set('n', 'gsp', ':Gitsigns preview_hunk<CR>')
vim.keymap.set('n', 'gss', ':Gitsigns stage_hunk<CR>')
vim.keymap.set('n', 'gsu', ':Gitsigns undo_stage_hunk<CR>')
vim.keymap.set('n', 'gsr', ':Gitsigns reset_hunk<CR>')
vim.keymap.set('n', ']g',  ':Gitsigns nav_hunk next<CR>')
vim.keymap.set('n', '[g',  ':Gitsigns nav_hunk prev<CR>')
