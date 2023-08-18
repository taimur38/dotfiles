-- Plugins

local packer = require("packer")
local util = require("packer.util")
packer.init({
        package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

packer.startup(function() 

    use "wbthomason/packer.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate'
    }

    use {
        'folke/tokyonight.nvim'
    }
    use "shaunsingh/solarized.nvim"
    use "arcticicestudio/nord-vim"
    use "ellisonleao/gruvbox.nvim"

    use {
        'kyazdani42/nvim-tree.lua',
        requires = 'kyazdani42/nvim-web-devicons'
    }

    use 'ggandor/lightspeed.nvim'

    use 'mhartington/formatter.nvim'

    use {
        'nvim-telescope/telescope.nvim',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {'hrsh7th/cmp-buffer' }
    }

    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip'

    use 'windwp/windline.nvim'

    use 'junegunn/goyo.vim'
    use 'jalvesaq/Nvim-R'

    -- use 'github/copilot.vim'
    use { 
        "zbirenbaum/copilot.lua",
        cmd = "Copilot",
        event = "InsertEnter",
        config = function() 
            require("copilot").setup({})
        end,
    }


end)

local map = vim.api.nvim_set_keymap
local default_opts = {noremap = true, silent = true}

-- Appearance 
vim.o.number = true
vim.o.numberwidth = 1
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.shiftround = true
vim.o.mouse = "a"
vim.o.foldlevel = 99
vim.o.foldmethod = "indent"
vim.o.foldenable = true
vim.o.termguicolors = false
vim.o.signcolumn = "yes"
vim.o.relativenumber = true
vim.o.splitbelow = true
vim.o.splitright = true

-- Theme
vim.g.tokyonight_style = "night"
vim.cmd[[colorscheme gruvbox]]

local change_theme_mode = function(thm)
    vim.g.tokyonight_style = thm
    -- vim.cmd[[colorscheme nord]]
    vim.cmd[[colorscheme tokyonight-day]]
    local upper_thm = thm:gsub("^%l", string.upper)
    os.execute("alacritty-themes Tokyonight_"..upper_thm)
end

vim.api.nvim_create_user_command(
	'Darkmode',
	function()
        -- change_theme_mode("night")
        vim.g.tokyonight_style = "night"
        os.execute("alacritty-themes Nord")
        vim.cmd[[colorscheme nord]]
    end,
    {}
)

vim.api.nvim_create_user_command(
	'Lightmode',
	function() 
        change_theme_mode("day")
    end,
    {}
)

map("n", "<esc>", ":nohlsearch<CR>", default_opts)

-- Treesitter
require('nvim-treesitter.configs').setup{ 
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    }
}

-- Tree
require('nvim-tree').setup {
    filters = {
        custom = {".git", "node_modules", ".build", ".vscode", "__pycache__"},
    },
    git = {
        ignore = true
    }
}
map('n', '<C-n>', ':NvimTreeToggle<CR>', default_opts)
map('n', '<C-j>', ':NvimTreeFindFile<CR>', default_opts)

-- Airline
require('wlsample.airline')

-- Nvim-R
map('n', '<C-]>', '<Plug>RDSendSelection', default_opts)
map('v', '<C-]>', '<Plug>RDSendSelection', default_opts)

vim.g.R_assign = false
vim.g.R_csv_app = 'terminal:vd'
vim.g.R_openpdf = 1
vim.g.R_auto_start = 2
vim.g.R_hl_term = 0
vim.g.r_syntax_folding = 1

-- Telescope
map("n", "<C-p>", "<cmd>Telescope find_files<CR>", default_opts)
map("n", "<C-t>", "<cmd>Telescope<CR>", default_opts)
map("n", "<C-f>", "<cmd>Telescope live_grep<CR>", default_opts)

require("telescope").setup{
    defaults = {
        file_ignore_patterns = { "yarn.lock" },

        mappings = {
            i = {
                ["<C-k>"] = "move_selection_previous",
                ["<C-j>"] = "move_selection_next"
            }
        }
    }
}

-- Formatter
local formatter_prettier = {
    function() 
        return {
            exe = "prettierd",
            args = {vim.api.nvim_buf_get_name(0)},
            stdin = true
        }
    end
}

require('formatter').setup({
    logging = false,
    filetype = {
        javascript = formatter_prettier,
        javascriptreact = formatter_prettier,
        typescript = formatter_prettier,
        typescriptreact = formatter_prettier,
        json = formatter_prettier,
    }
})

vim.api.nvim_exec([[
augroup FormatAutogroup 
    autocmd!
    autocmd BufWritePost *.ts,*.tsx,*.mjs,*.js,*.jsx,*.json,*.graphql FormatWrite
augroup END
]], true)

vim.api.nvim_command("autocmd BufWritePre *.ex,*.go lua vim.lsp.buf.formatting()")

-- Cmp
local cmp  = require('cmp')
cmp.setup({
    snippet = {
      expand = function(args)
        -- For `luasnip` user.
        require('luasnip').lsp_expand(args.body)
      end,
    },
    mapping = {
      ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
      ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
      ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
      ['<C-d>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.close(),
      ['<CR>'] = cmp.mapping.confirm({
        behavior = cmp.ConfirmBehavior.Replace,
        select = true,
      }),
      ['<Tab>'] = cmp.mapping.select_next_item({ behaviour = cmp.SelectBehavior.Insert }),
      ['<S-Tab>'] = cmp.mapping.select_prev_item({ behaviour = cmp.SelectBehavior.Insert })
    },
    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' },
      { name = 'buffer' },
    }
  })


vim.api.nvim_command("autocmd FileType markdown lua require('cmp').setup.buffer { enabled = false }")
