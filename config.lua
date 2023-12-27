-- general
lvim.log.level = "warn"
lvim.format_on_save.enabled = true
lvim.colorscheme = "lunar"
-- to disable icons and use a minimalist setup, uncomment the following
lvim.use_icons = true

-- if you don't want all the parsers change this to a table of the ones you want
lvim.builtin.treesitter.ensure_installed = {
  "bash",
  "c",
  "javascript",
  "json",
  "lua",
  "python",
  "typescript",
  "tsx",
  "css",
  "rust",
  "java",
  "yaml",
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enable = true

lvim.plugins = {
  'ThePrimeagen/harpoon',
  'mbbill/undotree'

}

--  Remaps
lvim.leader = " "
vim.g.mapleader = " "
lvim.keys.normal_mode["<leader>pv"] = "<cmd>Ex<CR>"
vim.api.nvim_set_var("tunings", {
  macOptionAsMeta = true,
})

vim.cmd('set spell')
vim.cmd('set spelloptions=camel')
vim.cmd("set relativenumber")
--
-- Additional Configuration
local harpoon_mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Set key mappings for Harpoon

-- First, require the necessary Harpoon modules at the top of your config.lua
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

-- Then, set up your which_key mappings for Harpoon
lvim.builtin.which_key.mappings["a"] = { "<cmd>lua require('harpoon.mark').add_file()<CR>", "Mark/Add file to Harpoon" }
lvim.builtin.which_key.mappings["e"] = { "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
  "Toggle Harpoon quick menu" }

lvim.builtin.which_key.mappings["h"] = { "<cmd>lua require('harpoon.ui').nav_file(1)<CR>", "Navigate to Harpoon file 1" }
lvim.builtin.which_key.mappings["t"] = { "<cmd>lua require('harpoon.ui').nav_file(2)<CR>", "Navigate to Harpoon file 2" }
lvim.builtin.which_key.mappings["n"] = { "<cmd>lua require('harpoon.ui').nav_file(3)<CR>", "Navigate to Harpoon file 3" }
lvim.builtin.which_key.mappings["m"] = { "<cmd>lua require('harpoon.ui').nav_file(4)<CR>", "Navigate to Harpoon file 4" }

-- Telescope
local builtin = require('telescope.builtin')

-- Remove the existing mapping if it's set somewhere else
lvim.builtin.which_key.mappings["p"]["p"] = nil

-- Add your own keymappings for Telescope using WhichKey
lvim.builtin.which_key.mappings["p"]["f"] = { "<cmd>lua require('telescope.builtin').find_files()<CR>", "Find Files" }

lvim.builtin.which_key.mappings["p"] = {
  name = "+Telescope", -- Optional: name the group
  p = { "<cmd>lua require('telescope.builtin').git_files()<CR>", "Git Files" },
  P = { "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.input('Grep > ') })<CR>", "Grep String" },
}

-- Undutree

lvim.builtin.which_key.mappings["u"] = { "<cmd>UndotreeToggle<CR>", "Toggle Undo Tree" }

-- snippet
function _G.calculate_csharp_namespace()
  local path = vim.fn.expand("%:p:h")
  local project_root = "path/to/your/project" -- Adjust this to your project's root
  local path_relative = path:sub(#project_root + 2)
  local namespace = path_relative:gsub("[/\\]", ".")
  return namespace
end

local ls = require('luasnip')

ls.snippets = {
  csharp = {
    -- Namespace snippet
    ls.parser.parse_snippet("nsp", "namespace " .. _G.calculate_csharp_namespace() .. "\n{\n    $0\n}")
  },
}
