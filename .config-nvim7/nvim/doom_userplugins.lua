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
    end, commit='0415be8b5989e56f6c9e382a04906b7f719cfb38'},
    {'nvim-telescope/telescope-live-grep-raw.nvim', commit='8124094e11b54a1853c3306d78e6ca9a8d40d0cb'},
    {'nvim-telescope/telescope-fzf-native.nvim', run = 'make', commit='8ec164b541327202e5e74f99bcc5fe5845720e18'},
    --'t9md/vim-choosewin',
    {'CodingdAwn/vim-choosewin', commit='554edfec23c9b7fe523f957a90821b4e0da7aa36'}, -- fork which adds the "close window" feature
    {'sindrets/diffview.nvim', commit='71e972ecec34cc9b4917ccdacbbd29062ef9657c'},
    '/home/emmanuel/home/agitator.nvim/',
    {'nvim-telescope/telescope-project.nvim', commit='d317c3cef6917d650d9a638c627b54d3e1173031'},
    -- vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']")
    -- drop s and S due to lightspeed
    {'maxbrunsfeld/vim-yankstack', commit='157a659c1b101c899935d961774fb5c8f0775370', config= function() vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']") end}, -- considered https://github.com/AckslD/nvim-neoclip.lua too
    {'mhartington/formatter.nvim', commit='2e82574f2cb6686849fb8e7a0231537734161fd4'},
    {'emmanueltouzery/vim-elixir', commit='735528cecc19ecffa002ffa20176e9984cced970'},
    {'nvim-lualine/lualine.nvim', commit='d64152cf5c79588e59d9349972b9284c28945405'},
    {'ellisonleao/glow.nvim', commit='c6685381d31df262b776775b9f4252f6c7fa98d0'},
    {'tpope/vim-abolish', commit='3f0c8faadf0c5b68bcf40785c1c42e3731bfa522'},
    {'qpkorr/vim-bufkill', commit='2bd6d7e791668ea52bb26be2639406fcf617271f'},
    {'lifepillar/vim-cheat40', commit='ae237b02f9031bc82a8ad9202bffee2bcef71ed1'},
    {'ggandor/lightspeed.nvim', commit='23565bcdd45afea0c899c71a367b14fc121dbe13'},
    {'samoshkin/vim-mergetool', commit='0275a85256ad173e3cde586d54f66566c01b607f'},
    {'tpope/vim-dispatch', commit='00e77d90452e3c710014b26dc61ea919bc895e92'}, -- used by vim-test
    {'vim-test/vim-test', commit='56bbfa295fe62123d2ebe8ed57dd002afab46097'},
    -- vim-markify, considered alternative: https://github.com/tomtom/quickfixsigns_vim
    {'dhruvasagar/vim-markify', commit='14158865c0f37a02a5d6d738437eb00a821b31ef', config = function()
      vim.g.markify_error_text = ""
      vim.g.markify_warning_text = ""
      vim.g.markify_info_text = ""
      vim.g.markify_info_texthl = "Todo"
    end},
    {'jose-elias-alvarez/null-ls.nvim', commit='09efad6fcd3ba2394bc456a70ce47fac68793a6d', config = function()

			require("null-ls").setup({
    		sources = {
        	-- require("null-ls").builtins.formatting.stylua,
        	require("null-ls").builtins.diagnostics.eslint,
        	-- require("null-ls").builtins.completion.spell,
        	-- null_ls.builtins.diagnostics.credo,
        	-- null_ls.builtins.diagnostics.shellcheck,
        	-- null_ls.builtins.formatting.prettier,
        	-- null_ls.builtins.formatting.rustfmt,
        	-- null_ls.builtins.formatting.mix,
        	-- null_ls.builtins.formatting.eslint,
    		},
			})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/discussions/244
-- local lspconfig = require("lspconfig")
-- lspconfig.tsserver.setup({
--     on_attach = function(client, bufnr)
--     	print("hi")
--         client.resolved_capabilities.document_formatting = false
--         -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<space>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", {})
--     end,
-- })
-- local null_ls = require("null-ls")
-- null_ls.config({ sources = {
--     null_ls.builtins.diagnostics.eslint,
-- }})
-- --         require("lspconfig")["null-ls"].setup({})

    end,
    requires = {"nvim-lua/plenary.nvim", "neovim/nvim-lspconfig"}
  },
  {'ruifm/gitlinker.nvim', commit='ff33d07'},

    -- 'j-hui/fidget.nvim',

    -- {'nvim-lua/lsp-status.nvim', commit = 'e8e5303f9ee3d8dc327c97891eaa1257ba5d4eee'},

    -- spellchecks in comments is attractive but when commenting code,
    -- it goes completely red, and also i had trouble to have vim
    -- ignore spellcheck errors in URLs in comments.
    -- So now I'm spell checking only in markdown files.
    -- 'emmanueltouzery/spellsitter.nvim'
}

return M

-- vim: sw=2 sts=2 ts=2 noexpandtab
