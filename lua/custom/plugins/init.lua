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

  -- Darcula Theme
  {
    'Mofiqul/dracula.nvim',
    lazy = false,
    priority = 1000,
    config = function(_, opts)
      vim.o.termguicolors = true
      require('dracula').setup(opts)
      vim.cmd.colorscheme 'dracula'

      -- vim.opt.fillchars = { diff = "╱" }
    end,
    opts = function()
      -- <custom functions for better vimdiff> (see: https://github.com/Mofiqul/dracula.nvim/issues/75)
      -- remove after dracula.nvim has better vimdiff support
      local function hexToRgb(c)
        c = string.lower(c)
        return { tonumber(c:sub(2, 3), 16), tonumber(c:sub(4, 5), 16), tonumber(c:sub(6, 7), 16) }
      end

      local function blend(foreground, background, alpha)
        alpha = type(alpha) == 'string' and (tonumber(alpha, 16) / 0xff) or alpha
        local bg = hexToRgb(background)
        local fg = hexToRgb(foreground)

        local blendChannel = function(i)
          local ret = (alpha * fg[i] + ((1 - alpha) * bg[i]))
          return math.floor(math.min(math.max(0, ret), 255) + 0.5)
        end

        return string.format('#%02x%02x%02x', blendChannel(1), blendChannel(2), blendChannel(3))
      end

      local function darken(hex, amount)
        local default_bg = '#000000'

        return blend(hex, default_bg, amount)
      end

      local colors = require 'dracula.palette'

      return {
        show_end_of_buffer = true,
        overrides = {
          DiffAdd = { bg = '#3b6345' },
          DiffDelete = { fg = darken(colors.bright_red, 0.65) },
          DiffChange = { bg = darken(colors.comment, 0.60) },
          DiffText = { bg = '#516595' },
          illuminatedWord = { bg = darken(colors.comment, 0.65) },
          illuminatedCurWord = { bg = darken(colors.comment, 0.65) },
          IlluminatedWordText = { bg = darken(colors.comment, 0.65) },
          IlluminatedWordRead = { bg = darken(colors.comment, 0.65) },
          IlluminatedWordWrite = { bg = darken(colors.comment, 0.65) },
        },
      }
    end,
  },
}
