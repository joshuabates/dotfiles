local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

-- require("luasnip/loaders/from_vscode").lazy_load()

local check_backspace = function()
	local col = vim.fn.col(".") - 1
	return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
end

local cmp_buffer = require('cmp_buffer')

local select_opts = {behavior = cmp.SelectBehavior.Select}
cmp.setup({
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	mapping = cmp.mapping.preset.insert({
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),

    ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
    ['<C-n>'] = cmp.mapping.select_next_item(select_opts),

		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({ select = false }),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif luasnip.expandable() then
				luasnip.expand()
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, {
			"i",
			"s",
		}),
	}),
  formatting = {
   format = function(entry, vim_item)
     vim_item.menu = ({
       nvim_lsp = '[L]',
       emoji    = '[E]',
       path     = '[F]',
       calc     = '[C]',
       vsnip    = '[S]',
       buffer   = '[B]',
     })[entry.source.name]
     vim_item.dup = ({
       buffer = 0,
       path = 0,
       nvim_lsp = 0,
     })[entry.source.name] or 0
     return vim_item
   end
   },
	-- formatting = {
	-- 	fields = { "kind", "abbr", "menu" },
	-- 	format = function(entry, vim_item)
	-- 		vim_item.kind = kind_icons[vim_item.kind]
	-- 		vim_item.menu = ({
	-- 			nvim_lsp = "",
	-- 			nvim_lua = "",
	-- 			luasnip = "",
	-- 			buffer = "",
	-- 			path = "",
	-- 			emoji = "",
	-- 		})[entry.source.name]
	-- 		return vim_item
	-- 	end,
	-- },
	sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    -- { name = 'vsnip' },
    { name = 'path' },
    { name = "nvim_lua" },

		{ name = "luasnip" },
	},
  sorting = {
    comparators = {
      function(...) return cmp_buffer:compare_locality(...) end,
    }
  },
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	experimental = {
		ghost_text = true,
	},
})
