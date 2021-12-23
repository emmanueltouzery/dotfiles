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
    'airblade/vim-rooter',
    'nvim-telescope/telescope-live-grep-raw.nvim',
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'},
    't9md/vim-choosewin',
    'sindrets/diffview.nvim',
    'emmanueltouzery/agitator.nvim',
    'nvim-telescope/telescope-project.nvim',
    'maxbrunsfeld/vim-yankstack', -- considered https://github.com/AckslD/nvim-neoclip.lua too

    -- spellchecks in comments is attractive but when commenting code,
    -- it goes completely red, and also i had trouble to have vim
    -- ignore spellcheck errors in URLs in comments.
    -- So now I'm spell checking only in markdown files.
    -- 'emmanueltouzery/spellsitter.nvim'
}

return M

-- vim: sw=2 sts=2 ts=2 noexpandtab
