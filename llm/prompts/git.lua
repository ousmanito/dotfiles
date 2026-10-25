local function exec(cmd)
	return vim.system(cmd, { text = true }):wait()
end

local function run(cmd)
	local res = exec(cmd)
	assert(res.code == 0, res.stderr)
	return res.stdout
end

local function run_git(args)
	local cmd = { "git" }
	vim.list_extend(cmd, args)
	return run(cmd)
end

local function exec_git(args)
	local cmd = { "git" }
	vim.list_extend(cmd, args)
	return exec(cmd)
end

local function collect_groups()
	local out = vim.split(run_git({ "status", "--short" }), "\n", { trimempty = true })
	local groups = {}
	for _, line in ipairs(out) do
		local path = line:sub(4)
		local key = path:match("^([^/]+)/") or "[root]"
		groups[key] = groups[key] or {}
		table.insert(groups[key], path)
	end
	return groups
end

local M = {}

function M.diff()
	return run_git({ "diff", "--no-ext-diff", "--staged" })
end

function M.diff_unstaged()
	return run_git({ "diff", "--no-ext-diff" })
end

function M.add(paths)
	-- `paths` can be nil (stage everything) or an array of paths
	local args = { "add" }
	if paths then
		vim.list_extend(args, paths)
	end
	return run_git(args)
end

function M.stage_group()
	local groups = collect_groups()
	if vim.tbl_isempty(groups) then
		return "Nothing to stage."
	end

	local menu, lookup, i = { "Pick a group to stage:" }, {}, 1
	for name, files in pairs(groups) do
		table.insert(menu, string.format("%d. %s (%d files)", i, name, #files))
		lookup[i] = { name = name, files = files }
		i = i + 1
	end
	table.insert(menu, "0. Cancel")

	local choice = vim.fn.inputlist(menu)
	if choice <= 0 or not lookup[choice] then
		return "Staging cancelled."
	end

	local selection = lookup[choice]
	local args = { "add" }
	vim.list_extend(args, selection.files)
	run_git(args)
	return string.format("Staged %s:\n- %s", selection.name, table.concat(selection.files, "\n- "))
end

function M.commit(message)
	-- `message` is optional; if nil, Git opens the editor as usual
	local args = { "commit" }
	if message then
		vim.list_extend(args, { "-m", message })
	end
	local result = exec_git(args)
	if result.code ~= 0 then
		return nil, result.stderr
	end
	return result.stdout
end

function M.latest_tag()
	local res = exec_git({ "describe", "--tags", "--abbrev=0" })
	return res.code == 0 and vim.trim(res.stdout) or "v0.0.0"
end

function M.log_since_latest()
	local tag = M.latest_tag()
	local res = exec_git({ "log", tag .. "..HEAD", "--oneline" })
	return res.stdout ~= "" and res.stdout or "No commits since " .. tag
end

return M
