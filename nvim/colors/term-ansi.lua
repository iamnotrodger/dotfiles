-- Colorscheme built only from the terminal's 16 ANSI colors, so the actual
-- colors come from the terminal theme. Requires `termguicolors = false`.
--
-- Assumes the theme puts its primary accents at 1-6 and secondary accents at
-- 9-14 in both dark and light variants. Orange and purple have no ANSI slot:
-- they borrow 3 (yellow) and 13.

vim.cmd 'highlight clear'
vim.g.colors_name = 'term-ansi'

local dark = vim.o.background == 'dark'

local c = {
  -- Terminal default fg/bg
  tx = 'NONE',
  bg = 'NONE',
  -- Explicit text colors, for when a background is set and fg must be readable
  tx_hard = dark and 15 or 0,
  on_accent = dark and 0 or 15,
  ['tx-2'] = 7,
  ['tx-3'] = 8,

  re = 1,
  gr = 2,
  ye = 3,
  bl = 4,
  ma = 5,
  cy = 6,
  ['re-2'] = 9,
  ['gr-2'] = 10,
  ['ye-2'] = 11,
  ['bl-2'] = 12,
  ['ma-2'] = 13,
  ['cy-2'] = 14,

  ['or'] = 3,
  ['or-2'] = 11,
  pu = 13,
  ['pu-2'] = 5,
}

local groups = {
  Normal = { fg = c.tx, bg = c.bg },
  NormalNC = {},
  Underlined = { underline = true },
  Bold = { bold = true },
  Italic = { italic = true },

  SpellBad = { fg = c['re-2'], underline = true },
  SpellCap = { fg = c.ye, underline = true },
  SpellLocal = { fg = c.gr, underline = true },
  SpellRare = { fg = c.pu, underline = true },

  NonText = { fg = c['tx-3'] },
  EndOfBuffer = {},

  Search = { fg = c.on_accent, bg = c.ye },
  IncSearch = { fg = c.on_accent, bg = c.ye },
  CurSearch = { fg = c.on_accent, bg = c['ye-2'] },
  Substitute = { fg = c.on_accent, bg = c.gr },

  DiffAdd = { fg = c.on_accent, bg = c.gr },
  DiffChange = { fg = c.on_accent, bg = c.pu },
  DiffDelete = { fg = c.on_accent, bg = c.re },
  DiffText = { fg = c.on_accent, bg = c['bl-2'] },

  Comment = { fg = c['tx-3'] },

  Constant = { fg = c.ye },
  String = { fg = c.cy },
  Character = { fg = c.cy },
  Number = { fg = c.ma },
  Boolean = { fg = c.ma },
  Float = { fg = c.ma },

  Identifier = { fg = c.bl },
  Function = { fg = c['or'] },

  Keyword = { fg = c.gr },
  Statement = {},
  Conditional = { link = 'Keyword' },
  Repeat = { link = 'Keyword' },
  Label = { link = 'Keyword' },
  Operator = { fg = c['tx-2'] },
  Exception = { link = 'Keyword' },

  PreProc = { fg = c.ma },
  Include = { fg = c.re },
  Define = { fg = c.ma },
  Macro = { fg = c.ma },
  PreCondit = { fg = c.ma },

  Type = { fg = c.gr },
  StorageClass = { fg = c['or'] },
  Structure = { fg = c['or'] },
  Typedef = { fg = c['or'] },

  SpecialComment = { fg = c.tx },
  Special = { fg = c['tx-2'] },
  SpecialChar = { fg = c.ma },
  Tag = { fg = c.cy },
  Debug = { fg = c.ma },
  Delimiter = { link = 'Special' },
  Error = { fg = c.re, bold = true },
  Todo = { fg = c.ma, bold = true },

  SignColumn = {},
  FoldColumn = { fg = c['tx-3'] },
  Folded = { fg = c['tx-3'] },
  LineNr = { fg = c['tx-3'] },
  CursorLine = {},
  CursorLineNr = { fg = c.tx, bold = true },
  CursorColumn = {},
  ColorColumn = { bg = c['tx-3'] },
  Whitespace = { fg = c['tx-3'] },
  Visual = { fg = c.tx_hard, bg = c['tx-3'] },
  VisualNOS = { link = 'Visual' },
  MatchParen = { bold = true, underline = true },

  Pmenu = { fg = c['tx-2'] },
  PmenuSel = { fg = c.on_accent, bg = c['cy-2'] },
  PmenuSbar = {},
  PmenuThumb = { bg = c['tx-3'] },
  WildMenu = { fg = c.on_accent, bg = c['cy-2'] },

  NormalFloat = { fg = c['tx-2'] },
  FloatBorder = { fg = c['tx-3'] },

  TabLine = { fg = c['tx-2'] },
  TabLineSel = { fg = c.tx, bold = true },
  TabLineFill = {},
  StatusLine = { fg = c.tx },
  StatusLineNC = { fg = c['tx-2'] },
  WinBar = { fg = c.tx },
  WinBarNC = { fg = c['tx-2'] },
  WinSeparator = { fg = c['tx-3'] },

  MsgArea = {},
  ModeMsg = {},
  Conceal = {},
  Directory = { fg = c.bl },
  SpecialKey = { fg = c.bl, bold = true },
  Title = { fg = c.bl, bold = true },
  ErrorMsg = { fg = c['re-2'], bold = true },
  WarningMsg = { fg = c.re },
  MoreMsg = { fg = c['or'] },
  Question = { fg = c['or'] },
  QuickFixLine = { bold = true },

  DiagnosticError = { fg = c.re },
  DiagnosticWarn = { fg = c.ye },
  DiagnosticInfo = { fg = c.cy },
  DiagnosticHint = { fg = c.bl },
  DiagnosticOk = { fg = c.gr },

  Added = { fg = c.gr },
  Removed = { fg = c.re },
  Changed = { fg = c['or'] },

  -- Treesitter (legacy and current capture names)
  ['@comment'] = { link = 'Comment' },
  ['@punctuation'] = { link = 'Delimiter' },
  ['@constant'] = { link = 'Constant' },
  ['@constant.builtin'] = { link = 'Special' },
  ['@constant.macro'] = { link = 'Define' },
  ['@macro'] = { link = 'Macro' },
  ['@string'] = { link = 'String' },
  ['@string.escape'] = { link = 'SpecialChar' },
  ['@string.special'] = { link = 'SpecialChar' },
  ['@character'] = { link = 'Character' },
  ['@character.special'] = { link = 'SpecialChar' },
  ['@number'] = { link = 'Number' },
  ['@number.float'] = { link = 'Float' },
  ['@boolean'] = { link = 'Boolean' },
  ['@function'] = { link = 'Function' },
  ['@function.builtin'] = { link = 'Special' },
  ['@function.macro'] = { link = 'Macro' },
  ['@function.method'] = { link = 'Function' },
  ['@method'] = { link = 'Function' },
  ['@constructor'] = { link = 'Special' },
  ['@parameter'] = { link = 'Identifier' },
  ['@variable'] = { link = 'Identifier' },
  ['@variable.parameter'] = { link = 'Identifier' },
  ['@variable.member'] = { link = 'Identifier' },
  ['@field'] = { link = 'Identifier' },
  ['@property'] = { link = 'Identifier' },
  ['@keyword'] = { link = 'Keyword' },
  ['@keyword.conditional'] = { link = 'Conditional' },
  ['@keyword.repeat'] = { link = 'Repeat' },
  ['@keyword.exception'] = { link = 'Exception' },
  ['@keyword.import'] = { link = 'Include' },
  ['@conditional'] = { link = 'Conditional' },
  ['@repeat'] = { link = 'Repeat' },
  ['@exception'] = { link = 'Exception' },
  ['@include'] = { link = 'Include' },
  ['@label'] = { link = 'Label' },
  ['@operator'] = { link = 'Operator' },
  ['@type'] = { link = 'Type' },
  ['@type.definition'] = { link = 'Typedef' },
  ['@storageclass'] = { link = 'StorageClass' },
  ['@structure'] = { link = 'Structure' },
  ['@module'] = { fg = c.ma },
  ['@namespace'] = { link = '@module' },
  ['@preproc'] = { link = 'PreProc' },
  ['@debug'] = { link = 'Debug' },
  ['@tag'] = { link = 'Tag' },
  ['@markup.heading'] = { link = 'Title' },
  ['@markup.link.url'] = { link = 'Underlined' },
  ['@markup.raw'] = { link = 'Comment' },

  -- mini.trailspace
  MiniTrailspace = { bg = c.re },

  -- neo-tree
  NeoTreeDimText = { fg = c['tx-2'] },
  NeoTreeDirectoryIcon = { fg = c.ye },
  NeoTreeDirectoryName = { fg = c.bl },
  NeoTreeDotfile = { fg = c.ma },
  NeoTreeFileIcon = { fg = c.cy },
  NeoTreeFileName = { fg = c.tx },
  NeoTreeFileNameOpened = { fg = c['cy-2'] },
  NeoTreeFilterTerm = { fg = c.cy },
  NeoTreeGitAdded = { fg = c.gr },
  NeoTreeGitDeleted = { fg = c.re },
  NeoTreeGitIgnored = { fg = c['tx-3'] },
  NeoTreeGitModified = { fg = c['or-2'] },
  NeoTreeGitUnstaged = { fg = c['or-2'] },
  NeoTreeGitUntracked = { fg = c.ye },
  NeoTreeGitStaged = { fg = c.gr },
  NeoTreeHiddenByName = { link = 'Comment' },
  NeoTreeIndentMarker = { link = 'Comment' },
  NeoTreeStats = { link = 'Comment' },
  NeoTreeSymbolicLinkTarget = { fg = c.ma },

  -- todo-comments
  TodoBgFIX = { fg = c.on_accent, bg = c.re, bold = true },
  TodoFgFIX = { fg = c.re },
  TodoBgTODO = { fg = c.on_accent, bg = c.bl, bold = true },
  TodoFgTODO = { fg = c.bl },
  TodoBgHACK = { fg = c.on_accent, bg = c['or'], bold = true },
  TodoFgHACK = { fg = c['or'] },
  TodoBgWARN = { fg = c.on_accent, bg = c.ye, bold = true },
  TodoFgWARN = { fg = c.ye },
  TodoBgPERF = { fg = c.on_accent, bg = c.pu, bold = true },
  TodoFgPERF = { fg = c.pu },
  TodoBgNOTE = { fg = c.on_accent, bg = c.cy, bold = true },
  TodoFgNOTE = { fg = c.cy },
  TodoBgTEST = { fg = c.on_accent, bg = c.gr, bold = true },
  TodoFgTEST = { fg = c.gr },
}

for name, spec in pairs(groups) do
  if spec.fg or spec.bg then
    spec.ctermfg, spec.ctermbg, spec.fg, spec.bg = spec.fg, spec.bg, nil, nil
  end
  vim.api.nvim_set_hl(0, name, spec)
end
