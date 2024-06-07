local M = {}

local jobid = nil

local function is_openapi_yaml(content)
	return content:find("openapi:") and content:find("info:") and content:find("paths:")
end

local function get_open_command()
	local uname = vim.loop.os_uname().sysname
	if uname == "Darwin" then
		return "open"
	elseif uname == "Linux" then
		return "xdg-open"
	elseif uname == "Windows_NT" then
		return "start"
	else
		vim.api.nvim_err_writeln("Unsupported OS: " .. uname)
		return nil
	end
end

function M.oaspreview()
	local buf = vim.api.nvim_get_current_buf()
	local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
	local content = table.concat(lines, "\n")

	if not is_openapi_yaml(content) then
		vim.api.nvim_err_writeln("Current buffer is not a valid OpenAPI YAML.")
		return
	end

	local tmp_file = vim.fn.tempname() .. ".yaml"
	local file = io.open(tmp_file, "w")
	file:write(content)
	file:close()

	jobid = vim.fn.jobstart(string.format("redocly preview-docs %s", tmp_file), {
		stdout_buffered = true,
		stderr_buffered = true,
		on_stdout = function(_, data, _)
			if data then
				vim.api.nvim_out_write(table.concat(data, "\n") .. "\n")
				local open_command = get_open_command()
				os.execute(string.format("%s http://localhost:8080", open_command))
			end
		end,
	})
end

function M.oaspreviewstop()
	if jobid ~= nil then
		vim.fn.jobstop(jobid)
	end
end

vim.api.nvim_create_user_command("OASPreview", M.oaspreview, {})
vim.api.nvim_create_user_command("OASPreviewStop", M.oaspreviewstop, {})

return M
