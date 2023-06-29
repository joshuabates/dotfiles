local Format = {}

---@type PluginLspOpts
Format.opts = nil

function Format.enabled()
	return Format.opts.autoformat
end

function Format.toggle()
	if vim.b.autoformat == false then
		vim.b.autoformat = nil
		Format.opts.autoformat = true
	else
		Format.opts.autoformat = not Format.opts.autoformat
	end
	-- if Format.opts.autoformat then
	--   Util.info("Enabled format on save", { title = "Format" })
	-- else
	--   Util.warn("Disabled format on save", { title = "Format" })
	-- end
end

---@param opts? {force?:boolean}
function Format.format(opts)
	local buf = vim.api.nvim_get_current_buf()
	if vim.b.autoformat == false and not (opts and opts.force) then
		return
	end

	local formatters = Format.get_formatters(buf)
	local client_ids = vim.tbl_map(function(client)
		return client.id
	end, formatters.active)

	if #client_ids == 0 then
		return
	end

	if Format.opts.format_notify then
		Format.notify(formatters)
	end

	vim.lsp.buf.format(vim.tbl_deep_extend("force", {
		bufnr = buf,
		filter = function(client)
			return vim.tbl_contains(client_ids, client.id)
		end,
	}, {}))
end

---@param formatters LazyVimFormatters
function Format.notify(formatters)
	local lines = { "# Active:" }

	for _, client in ipairs(formatters.active) do
		local line = "- **" .. client.name .. "**"
		if client.name == "null-ls" then
			line = line
				.. " ("
				.. table.concat(
					vim.tbl_map(function(f)
						return "`" .. f.name .. "`"
					end, formatters.null_ls),
					", "
				)
				.. ")"
		end
		table.insert(lines, line)
	end

	if #formatters.available > 0 then
		table.insert(lines, "")
		table.insert(lines, "# Disabled:")
		for _, client in ipairs(formatters.available) do
			table.insert(lines, "- **" .. client.name .. "**")
		end
	end

	vim.notify(table.concat(lines, "\n"), vim.log.levels.INFO, {
		title = "Formatting",
		on_open = function(win)
			vim.api.nvim_win_set_option(win, "conceallevel", 3)
			vim.api.nvim_win_set_option(win, "spell", false)
			local buf = vim.api.nvim_win_get_buf(win)
			vim.treesitter.start(buf, "markdown")
		end,
	})
end

-- Gets all lsp clients that support formatting.
-- When a null-ls formatter is available for the current filetype,
-- only null-ls formatters are returned.
function Format.get_formatters(bufnr)
	local ft = vim.bo[bufnr].filetype
	-- check if we have any null-ls formatters for the current filetype
	local null_ls = package.loaded["null-ls"] and require("null-ls.sources").get_available(ft, "NULL_LS_FORMATTING")
		or {}

	---@class LazyVimFormatters
	local ret = {
		---@type lsp.Client[]
		active = {},
		---@type lsp.Client[]
		available = {},
		null_ls = null_ls,
	}

	---@type lsp.Client[]
	local clients = vim.lsp.get_active_clients({ bufnr = bufnr })
	for _, client in ipairs(clients) do
		if Format.supports_format(client) then
			if (#null_ls > 0 and client.name == "null-ls") or #null_ls == 0 then
				table.insert(ret.active, client)
			else
				table.insert(ret.available, client)
			end
		end
	end

	return ret
end

-- Gets all lsp clients that support formatting
-- and have not disabled it in their client config
---@param client lsp.Client
function Format.supports_format(client)
	if
		client.config
		and client.config.capabilities
		and client.config.capabilities.documentFormattingProvider == false
	then
		return false
	end
	return client.supports_method("textDocument/formatting") or client.supports_method("textDocument/rangeFormatting")
end

---@param opts PluginLspOpts
function Format.setup(opts)
	Format.opts = opts
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = vim.api.nvim_create_augroup("LazyVimFormat", {}),
		callback = function()
			if Format.opts.autoformat then
				Format.format()
			end
		end,
	})
end

local function on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			on_attach(client, buffer)
		end,
	})
end

-- function M.diagnostic_goto(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
--
-- return M

local function setup_lsp_keymaps(bufnr)
	local opts = { noremap = true, silent = true }
	local keymap = vim.api.nvim_buf_set_keymap
	keymap(bufnr, "n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	keymap(bufnr, "n", "gI", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	keymap(bufnr, "n", "gx", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)

	keymap(bufnr, "n", "<leader>ld", "<cmd>lua _G.toggle_diagnostics()<CR>", opts)
	keymap(bufnr, "n", "<leader>lf", "<cmd>lua vim.lsp.buf.formatting()<cr>", opts)
	keymap(bufnr, "n", "<leader>li", "<cmd>LspInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>lI", "<cmd>LspInstallInfo<cr>", opts)
	keymap(bufnr, "n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
	keymap(bufnr, "n", "<leader>lj", "<cmd>lua vim.diagnostic.goto_next({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lk", "<cmd>lua vim.diagnostic.goto_prev({buffer=0})<cr>", opts)
	keymap(bufnr, "n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
	keymap(bufnr, "n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	keymap(bufnr, "n", "<leader>lq", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)
	--   { "<leader>cd", vim.diagnostic.open_float, desc = "Line Diagnostics" },
	--   { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
	--   { "gd", "<cmd>Telescope lsp_definitions<cr>", desc = "Goto Definition", has = "definition" },
	--   { "gr", "<cmd>Telescope lsp_references<cr>", desc = "References" },
	--   { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration" },
	--   { "gI", "<cmd>Telescope lsp_implementations<cr>", desc = "Goto Implementation" },
	--   { "gy", "<cmd>Telescope lsp_type_definitions<cr>", desc = "Goto T[y]pe Definition" },
	--   { "K", vim.lsp.buf.hover, desc = "Hover" },
	--   { "gK", vim.lsp.buf.signature_help, desc = "Signature Help", has = "signatureHelp" },
	--   { "<c-k>", vim.lsp.buf.signature_help, mode = "i", desc = "Signature Help", has = "signatureHelp" },
	--   { "]d", M.diagnostic_goto(true), desc = "Next Diagnostic" },
	--   { "[d", M.diagnostic_goto(false), desc = "Prev Diagnostic" },
	--   { "]e", M.diagnostic_goto(true, "ERROR"), desc = "Next Error" },
	--   { "[e", M.diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
	--   { "]w", M.diagnostic_goto(true, "WARN"), desc = "Next Warning" },
	--   { "[w", M.diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
	--   { "<leader>cf", format, desc = "Format Document", has = "documentFormatting" },
	--   { "<leader>cf", format, desc = "Format Range", mode = "v", has = "documentRangeFormatting" },
	--   { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" }, has = "codeAction" },
	--   {
	--     "<leader>cA",
	--     function()
	--       vim.lsp.buf.code_action({
	--         context = {
	--           only = {
	--             "source",
	--           },
	--           diagnostics = {},
	--         },
	--       })
	--     end,
	--     desc = "Source Action",
	--     has = "codeAction",
	--   }
	-- }
	-- if require("lazyvim.util").has("inc-rename.nvim") then
	--   M._keys[#M._keys + 1] = {
	--     "<leader>cr",
	--     function()
	--       local inc_rename = require("inc_rename")
	--       return ":" .. inc_rename.config.cmd_name .. " " .. vim.fn.expand("<cword>")
	--     end,
	--     expr = true,
	--     desc = "Rename",
	--     has = "rename",
	--   }
	-- else
	--   M._keys[#M._keys + 1] = { "<leader>cr", vim.lsp.buf.rename, desc = "Rename", has = "rename" }
	-- end
	-- nnoremap <silent> <C-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
	-- nnoremap <silent> K <cmd>lua vim.lsp.buf.hover()<CR>
	-- nnoremap <silent> gi <cmd>lua vim.lsp.buf.implementation()<CR>
end

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			{ "folke/neoconf.nvim", cmd = "Neoconf", config = true },
			{ "folke/neodev.nvim", opts = {} },
			"mason.nvim",
			{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } },
			"hrsh7th/cmp-nvim-lsp",
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = {
					spacing = 4,
					source = "if_many",
					prefix = "●",
					-- this will set set the prefix to a function that returns the diagnostics icon based on the severity
					-- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
					-- prefix = "icons",
				},
				severity_sort = true,
			},
			-- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
			-- Be aware that you also will need to properly configure your LSP server to
			-- provide the inlay hints.
			inlay_hints = {
				enabled = false,
			},
			-- add any global capabilities here
			capabilities = {},
			-- Automatically format on save
			autoformat = true,
			-- Enable this to show formatters used in a notification
			-- Useful for debugging formatter issues
			format_notify = false,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			---@type lspconfig.options
			servers = {
				jsonls = {},
				solargraph = {},
				cssls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = {
								checkThirdParty = false,
							},
							completion = {
								callSnippet = "Replace",
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			-- setup autoformat
			Format.setup(opts)
			--
			-- setup formatting and keymaps
			on_attach(function(client, buffer)
				setup_lsp_keymaps(buffer)
			end)

			-- diagnostics
			-- for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
			--   name = "DiagnosticSign" .. name
			--   vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			-- end

			if opts.inlay_hints.enabled and vim.lsp.buf.inlay_hint then
				on_attach(function(client, buffer)
					if client.server_capabilities.inlayHintProvider then
						vim.lsp.buf.inlay_hint(buffer, true)
					end
				end)
			end

			-- if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
			--   opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
			--     or function(diagnostic)
			--       local icons = require("lazyvim.config").icons.diagnostics
			--       for d, icon in pairs(icons) do
			--         if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
			--           return icon
			--         end
			--       end
			--     end
			-- end

			vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

			local servers = opts.servers
			local capabilities = vim.tbl_deep_extend(
				"force",
				{},
				vim.lsp.protocol.make_client_capabilities(),
				require("cmp_nvim_lsp").default_capabilities(),
				opts.capabilities or {}
			)

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			-- get all the servers that are available thourgh mason-lspconfig
			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local all_mslp_servers = {}
			if have_mason then
				all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
			end

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
			end

			-- if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
			--   local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
			--   Util.lsp_disable("tsserver", is_deno)
			--   Util.lsp_disable("denols", function(root_dir)
			--     return not is_deno(root_dir)
			--   end)
			-- end
		end,
	},
	{
		"pmizio/typescript-tools.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
		opts = {},
	},

	-- formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				root_dir = require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git"),
				sources = {
					nls.builtins.formatting.fish_indent,
					nls.builtins.diagnostics.fish,
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.shfmt,
					-- nls.builtins.diagnostics.flake8,
				},
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = {
			ensure_installed = {
				"stylua",
				"shfmt",
				-- "flake8",
			},
		},
		---@param opts MasonSettings | {ensure_installed: string[]}
		config = function(_, opts)
			require("mason").setup(opts)
			local mr = require("mason-registry")
			local function ensure_installed()
				for _, tool in ipairs(opts.ensure_installed) do
					local p = mr.get_package(tool)
					if not p:is_installed() then
						p:install()
					end
				end
			end
			if mr.refresh then
				mr.refresh(ensure_installed)
			else
				ensure_installed()
			end
		end,
	},
}
