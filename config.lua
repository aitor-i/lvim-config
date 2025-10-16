-- General LunarVim Configurations
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "lunar"
lvim.use_icons = true
vim.opt.relativenumber = true
vim.opt.number = true

-- Customize SpellBad highlight group to have a blue undercurl
vim.cmd([[
  augroup SpellBadHighlight
    autocmd!
    autocmd ColorScheme * highlight clear SpellBad | highlight SpellBad gui=undercurl guisp=#0000FF guifg=NONE guibg=NONE
  augroup END
]])

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact" },
  },
}

-- Set Leader Key
lvim.leader = " "
vim.g.mapleader = " "

-- Treesitter Configurations
lvim.builtin.treesitter.ensure_installed = {
  "bash", "c", "javascript", "json", "lua", "python",
  "typescript", "tsx", "css", "rust", "java", "yaml",
}
lvim.builtin.treesitter.highlight.enable = true
lvim.builtin.treesitter.autotag.enable = true

-- Plugin Configurations
lvim.plugins = {
  'ThePrimeagen/harpoon',
  'mbbill/undotree',
  'jose-elias-alvarez/null-ls.nvim',
  'jparise/vim-graphql',
  'kdheepak/lazygit.nvim',
  'onsails/lspkind-nvim',
  {
    "supermaven-inc/supermaven-nvim",
    config = function()
      require("supermaven-nvim").setup({
        keymaps = {
          accept_suggestion = "<Tab>",
          clear_suggestion = "<C-]>",
          accept_word = "<C-j>",
        },
        ignore_filetypes = { "cpp" }, -- Ignore Supermaven in C++ files
        color = {
          suggestion_color = "#A9A9A9",
          cterm = 244,
        },
        log_level = "info",                -- Set to "off" to disable logging
        disable_inline_completion = false, -- For use with nvim-cmp
        disable_keymaps = true,            -- Set to true if you want to define your own keymaps
        condition = function()
          return false                     -- Return true to disable Supermaven under certain conditions
        end,
      })
    end,
  },
  {
    'f-person/git-blame.nvim',
    config = function()
      vim.g.gitblame_enabled = 0 -- Start with git blame disabled
    end,
  },
  {
    "editorconfig/editorconfig-vim",
    config = function()
      -- No additional configuration is necessary
    end,
  },
}
-- Add Supermaven to cmp sources
table.insert(lvim.builtin.cmp.sources, { name = "supermaven" })


-- Custom function to accept Supermaven suggestion with Ctrl + b
function _G.supermaven_accept_suggestion()
  local suggestion = require('supermaven-nvim.completion_preview')
  if suggestion and suggestion.has_suggestion and suggestion.has_suggestion() then
    vim.schedule(function()
      suggestion.on_accept_suggestion()
    end)
    return ''
  else
    return '<C-b>' -- Or '' if you prefer no action
  end
end

-- Map Ctrl + b in insert mode to accept Supermaven suggestion
vim.api.nvim_set_keymap('i', '<C-b>', 'v:lua.supermaven_accept_suggestion()', { expr = true, noremap = true })


local lspkind = require("lspkind")
lspkind.init({
  symbol_map = {
    Supermaven = "",
  },
})

-- Set the highlight color for Supermaven suggestions
vim.api.nvim_set_hl(0, "CmpItemKindSupermaven", { fg = "#6CC644" })

-- Define custom key mappings for Supermaven
local opts = { expr = true, noremap = true }

-- Accept suggestion
vim.api.nvim_set_keymap('i', '<C-l>', 'supermaven#Accept("<C-l>")', opts)

-- Clear suggestion
vim.api.nvim_set_keymap('i', '<C-h>', 'supermaven#Dismiss()', opts)

-- Key mapping to toggle git-blame.nvim
lvim.builtin.which_key.mappings["gb"] = {
  "<cmd>GitBlameToggle<CR>", "Toggle Git Blame"
}

-- Key Mappings for Navigation
lvim.keys.normal_mode = {
  ["<leader>pv"] = "<cmd>Ex<CR>",                                           -- Open file explorer
  ["<leader>f"] = "<cmd>lua require('telescope.builtin').find_files()<CR>", -- Find files
  ["<leader>w"] = ":w<CR>",                                                 -- Save file
  ["<leader>x"] = "/",                                                      -- Clear search highlighting
  ["<leader>sn"] = "]s",                                                    -- Jump to the next spell error
  ["<leader>sp"] = "[s",                                                    -- Jump to the previous spell error
  ["<leader>gg"] = "<cmd>LazyGit<CR>",
  ["J"] = "}",                                                              -- Jump down a block
  ["<C-j>"] = "}",                                                          -- Jump down a block with Ctrl+j
  ["<C-k>"] = "{",
  ["r"] = "<cmd>lua vim.diagnostic.goto_next()<CR>",                        -- Jump to the next LSP error
  ["R"] = "<cmd>lua vim.diagnostic.goto_prev()<CR>",                        -- Jump to the previous LSP error
  ["<leader>gb"] = "<cmd>GitBlameToggle<CR>",                               -- Toggle Git Blame
}


vim.g.gitblame_message_template = '<author> • <date> • <summary>'


vim.api.nvim_create_user_command('CommentToggle', function()
  local cs = vim.bo.commentstring:gsub('%%s', ''):gsub(' ', '') -- Clean comment string

  if vim.fn.mode() == 'n' then                                  -- Normal mode, single line
    local line = vim.api.nvim_get_current_line()
    if vim.startswith(line, cs) then
      vim.api.nvim_set_current_line(line:sub(#cs + 1))
    else
      vim.api.nvim_set_current_line(cs .. line)
    end
  elseif vim.fn.mode() == 'V' or vim.fn.mode() == 'v' or vim.fn.mode() == '' then -- Visual mode, multiple lines
    -- Exit visual mode and save visual range
    vim.cmd('normal! `<v`>y')
    local lines = vim.fn.split(vim.fn.getreg('"'), '\n')

    -- Determine whether all lines are commented
    local all_commented = true
    for _, line in ipairs(lines) do
      if not vim.startswith(line, cs) then
        all_commented = false
        break
      end
    end

    -- Toggle comment based on whether all lines are already commented
    local new_lines = {}
    for _, line in ipairs(lines) do
      if all_commented then
        table.insert(new_lines, line:sub(#cs + 1))
      else
        table.insert(new_lines, cs .. line)
      end
    end

    -- Get start and end positions
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2] - 1
    local end_line = end_pos[2] - (all_commented and 1 or 0)

    -- Set new lines in buffer
    vim.api.nvim_buf_set_lines(0, start_line, end_line, false, new_lines)

    -- Reselect the visual area
    vim.cmd(start_line + 1 .. ',' .. end_line .. 'normal! gv')
  end
end, {})

-- Finder that shows EVERYTHING (even .gitignored)
_G.find_all_files = function()
  require("telescope.builtin").find_files({
    prompt_title = "All files (incl. .gitignored)",
    hidden = true,
    no_ignore = true,
    follow = true,
  })
end

-- Which Key Mappings
lvim.builtin.which_key.mappings = {
  a = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Add to Harpoon" },
  e = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Harpoon Menu" },
  h = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Harpoon File 1" },
  t = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Harpoon File 2" },
  n = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Harpoon File 3" },
  m = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Harpoon File 4" },
  u = { "<cmd>UndotreeToggle<CR>", "Undo Tree" },
  x = { "/", "Search in Document" },
  s = {
    name = "+Spell",
    n = { "]s", "Next Spell Error" },
    p = { "[s", "Previous Spell Error" },
    c = { ":nohlsearch<CR>", "Clear Highlight" },
    s = { "z=", "Suggest Spelling" }
  },
  P = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep For > ') })<CR>", "Grep Finding" },
  F = { "<cmd>lua find_all_files()<CR>", "Find All Files" },
  g = {
    g = { "<cmd>LazyGit<CR>" }
  },
  z = { "<C-w>w", "Next Window" },
  k = { "<cmd>CommentToggle<CR>", "Toggle Comment" }
}
lvim.keys.visual_mode["<leader>k"] = ":<C-U>CommentToggle<CR>"

-- Spell-Checking Configurations
vim.opt.spell = true
vim.opt.spelllang = { "en_us" }
vim.opt.spelloptions = "camel"

-- Custom Auto Command for Spell-Checking
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})

-- Prettier Auto Command for TS/JS Files
-- lvim.autocommands = {
--   {
--     "BufWritePre",
--     {
--       pattern = { "*.js", "*.ts", "*.jsx", "*.tsx", "*.json" },
--       command = "PrettierAsync",
--     },
--   },
-- }

-- Treesitter Configuration for TS/TSX
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "typescript", "typescriptreact" },
  callback = function()
    vim.cmd("TSDisable highlight") -- Disable Treesitter highlighting
  end,
})

-- C# Snippet for Namespace
local ls = require('luasnip')
ls.snippets = {
  csharp = {
    ls.parser.parse_snippet("nsp", "namespace " .. _G.calculate_csharp_namespace() .. "\n{\n    $0\n}"),
  },
}

-- C# LSP Setup
lvim.lang.cs.lsp.setup = {
  handlers = {
    ["textDocument/definition"] = require("lvim.lsp.handlers").definition,
  },
  capabilities = require("lvim.lsp").common_capabilities(),
}

-- Function to Calculate C# Namespace
function _G.calculate_csharp_namespace()
  local path = vim.fn.expand("%:p:h")
  local project_root = "path/to/your/project"
  local path_relative = path:sub(#project_root + 2)
  local namespace = path_relative:gsub("[/\\]", ".")
  return namespace
end

-- Configure GraphQL Filetype Detection
vim.api.nvim_create_autocmd("BufNewFile,BufRead", {
  pattern = { "*.graphql", "*.graphqls", "*.gql", "*.prisma" },
  command = "setfiletype graphql",
})

-- Set GraphQL JavaScript/TypeScript Tag Names
vim.g.graphql_javascript_tags = { "gql", "graphql", "Relay.QL" }

local lspconfig = require("lspconfig")

lspconfig.intelephense.setup({
  settings = {
    intelephense = {
      stubs = {
        "wordpress", "php", "core", "curl", "json", "mysqli", "pdo", "xml"
      },
      environment = {
        includePaths = {
          vim.fn.expand("~/Developer/learn/wordpress/wp-first/.stubs/wordpress")
        }
      }
    }
  }
})
