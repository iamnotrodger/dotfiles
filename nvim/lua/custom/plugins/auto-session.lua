-- Automatic session management
-- https://github.com/rmagatti/auto-session

vim.pack.add { 'https://github.com/rmagatti/auto-session' }

-- Recommended sessionoptions for auto-session to save/restore enough state.
vim.o.sessionoptions = 'blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions'

require('auto-session').setup {
  suppressed_dirs = { '~/', '~/Downloads', '~/Desktop', '~/Documents' },
  -- Close neo-tree before saving so its windows aren't persisted in the
  -- session. Restored neo-tree buffers lack their buffer-local state vars,
  -- which crashes neo-tree's WinClosed handler (get_state on a nil source).
  pre_save_cmds = { 'Neotree close' },
}
