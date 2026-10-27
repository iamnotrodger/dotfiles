-- Statusline
-- https://github.com/nvim-lualine/lualine.nvim

vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

-- Numbers are ANSI palette indices, so the statusline follows the terminal theme
local none = 'NONE'
local muted = 7

local function mode(color)
  return {
    a = { bg = color, fg = 0, gui = 'bold' },
    b = { bg = none, fg = none },
    c = { bg = none, fg = muted },
  }
end

local ansi_theme = {
  normal = mode(4),
  insert = mode(2),
  visual = mode(5),
  replace = mode(1),
  command = mode(3),
  inactive = {
    a = { bg = none, fg = 8 },
    b = { bg = none, fg = 8 },
    c = { bg = none, fg = 8 },
  },
}

require('lualine').setup {
  options = {
    theme = ansi_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '', right = '' } } },
    lualine_b = { { 'branch', color = { bg = 3, fg = 0 }, separator = { right = '' } } },
    lualine_c = { 'filename', 'filetype', 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { { 'location', separator = { left = '', right = '' } } },
  },
}
