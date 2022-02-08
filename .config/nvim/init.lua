---[[---------------------------------------]]---
--      init.lua - Init file of Doom Nvim      --
--             Author: NTBBloodbath            --
--             License: GPLv2                  --
---[[---------------------------------------]]---

---- Doom Utilities -----------------------------
-------------------------------------------------
-- Store startup time in seconds
vim.g.start_time = vim.fn.reltime()
-- Lua modules loader, when loading our modules with this
-- we avoid breaking all the configuration if something fails
local load_modules = require("doom.utils.modules").load_modules

-- Disable some unused built-in Neovim plugins
vim.g.loaded_gzip = false
vim.g.loaded_tarPlugin = false
vim.g.loaded_zipPlugin = false
vim.g.loaded_2html_plugin = false

---- Doom Configurations ------------------------
-------------------------------------------------
-- Load Doom core and UI related stuff (colorscheme, background)
load_modules("doom", { "core" })

-- Defer and schedule loading of plugins and extra functionalities until the
-- Neovim API functions are safe to call to avoid weird errors with plugins stuff
vim.defer_fn(function()
  -- Load Doom extra stuff and plugins (modules, extras)
  load_modules("doom", { "modules", "extras" })

  -- This loads certain plugins related to UI
  vim.cmd("doautocmd ColorScheme")

  -- If the current buffer name is empty then trigger Dashboard.
  -- NOTE: this is done to avoid some weird issues with Dashboard and
  --       number / signcolumn when Dashboard gets triggered automatically
  --
  -- Emmanuel: disabled manually, see:
  -- https://github.com/NTBBloodbath/doom-nvim/issues/294
  -- if
  --   (vim.api.nvim_buf_get_name(0):len() == 0)
  --   and (packer_plugins and packer_plugins["dashboard-nvim"])
  -- then
  --   vim.cmd("Dashboard")
  -- end

  vim.cmd([[
    PackerLoad nvim-treesitter
    " This BufEnter call should fix some issues with concealing in neorg
    doautocmd BufEnter
  ]])

  if not require("doom.utils").is_plugin_disabled("which-key") then
    vim.cmd([[
      PackerLoad which-key.nvim
    ]])
  end

  --- MY CODE
  emmanuel_init()

end, 0)

-- huge hack. the first time I'd open nvim-tree in doom-nvim,
-- the current file wouldn't be focused. the second time it would be.
-- I think it's connected with packer's lazy loading.. 
-- anyway, huge workaround, the first time the tree is used, when packer
-- loads it, trigger it 3x -- first call, show, the file's node isn't expanded...
-- second time, hide back the tree. Third call, show the tree, the file is
-- expanded. And we do that only the first time the tree is invoked.
function _G.toggle_tree()
    if packer_plugins and packer_plugins["nvim-tree.lua"] and packer_plugins["nvim-tree.lua"].loaded then
        -- tree is loaded
        vim.cmd("NvimTreeToggle")
    else
        -- tree ain't loaded
        vim.cmd("NvimTreeToggle")
        vim.defer_fn(function()
            vim.cmd("NvimTreeToggle")
            vim.defer_fn(function()
                vim.cmd("NvimTreeToggle")
            end, 0)
        end, 0)
        -- print(vim.inspect(packer_plugins))
    end
end

function _G.my_open_tele()
    local w = vim.fn.expand('<cword>')
    -- require('telescope.builtin').live_grep()
    require("telescope").extensions.live_grep_raw.live_grep_raw()
    vim.fn.feedkeys(w)
end

function emmanuel_job_specific()
    -- https://stackoverflow.com/a/14407121/516188
    -- two space indent for job stuff
    vim.cmd("au BufRead,BufNewFile,BufEnter /home/emmanuel/projects/* setlocal sw=2")
end

function emmanuel_init()
    require('neogit').setup {
        signs = {
            -- { CLOSED, OPENED }
            section = { "▶", "▼" },
            item = { "▶", "▼" },
            hunk = { "", "" },
        }
    }
    require("todo-comments").setup {
        highlight = {
            pattern = {[[\s*\/\/.*<(KEYWORDS)\s*]], [[\s*--.*<(KEYWORDS)\s*]], [[\s*#.*<(KEYWORDS)\s*]]},
        }
    }

    require('kommentary.config').configure_language("default", {
        prefer_single_line_comments = true,
    })
    -- require('galaxyline').inactive_window_shortline = false

    local cb = require'diffview.config'.diffview_callback
    require('diffview').setup {
        -- had to copy the entire diffview keybindings only to
        -- disable the "-" to toggle stage/unstage (now 's'), because
        -- it conflicts with choosewin...
        key_bindings = {
            disable_defaults = true,                   -- Disable the default key bindings
            -- The `view` bindings are active in the diff buffers, only when the current
            -- tabpage is a Diffview.
            view = {
                ["<tab>"]      = cb("select_next_entry"),  -- Open the diff for the next file
                ["<s-tab>"]    = cb("select_prev_entry"),  -- Open the diff for the previous file
                ["gf"]         = cb("goto_file"),          -- Open the file in a new split in previous tabpage
                ["<C-w><C-f>"] = cb("goto_file_split"),    -- Open the file in a new split
                ["<C-w>gf"]    = cb("goto_file_tab"),      -- Open the file in a new tabpage
                ["<leader>e"]  = cb("focus_files"),        -- Bring focus to the files panel
                ["<leader>b"]  = cb("toggle_files"),       -- Toggle the files panel.
            },
            file_panel = {
                ["j"]             = cb("next_entry"),           -- Bring the cursor to the next file entry
                ["<down>"]        = cb("next_entry"),
                ["k"]             = cb("prev_entry"),           -- Bring the cursor to the previous file entry.
                ["<up>"]          = cb("prev_entry"),
                ["<cr>"]          = cb("select_entry"),         -- Open the diff for the selected entry.
                ["o"]             = cb("select_entry"),
                ["<2-LeftMouse>"] = cb("select_entry"),
                ["s"]             = cb("toggle_stage_entry"),   -- Stage / unstage the selected entry.
                ["S"]             = cb("stage_all"),            -- Stage all entries.
                ["U"]             = cb("unstage_all"),          -- Unstage all entries.
                ["X"]             = cb("restore_entry"),        -- Restore entry to the state on the left side.
                ["R"]             = cb("refresh_files"),        -- Update stats and entries in the file list.
                ["<tab>"]         = cb("select_next_entry"),
                ["<s-tab>"]       = cb("select_prev_entry"),
                ["gf"]            = cb("goto_file"),
                ["<C-w><C-f>"]    = cb("goto_file_split"),
                ["<C-w>gf"]       = cb("goto_file_tab"),
                ["i"]             = cb("listing_style"),        -- Toggle between 'list' and 'tree' views
                ["f"]             = cb("toggle_flatten_dirs"),  -- Flatten empty subdirectories in tree listing style.
                ["<leader>e"]     = cb("focus_files"),
                ["<leader>b"]     = cb("toggle_files"),
            },
            file_history_panel = {
                ["g!"]            = cb("options"),            -- Open the option panel
                ["<C-A-d>"]       = cb("open_in_diffview"),   -- Open the entry under the cursor in a diffview
                ["y"]             = cb("copy_hash"),          -- Copy the commit hash of the entry under the cursor
                ["zR"]            = cb("open_all_folds"),
                ["zM"]            = cb("close_all_folds"),
                ["j"]             = cb("next_entry"),
                ["<down>"]        = cb("next_entry"),
                ["k"]             = cb("prev_entry"),
                ["<up>"]          = cb("prev_entry"),
                ["<cr>"]          = cb("select_entry"),
                ["o"]             = cb("select_entry"),
                ["<2-LeftMouse>"] = cb("select_entry"),
                ["<tab>"]         = cb("select_next_entry"),
                ["<s-tab>"]       = cb("select_prev_entry"),
                ["gf"]            = cb("goto_file"),
                ["<C-w><C-f>"]    = cb("goto_file_split"),
                ["<C-w>gf"]       = cb("goto_file_tab"),
                ["<leader>e"]     = cb("focus_files"),
                ["<leader>b"]     = cb("toggle_files"),
            },
            option_panel = {
                ["<tab>"] = cb("select"),
                ["q"]     = cb("close"),
            },
        }
    }
    require('diffview').init()

    require("telescope").setup {
        pickers = {
            buffers = {
                show_all_buffers = true,
                sort_lastused = true,
                -- theme = "dropdown",
                -- previewer = false,
                mappings = {
                    i = {
                        ["<c-d>"] = "delete_buffer",
                    }
                }
            }
        }
    }

    require('telescope').load_extension('fzf')
    require'telescope'.load_extension('project')

    vim.opt.fillchars = vim.opt.fillchars + 'diff:╱'

    -- https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
    vim.cmd('inoremap <C-h> <C-\\><C-o>db')
    vim.cmd('inoremap <C-BS> <C-\\><C-o>db')

    -- https://vim.fandom.com/wiki/Searching#Case_sensitivity
    -- search should not strictly match case unless i use mixed case
    vim.cmd('set ignorecase')
    vim.cmd('set smartcase')

    -- require('spellsitter').setup()
    vim.cmd('autocmd FileType markdown setlocal spell')
    vim.cmd('autocmd FileType gitcommit setlocal spell')
    vim.cmd('autocmd FileType NeogitCommitMessage setlocal spell')
    -- https://vi.stackexchange.com/a/4003/38754
    -- don't spellcheck URLs in markdown files and similar
    vim.cmd([[autocmd FileType markdown syn match UrlNoSpell "\w\+:\/\/[^]] .. '[:space:]]' .. [[\+" contains=@NoSpell]])
    vim.cmd([[autocmd FileType NeogitCommitMessage syn match UrlNoSpell "\w\+:\/\/[^]] .. '[:space:]]' .. [[\+" contains=@NoSpell]])

    -- https://jdhao.github.io/2019/04/29/nvim_spell_check/
    -- vim.api.nvim_command("set spell")

    -- https://vi.stackexchange.com/a/27803/38754
    -- the default 'gx' to open links doesn't work.
    -- there are plugins..  https://github.com/felipec/vim-sanegx
    -- https://github.com/tyru/open-browser.vim
    -- https://gist.github.com/habamax/0a6c1d2013ea68adcf2a52024468752e
    -- but this seems KISS and functional
    vim.cmd('nmap gx :silent execute "!xdg-open " . shellescape("<cWORD>")<CR>')
    -- https://stackoverflow.com/questions/1533565/how-to-get-visually-selected-text-in-vimscript#comment10417791_1533565
    vim.cmd('vmap gx <Esc>:silent execute "!xdg-open " . shellescape(getline("\'<")[getpos("\'<")[2]-1:getpos(".")[2]]) . " &"<CR>')


    vim.cmd("let g:choosewin_label = '1234567890'")
    vim.cmd("let g:choosewin_tablabel = 'abcdefghijklmnop'")

    -- visible tab
    -- https://www.reddit.com/r/vim/comments/4hoa6e/what_do_you_use_for_your_listchars/
    vim.cmd("set list")
    vim.cmd("set listchars=tab:→\\ ,trail:·,nbsp:␣")

    -- disable completions in the telescope prompt.
    -- https://github.com/nvim-telescope/telescope.nvim/issues/161
    -- with cmp => autocmd FileType TelescopePrompt lua require('cmp').setup.buffer { enabled = false }
    vim.cmd("autocmd FileType TelescopePrompt call compe#setup({ 'source': { 'omni': v:true } }, 0)")

    -- customize ex mode completion, bash-like. C-y to accept match
    vim.cmd("set wildmode=longest:full,full")

    -- formatter, mhartington/formatter.nvim START
    require('formatter').setup({
        filetype = {
            rust = {
                -- Rustfmt
                function()
                    return {
                        exe = "rustfmt",
                        args = {"--emit=stdout"},
                        stdin = true
                    }
                end
            },
            json = {
                -- -- prettier
                -- function()
                --     return {
                --         exe = "prettier",
                --         args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote', '--parser', 'json'},
                --         stdin = true
                --     }
                -- end
                -- jq
                function()
                    return {
                        exe = "jq",
                        stdin = true
                    }
                end
            },
        }
    })
    vim.api.nvim_exec([[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.rs FormatWrite
    augroup END
    ]], true)
    -- formatter END
    
    -- for instance nginx configuration files
    vim.cmd('autocmd BufNewFile,BufRead *.conf set syntax=conf')
    vim.cmd('autocmd BufNewFile,BufRead *.conf.template set syntax=conf')
    vim.cmd('autocmd BufNewFile,BufRead *.yml.template set syntax=yaml')

    vim.g.glow_width = 100

    vim.cmd('au FileType * if (&ft ==? "cheat40") | setlocal signcolumn=no | endif')

    -- https://superuser.com/a/271024/214371
    -- when in comment fields, prepend the comment character
    -- on newline.
    -- in theory the auto_comment doom-nvim setting should set
    -- this up, but it doesn't seem to work...
    vim.cmd("set formatoptions+=cro")

    -- START lualine
    require('lualine').setup {
        options = { 
            disabled_filetypes = {
                'NeogitStatus', -- perf issues over sshfs
                'dashboard',
                'NvimTree',
                'Outline',
                'NeogitCommitMessage',
                'DiffviewFiles',
                'packer',
                'cheat40',
            },
            theme = 'nord',
            component_separators = '|',
            section_separators = { left = '', right = '' },
        }, 
        sections = {
            lualine_a = {
                { 'mode', separator = { left = '' }, right_padding = 2 },
            },
            -- lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {{'filename', path=1}}, -- path=1 => relative filename
            -- lualine_x = { 'encoding', 'fileformat', 'filetype'},
            -- don't color the filetype icon, else it's not always visible with the 'nord' theme.
            lualine_x = { 'filesize', {'filetype', colored = false}},
            lualine_y = {'progress'},
            -- lualine_z = {'location'}
            lualine_z = {
                { 'location', separator = { right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_a = {},
            lualine_b = {
                {'branch', separator = { left = ''}, color = {bg='#4c566a'}},
                {'diff', color = {bg='#4c566a'}},
                {'diagnostics', color = {bg='#4c566a'} },
                {function(str) return "" end, color = {fg='#4c566a'}, padding=0 }
            },
            lualine_c = {{'filename', path=1}}, -- path=1 => relative filename
            lualine_x = { 'filesize', {'filetype', colored = false}},
            lualine_y = {'progress'},
            lualine_z = {
                { 'location', separator = { left = '', right = '' }, left_padding = 2, color = {bg='#4c566a', fg='white'} },
            },
        },
    }
    -- END lualine

    -- this should be covered by lua/doom/extras/autocmds/init.lua but somehow
    -- I must add this here too.
    vim.cmd("au BufWinEnter,BufWritePost * lua require('lint').try_lint()")

    emmanuel_job_specific()
end
