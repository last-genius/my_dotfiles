vim.api.nvim_echo({{'>^.^<'}}, false, {})

vim.g.mapleader = " "

-- Set up lazyvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Plugins left over 
-- 'milisims/nvim-luaref'
-- 'folke/lua-dev.nvim'
-- 'neoclide/coc.nvim'
-- 'jackguo380/vim-lsp-cxx-highlight'
-- 'rhysd/vim-clang-format'
-- 'vim-syntastic/syntastic'
-- 'ciaranm/securemodelines'
-- 'editorconfig/editorconfig-vim'
-- 'justinmk/vim-sneak'
-- 'andymass/vim-matchup'
-- 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
-- fzf stuff
-- 'nvim-lua/lsp_extensions.nvim'
-- 'neoclide/coc-snippets'
-- 'ray-x/lsp_signature.nvim'
--
-- 'SirVer/ultisnips'
-- 'honza/vim-snippets'
--
-- 'lervag/vimtex'
-- 'tikhomirov/vim-glsl'
-- 'cespare/vim-toml'
-- 'stephpy/vim-yaml'
-- 'godlygeek/tabular'
-- 'plasticboy/vim-markdown'


require("lazy").setup({
	"preservim/nerdcommenter",
	"scrooloose/nerdTree",
	--
	"itchyny/lightline.vim",
	-- TODO
	-- let g:lightline = {
	      --\ 'active': {
	      --\   'left': [ [ 'mode', 'paste' ],
	      --\             [ 'readonly', 'filename', 'modified' ] ],
	      --\   'right': [ [ 'lineinfo' ],
	      --\              [ 'percent' ],
	      --\              [ 'fileencoding', 'filetype' ] ],
	      --\ },
	      --\ 'component_function': {
	      --\   'filename': 'LightlineFilename'
	      --\ },
	      --\ }
	--function! LightlineFilename()
	  --return expand('%:t') !=# '' ? @% : '[No Name]'
	--endfunction

	"machakann/vim-highlightedyank",
	"airblade/vim-gitgutter",
	"arzg/vim-colors-xcode",
	"lewis6991/fileline.nvim",
	--
	"ocaml/vim-ocaml",
	'rust-lang/rust.vim'
	--
	"nvim-treesitter/nvim-treesitter",
	{
		'neovim/nvim-lspconfig',
		config = function()
			-- Setup language servers.
			local lspconfig = require('lspconfig')

			-- Bash LSP
			local configs = require 'lspconfig.configs'
			if not configs.bash_lsp and vim.fn.executable('bash-language-server') == 1 then
				configs.bash_lsp = {
					default_config = {
						cmd = { 'bash-language-server', 'start' },
						filetypes = { 'sh' },
						root_dir = require('lspconfig').util.find_git_ancestor,
						init_options = {
							settings = {
								args = {}
							}
						}
					}
				}
			end
			if configs.bash_lsp then
				lspconfig.bash_lsp.setup {}
			end

			-- Global mappings.
			-- See `:help vim.diagnostic.*` for documentation on any of the below functions
			vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
			vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
			vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
			vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist)

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd('LspAttach', {
				group = vim.api.nvim_create_augroup('UserLspConfig', {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					local opts = { buffer = ev.buf }
					vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
					vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
					vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
					vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
					vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
					vim.keymap.set('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, opts)
					vim.keymap.set('n', '<leader>wl', function()
						print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
					end, opts)
					--vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
					vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, opts)
					vim.keymap.set({ 'n', 'v' }, '<leader>a', vim.lsp.buf.code_action, opts)
					vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
					vim.keymap.set('n', '<leader>f', function()
						vim.lsp.buf.format { async = true }
					end, opts)

					local client = vim.lsp.get_client_by_id(ev.data.client_id)

					if client.server_capabilities.inlayHintProvider then
					    vim.lsp.inlay_hint(ev.buf, true)
					end

					-- Enable type inlay hints
					--autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }


					-- None of this semantics tokens business.
					-- https://www.reddit.com/r/neovim/comments/143efmd/is_it_possible_to_disable_treesitter_completely/
					client.server_capabilities.semanticTokensProvider = nil
				end,
			})
		end
	},
	{
		"hrsh7th/nvim-cmp",
		-- load cmp on InsertEnter
		event = "InsertEnter",
		-- these dependencies will only be loaded when cmp loads
		-- dependencies are always lazy-loaded unless specified otherwise
		dependencies = {
			'neovim/nvim-lspconfig',
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
		},
		config = function()
			local cmp = require'cmp'
			cmp.setup({
				snippet = {
					-- REQUIRED by nvim-cmp. get rid of it once we can
					expand = function(args)
						vim.fn["vsnip#anonymous"](args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					-- Accept currently selected item.
					-- Set `select` to `false` to only confirm explicitly selected items.
					['<CR>'] = cmp.mapping.confirm({ select = false }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
				}, {
					{ name = 'path' },
				}),
				experimental = {
					ghost_text = true,
				},
			})

			-- Enable completing paths in :
			cmp.setup.cmdline(':', {
				sources = cmp.config.sources({
					{ name = 'path' }
				})
			})
		end
	},
	-- inline function signatures
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			-- Get signatures (and _only_ signatures) when in argument lists.
			require "lsp_signature".setup(opts)
		end
	},
	{
		"nvim-treesitter/nvim-treesitter-context",
		config = function()
			require'treesitter-context'.setup({
			  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
			  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
			  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
			  line_numbers = true,
			  multiline_threshold = 20, -- Maximum number of lines to show for a single context
			  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
			  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
			  -- Separator between context and content. Should be a single character string, like '-'.
			  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
			  separator = nil,
			  zindex = 20, -- The Z-index of the context window
			  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
			})
		end
	},
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()
require('lspconfig').ocamllsp.setup {
	capabilities = capabilities
}

vim.cmd('set termguicolors')
vim.cmd('set background=dark')
vim.cmd('syntax on')
vim.cmd('hi Normal ctermbg=NONE')

-- =============================================================================
-- # autocmds
-- =============================================================================

-- Jump to last edit position on opening file
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- =============================================================================
-- # Keyboard shortcuts
-- =============================================================================
-- ; as :
vim.keymap.set('n', ';', ':')

-- Jump to start and end of line using the home row keys
vim.keymap.set('', 'H', '^')
vim.keymap.set('', 'L', '$')

-- Neat X clipboard integration
vim.keymap.set('n', '<leader>p', '"+p')
vim.keymap.set('n', '<leader>c', '"+y')

-- Left and right can switch buffers
vim.keymap.set('n', '<left>', ':bp<cr>')
vim.keymap.set('n', '<right>', ':bn<cr>')
vim.keymap.set('n', '<leader>d', ':bd<CR>')

-- Move by line
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Quick-save
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>')

-- <leader><leader> toggles between buffers
vim.keymap.set('n', '<leader><leader>', '<c-^>')

-- sane search
vim.opt.incsearch    = true
vim.opt.ignorecase   = true
vim.opt.smartcase    = true
vim.opt.gdefault     = true
-- search results centered
vim.keymap.set('n', 'n', 'nzz', { silent=true })
vim.keymap.set('n', 'N', 'Nzz', { silent=true })
vim.keymap.set('n', '*', '*zz', { silent=true })
vim.keymap.set('n', '#', '#zz', { silent=true })
vim.keymap.set('n', 'g*', 'g*zz', { silent=true })
-- better regexes escaping
vim.keymap.set('n', '?', '?\\v')
vim.keymap.set('n', '/', '/\\v')
vim.keymap.set('c', '%s/', '%sm/')

-- open new file adjacent to current file
vim.keymap.set('n', '<leader>o', ':e <C-R>=expand("%:p:h") . "/" <cr>')

-- nerdtree shortcuts
--vim.keymap.set('n', '', '')
--vim.keymap.set('n', '', '')
vim.keymap.set('n', '<C-t>', ':NERDTreeToggle<CR>')
vim.cmd('autocmd BufEnter * if tabpagenr("$") == 1 && winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree() | quit | endif')

-- =============================================================================
-- preferences
-- =============================================================================

-- persistent undo
vim.opt.undodir = '/home/andrii/.vimdid'
vim.opt.undofile = true

-- never ever folding
vim.opt.foldenable = false
vim.opt.foldmethod = 'manual'
vim.opt.foldlevelstart = 99
-- keep more context on screen while scrolling
vim.opt.scrolloff = 2
-- never show me line breaks if they're not there
vim.opt.wrap = false
-- always draw sign column. prevents buffer moving when adding/deleting sign
vim.opt.signcolumn = 'yes'
vim.opt.relativenumber = true
-- and show the absolute line number for the current line
vim.opt.number = true
-- keep current content top + left when splitting
vim.opt.splitright = true
vim.opt.splitbelow = true
-- Decent wildmenu
-- in completion, when there is more than one match,
-- list all matches, and only complete to longest common match
vim.opt.wildmode = 'list:longest'
-- when opening a file with a command (like :e),
-- don't suggest files like there:
vim.opt.wildignore = '.hg,.svn,*~,*.png,*.jpg,*.gif,*.min.js,*.swp,*.o,vendor,dist,_site'
-- tabs: go big or go home
vim.opt.shiftwidth = 8
vim.opt.softtabstop = 8
vim.opt.tabstop = 8
vim.opt.expandtab = false
-- case-insensitive search/replace
vim.opt.ignorecase = true
-- unless uppercase in search term
vim.opt.smartcase = true
-- never ever make my terminal beep
vim.opt.vb = true
-- more useful diffs (nvim -d)
--- by ignoring whitespace
vim.opt.diffopt:append('iwhite')
--- and using a smarter algorithm
--- https://vimways.org/2018/the-power-of-diff/
--- https://stackoverflow.com/questions/32365271/whats-the-difference-between-git-diff-patience-and-git-diff-histogram
--- https://luppeng.wordpress.com/2020/10/10/when-to-use-each-of-the-git-diff-algorithms/
vim.opt.diffopt:append('algorithm:histogram')
vim.opt.diffopt:append('indent-heuristic')
-- show a column at 80 characters as a guide for long lines
vim.opt.colorcolumn = '80'
--- except in Rust where the rule is 100 characters
vim.api.nvim_create_autocmd('Filetype', { pattern = 'rust', command = 'set colorcolumn=100' })
-- show more hidden characters
-- also, show tabs nicer
vim.opt.listchars = 'tab:^ ,nbsp:¬,extends:»,precedes:«,trail:•'

-- gitgutter
-- You can jump between hunks with [c and ]c.
-- You can preview, stage, and undo hunks with <leader>hp, <leader>hs,
-- and <leader>hu respectively.
vim.g.updatetime = 100
