-- doom_userplugins - Doom nvim custom plugins
--
-- This file contains all the custom plugins that are not in Doom nvim but that
-- the user requires. All the available fields can be found here
-- https://github.com/wbthomason/packer.nvim#specifying-plugins
--
-- By example, for including a plugin with a dependency on telescope:
-- M.plugins {
--   {
--     'user/repository',
--     requires = { 'nvim-lua/telescope.nvim' },
--   },
-- }

local M = {}

M.source = debug.getinfo(1, "S").source:sub(2)

M.plugins = {
    {'airblade/vim-rooter', config = function() 
      vim.g['rooter_silent_chdir'] = 1 
      vim.g['rooter_cd_cmd'] = 'lcd'
    end},
    'nvim-telescope/telescope-live-grep-raw.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    --'t9md/vim-choosewin',
    'CodingdAwn/vim-choosewin', -- fork which adds the "close window" feature
    'sindrets/diffview.nvim',
    'emmanueltouzery/agitator.nvim',
    'nvim-telescope/telescope-project.nvim',
    -- vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']")
    -- drop s and S due to lightspeed
    {'maxbrunsfeld/vim-yankstack', config= function() vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']") end}, -- considered https://github.com/AckslD/nvim-neoclip.lua too
    'mhartington/formatter.nvim',
    'elixir-editors/vim-elixir',
    'nvim-lualine/lualine.nvim',
    'ellisonleao/glow.nvim',
    'tpope/vim-abolish',
    'qpkorr/vim-bufkill',
    'lifepillar/vim-cheat40',
    'ggandor/lightspeed.nvim',
    'samoshkin/vim-mergetool',
    {'jose-elias-alvarez/null-ls.nvim', commit='43dc39f704558ca4445ffbd89777dbe5367c2dd1', config = function()


    end},
    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  },

    -- spellchecks in comments is attractive but when commenting code,
    -- it goes completely red, and also i had trouble to have vim
    -- ignore spellcheck errors in URLs in comments.
    -- So now I'm spell checking only in markdown files.
    -- 'emmanueltouzery/spellsitter.nvim'
}

return M

-- vim: sw=2 sts=2 ts=2 noexpandtab
