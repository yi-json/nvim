local group = vim.api.nvim_create_augroup("CsesTemplates", { clear = true })

local function insert_template(args)
	local path = vim.fn.fnamemodify(args.file, ":p")
	if not path:match("/cses/") then
		return
	end

	-- only fill genuinely empty buffers (avoid clobbering existing files)
	if vim.fn.getfsize(path) > 0 then
		return
	end
	if vim.api.nvim_buf_line_count(0) > 1 or vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] ~= "" then
		return
	end

	local template = vim.fn.expand("~/.config/nvim/templates/cses.cpp")
	vim.cmd("0r " .. template)

	-- place cursor after "cin >> n;" ready for the next line
	vim.api.nvim_win_set_cursor(0, { 12, 0 })
end

-- BufNewFile: file doesn't exist on disk yet (e.g. `nvim newfile.cpp`)
-- BufReadPost: file was created empty on disk first (e.g. neo-tree "add file")
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
	group = group,
	pattern = "*.cpp",
	callback = insert_template,
})
