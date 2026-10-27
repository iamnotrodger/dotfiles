-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

vim.pack.add {
  { src = 'https://github.com/nvim-neo-tree/neo-tree.nvim', version = vim.version.range '*' },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.keymap.set('n', '<leader>e', ':Neotree toggle<CR>', { desc = 'NeoTree toggle', silent = true })

-- Track Neo-tree width to retain size after manual resize
local neo_tree_width = 40

vim.api.nvim_create_autocmd('WinResized', {
  callback = function()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local buf = vim.api.nvim_win_get_buf(win)
      if vim.bo[buf].filetype == 'neo-tree' then
        neo_tree_width = vim.api.nvim_win_get_width(win)
        break
      end
    end
  end,
})

-- Make Neo-tree background match the editor background
vim.api.nvim_set_hl(0, 'NeoTreeNormal', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { link = 'Normal' })
vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { link = 'Normal' })

-- Reapply after colorscheme changes
vim.api.nvim_create_autocmd('ColorScheme', {
  callback = function()
    vim.api.nvim_set_hl(0, 'NeoTreeNormal', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'NeoTreeNormalNC', { link = 'Normal' })
    vim.api.nvim_set_hl(0, 'NeoTreeEndOfBuffer', { link = 'Normal' })
  end,
})

-- Helper to get regular windows (not neo-tree, not special buffers)
local function get_regular_windows(exclude_win)
  local wins = {}
  for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    if win ~= exclude_win then
      local buf = vim.api.nvim_win_get_buf(win)
      local bt = vim.bo[buf].buftype
      if bt == '' or bt == nil then
        table.insert(wins, win)
      end
    end
  end
  return wins
end

-- Helper to prompt for window selection (single keypress, no enter needed)
local function prompt_window_choice(wins, path)
  local win_positions = {}
  for _, win in ipairs(wins) do
    local col = vim.api.nvim_win_get_position(win)[2]
    table.insert(win_positions, { win = win, col = col })
  end
  table.sort(win_positions, function(a, b)
    return a.col < b.col
  end)

  local left_win = win_positions[1].win
  local right_win = win_positions[2].win

  vim.api.nvim_echo({ { 'Open in: [a] Left  [b] Right ', 'Question' } }, false, {})
  local char = vim.fn.getcharstr()

  if char == 'a' then
    vim.api.nvim_set_current_win(left_win)
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
  elseif char == 'b' then
    vim.api.nvim_set_current_win(right_win)
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
  end
  vim.cmd 'echo ""'
end

-- Custom open function: max 2 vertical windows, asks which to use when both exist
local function smart_open(state)
  local node = state.tree:get_node()
  if node.type == 'directory' then
    if node:is_expanded() then
      require('neo-tree.sources.filesystem').toggle_directory(state, node)
    else
      require('neo-tree.sources.filesystem.commands').toggle_node(state)
    end
    return
  end

  local path = node:get_id()
  local neo_tree_win = vim.api.nvim_get_current_win()
  local wins = get_regular_windows(neo_tree_win)

  if #wins == 2 then
    prompt_window_choice(wins, path)
  elseif #wins == 1 then
    vim.api.nvim_set_current_win(wins[1])
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
  else
    vim.cmd 'wincmd l'
    vim.cmd('edit ' .. vim.fn.fnameescape(path))
  end
end

-- Vsplit: creates split if <2 windows, otherwise asks which window
local function smart_vsplit(state)
  local node = state.tree:get_node()
  if node.type == 'directory' then
    if node:is_expanded() then
      require('neo-tree.sources.filesystem').toggle_directory(state, node)
    else
      require('neo-tree.sources.filesystem.commands').toggle_node(state)
    end
    return
  end

  local path = node:get_id()
  local neo_tree_win = vim.api.nvim_get_current_win()
  local wins = get_regular_windows(neo_tree_win)

  if #wins >= 2 then
    prompt_window_choice(wins, path)
  elseif #wins == 1 then
    vim.api.nvim_set_current_win(wins[1])
    vim.cmd('vsplit ' .. vim.fn.fnameescape(path))
  else
    vim.cmd 'wincmd l'
    vim.cmd('vsplit ' .. vim.fn.fnameescape(path))
  end
end

require('neo-tree').setup {
  source_selector = {
    statusline = false,
  },
  default_component_configs = {
    indent = {
      padding = 0,
    },
  },
  window = {
    position = 'left',
    width = function()
      return neo_tree_width
    end,
    mapping_options = {
      noremap = true,
      nowait = true,
    },
    mappings = {
      ['<2-LeftMouse>'] = smart_open,
      ['<cr>'] = smart_open,
    },
  },
  filesystem = {
    filtered_items = {
      visible = true,
      hide_dotfiles = false,
      hide_gitignored = false,
    },
    follow_current_file = {
      enabled = true,
      leave_dirs_open = true,
    },
    use_libuv_file_watcher = true, -- Faster file watching
    async_directory_scan = 'always', -- Always scan directories async
    scan_mode = 'deep', -- Scan deeply but async
    bind_to_cwd = false, -- Don't bind to cwd for faster switching
    window = {
      mappings = {
        ['<leader>e'] = 'close_window',
        ['o'] = smart_open,
        ['v'] = smart_vsplit,
      },
    },
  },
  -- Disable git status for faster performance (optional)
  -- git_status = { enable = false },
}

-- Disable statusline for Neo-tree buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'neo-tree',
  callback = function()
    vim.opt_local.statusline = ' '
  end,
})
