-- Statusline
-- https://github.com/nvim-lualine/lualine.nvim

vim.pack.add { 'https://github.com/nvim-lualine/lualine.nvim' }

local p = require('flexoki.palette').palette()
local none = 'NONE'

local flexoki_theme = {
  normal = {
    a = { bg = p['bl'], fg = p['bg'], gui = 'bold' },
    b = { bg = p['ui-2'], fg = p['tx'] },
    c = { bg = none, fg = p['tx-2'] },
  },
  insert = {
    a = { bg = p['gr'], fg = p['bg'], gui = 'bold' },
    b = { bg = p['ui-2'], fg = p['tx'] },
    c = { bg = none, fg = p['tx-2'] },
  },
  visual = {
    a = { bg = p['pu'], fg = p['bg'], gui = 'bold' },
    b = { bg = p['ui-2'], fg = p['tx'] },
    c = { bg = none, fg = p['tx-2'] },
  },
  replace = {
    a = { bg = p['re'], fg = p['bg'], gui = 'bold' },
    b = { bg = p['ui-2'], fg = p['tx'] },
    c = { bg = none, fg = p['tx-2'] },
  },
  command = {
    a = { bg = p['ye'], fg = p['bg'], gui = 'bold' },
    b = { bg = p['ui-2'], fg = p['tx'] },
    c = { bg = none, fg = p['tx-2'] },
  },
  inactive = {
    a = { bg = p['ui'], fg = p['tx-3'] },
    b = { bg = none, fg = p['tx-3'] },
    c = { bg = none, fg = p['tx-3'] },
  },
}

require('lualine').setup {
  options = {
    theme = flexoki_theme,
    component_separators = '',
    section_separators = { left = '', right = '' },
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '', right = '' } } },
    lualine_b = { { 'branch', color = { bg = p['ye-2'], fg = p['bg-2'] }, separator = { right = '' } } },
    lualine_c = { 'filename', 'filetype', 'diagnostics' },
    lualine_x = {},
    lualine_y = { 'progress' },
    lualine_z = { { 'location', separator = { left = '', right = '' } } },
  },
}
