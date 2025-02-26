-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  -- Comment.nvim
  {
    'numToStr/Comment.nvim',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
    },
    config = function()
      require('Comment').setup {
        toggler = {
          ---Line-comment toggle keymap
          line = 'gcc',
          ---Block-comment toggle keymap
          block = 'gbc',
        },
        opleader = {
          ---Line-comment keymap
          line = 'gc',
          ---Block-comment keymap
          block = 'gb',
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
      }
    end,
  },

  -- Vim tmux navigator
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },

  -- Lazygit
  {
    'kdheepak/lazygit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    keys = { { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Toggle LazyGit' } },
  },

  -- Automated bullets list
  {
    'dkarter/bullets.vim',
    config = function()
      -- markdown 3 spaces for tabs for md files
      vim.cmd [[autocmd FileType markdown setlocal tabstop=3 shiftwidth=3]]

      vim.g.bullets_enabled_file_types = { 'markdown' }
      vim.g.bullets_outline_levels = { 'num' }

      -- markdown wrap lines
      vim.cmd [[autocmd FileType markdown setlocal wrap]]

      vim.g.bullets_checkbox_markers = ' .oOx'
    end,
  },

  -- VimTex
  {
    'lervag/vimtex',
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = 'zathura'
      vim.g.vimtex_compiler_method = 'latexmk' -- Use latexmk for auto-compilation
      vim.g.vimtex_complete_enabled = 1 -- Enable completion
    end,
  },

  -- Kanagawa Color Scheme
  {
    'rebelot/kanagawa.nvim',
    init = function()
      vim.cmd.colorscheme 'kanagawa-wave'
      vim.opt.termguicolors = true
    end,
  },
}
