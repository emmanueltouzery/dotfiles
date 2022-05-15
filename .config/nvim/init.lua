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

function _G.select_current_qf(also_print)
    local qf_entries = vim.fn.getqflist()
    local i = 1
    local cur_text = ""
    while qf_entries[i] do
        local qf_entry = qf_entries[i]
        if qf_entry.lnum == 0 then
            cur_text = cur_text .. "\n" .. qf_entry.text
        elseif qf_entry.lnum == vim.fn.line('.') and qf_entry.bufnr == vim.fn.bufnr() then
            if also_print then
                print(cur_text)
            end
            vim.cmd(":cc " .. i)
            cur_text = ""
        else
            -- new message, reset
            cur_text = ""
        end
        i = i+1
    end
end

function _G.get_file_line()
    local file_path = vim.fn.expand("%")
    local line = vim.fn.line(".")
    return "`" .. file_path .. ":" .. line .. "`"
end

function _G.copy_file_line()
    local to_copy = get_file_line()
    vim.cmd("let @+ = '" .. to_copy .. "'")
    print(to_copy)
end

function _G.get_file_line_sel()
    local file_path = vim.fn.expand("%")
    local start_line = vim.fn.getpos("v")[2]
    local end_line = vim.fn.getcurpos()[2]
    -- local start_line = vim.fn.line("'<")
    -- local end_line = vim.fn.line("'>")
    return "`" .. file_path .. ":" .. start_line .. "-" .. end_line .. "`"
end

function _G.copy_file_line_sel()
    local to_copy = get_file_line_sel()
    vim.cmd("let @+ = '" .. to_copy .. "'")
    print(to_copy)
end

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

function _G.ShowCommitAtLine()
    local commit_sha = require"agitator".git_blame_commit_for_line()
    vim.cmd("DiffviewOpen " .. commit_sha .. "^.." .. commit_sha)
end

function is_diff_line(line_no)
    -- https://www.reddit.com/r/vim/comments/k2r7b/how_do_i_execute_a_command_on_all_differences_in/c2hee5z/
    -- https://stackoverflow.com/a/20010859/516188
    return vim.fn.diff_hlID(line_no, 1) > 0
end

function diff_get_start_end_line()
    -- https://vi.stackexchange.com/a/36854/38754
    local line = vim.fn.line(".")
    local startline = line
    while (is_diff_line(startline - 1))
    do
        startline = startline - 1
    end
    local endline = line
    while (is_diff_line(endline + 1))
    do
        endline = endline + 1
    end
    return startline, endline
end

function diffget_and_keep(put_after)
    -- switch to other window
    vim.cmd('wincmd l')
    local startline_other, endline_other = diff_get_start_end_line()
    -- go to the start line of the hunk to simplify things
    -- vim.fn.feedkeys(startline .. 'G')
    -- yank relevant lines into register f
    vim.cmd(startline_other .. ',' .. endline_other .. 'y f')

    -- back to where i was
    vim.cmd('wincmd h')

    local startline_here, endline_here = diff_get_start_end_line()

    if put_after then
        -- to paste after, we must move to the end of the block
        local hunk_lines = endline_here - startline_here
        for i=1,hunk_lines do
            vim.fn.feedkeys('j')
        end
        vim.fn.feedkeys('"fp')
    else
        vim.fn.feedkeys('k"fp')
    end
end

function _G.diffget_and_keep_before()
    diffget_and_keep(false)
end

function _G.diffget_and_keep_after()
    diffget_and_keep(true)
end

function emmanuel_job_specific()
    -- https://stackoverflow.com/a/14407121/516188
    -- two space indent for job stuff
    vim.cmd("au BufRead,BufNewFile,BufEnter /home/emmanuel/projects/* setlocal sw=2")

    vim.cmd("let g:test#elixir#exunit#options = { 'all': '--warnings-as-errors'}")
end

function emmanuel_init()

    -- workaround for "Read errors" on C-g when opening ts/tsx files
    -- and plain errors on ":e test.ts" with 0.5.1
    -- vim.cmd("TSDisableAll highlight typescript")

    -- vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 's', 'S', 'x', 'X', 'y', 'Y']")
    -- drop s and S due to lightspeed
    vim.cmd("let g:yankstack_yank_keys = ['c', 'C', 'd', 'D', 'x', 'X', 'y', 'Y']")
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

    require'lightspeed'.setup {
        ignore_case = true,
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

    -- word-wrapping in markdown files
    vim.cmd('autocmd FileType markdown setlocal wrap linebreak')

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

    -- customization for https://github.com/samoshkin/vim-mergetool
    vim.cmd("nmap <expr> db &diff? ':lua diffget_and_keep_before()<cr>' : 'db'")
    vim.cmd("nmap <expr> da &diff? ':lua diffget_and_keep_after()<cr>' : 'da'")

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
                function()
                    return {
                        exe = "jq",
                        stdin = true
                    }
                end
            },
            javascript = {
                -- prettier
                function()
                    return {
                        exe = "~/.asdf/shims/prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
                        stdin = true
                    }
                end
            },
            javascriptreact = {
                -- prettier
                function()
                    return {
                        exe = "~/.asdf/shims/prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
                        stdin = true
                    }
                end
            },
            typescript = {
                -- prettier
                function()
                    return {
                        exe = "~/.asdf/shims/prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
                        stdin = true
                    }
                end
            },
            typescriptreact = {
                -- prettier
                function()
                    return {
                        exe = "~/.asdf/shims/prettier",
                        args = {"--stdin-filepath", vim.fn.fnameescape(vim.api.nvim_buf_get_name(0)), '--single-quote'},
                        stdin = true
                    }
                end
            },
        }
    })

    -- absolutely ABOMINABLE HACK to avoid losing cursor position when reindent
    -- occurs and i have the same file in multiple windows.
    -- https://github.com/mhartington/formatter.nvim/issues/22
    -- I believe switching to null-ls for reindentation should fix this
    -- properly, but I didn't manage to switch for prettier for now.

    function _G.save_scrollpos_if_file(fname, winnr)
        if vim.fn.expand('%:p') == fname and vim.fn.winnr() ~= winnr then
            local p = vim.fn.getcurpos()
            if p[2] ~= 1 then
                vim.w.scroll_save_pos = vim.fn.winsaveview()
            end
        end
    end

    function _G.restore_scrollpos_if_file(fname, winnr)
        if vim.fn.expand('%:p') == fname and vim.fn.winnr() ~= winnr then
            vim.fn.winrestview(vim.w.scroll_save_pos)
        end
    end
    
    function _G.format_safe()
        local fname=vim.fn.expand('%:p')
        local winnr=vim.fn.winnr()
        vim.cmd('windo lua save_scrollpos_if_file("' .. fname .. '", ' .. winnr .. ')')
        vim.cmd(winnr .. 'wincmd w')
        vim.cmd("FormatWrite")
        vim.cmd('windo lua restore_scrollpos_if_file("' .. fname .. '", ' .. winnr .. ')')
        vim.cmd(winnr .. 'wincmd w')
    end

    -- end HACK. Without the hack, put FormatWrite instead of 'lua format_safe'
    -- in the next block.

    vim.api.nvim_exec([[
    augroup FormatAutogroup
    autocmd!
    autocmd BufWritePost *.rs lua format_safe()
    autocmd BufWritePost *.js lua format_safe()
    autocmd BufWritePost *.jsx lua format_safe()
    autocmd BufWritePost *.ts lua format_safe()
    autocmd BufWritePost *.tsx lua format_safe()
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
    local function winnr()
        local nr = vim.fn.winnr()
        if nr == 1 then return ''
        elseif nr == 2 then return ''
        elseif nr == 3 then return ''
        elseif nr == 4 then return ''
        elseif nr == 5 then return ''
        elseif nr == 6 then return ''
        elseif nr == 7 then return ''
        elseif nr == 8 then return ''
        elseif nr == 9 then return ''
        else return ''
        end
    end

    local function project()
        return vim.fn.getcwd():match("[^/]+$");
    end

    function _G.toggle_comment_custom_commentstring_curline()
        startline = vim.fn.line('.')
        endline = vim.fn.line('.')
        _G.toggle_comment_custom_commentstring(startline, endline)
    end

    function _G.toggle_comment_custom_commentstring_sel()
        local startline = vim.fn.line("'<")
        local endline = vim.fn.line("'>")
        _G.toggle_comment_custom_commentstring(startline, endline)
    end

    -- https://github.com/b3nj5m1n/kommentary/issues/11
    --[[ This is our custom function for toggling comments with a custom commentstring,
    it's based on the default toggle_comment, but before calling the function for
    toggling ranges, it sets the commenstring to something else. After it is done,
    it sets it back to what it was before. ]]
    function _G.toggle_comment_custom_commentstring(startline, endline)
        -- Save the current value of commentstring so we can restore it later
        local commentstring = vim.bo.commentstring
        -- Set the commentstring for the current buffer to something new
        vim.bo.commentstring =  "{/*%s*/}"
        --[[ Call the function for toggling comments, which will resolve the config
        to the new commentstring and proceed with that. ]]
        require('kommentary.kommentary').toggle_comment_range(startline, endline,
        require('kommentary.config').get_modes().normal)
        -- Restore the original value of commentstring
        vim.api.nvim_buf_set_option(0, "commentstring", commentstring)
    end

    -- https://stackoverflow.com/a/34953646/516188
    function escape_pattern(text)
        return text:gsub("([^%w])", "%%%1")
    end

    -- lualine's builtin filename function breaks down for non-focused
    -- windows. instead of showing the relative path in the module, it
    -- shows the relative path from the home dir... do it by hand.
    local function inactiveRelativePath()
        return vim.fn.expand('%:p'):gsub(escape_pattern(vim.fn.getcwd()) .. "/", "")
    end

    local function scroll_indicator()
        local current_line = vim.fn.line('w0')
        local current_bottom_line = vim.fn.line('w$')
        local total_lines = vim.fn.line('$')
        local scroll_ratio = current_line / total_lines
        local height = vim.fn.winheight(0)
        local display_ratio = height / total_lines
        local display_ratio_step1 = 0.10
        local display_ratio_step2 = 0.25
        if height >= total_lines then
            return "⣿⣿"
        end
        if display_ratio < display_ratio_step1 then
            -- indicator is 1 row tall
            if current_line == 1 then
                return "⠉⠉"
            elseif scroll_ratio < 0.4 then
                return "⠒⠒"
            elseif current_bottom_line < total_lines then
                return "⠤⠤"
            else
                return "⣀⣀"
            end
        elseif display_ratio < display_ratio_step2 then
            -- indicator is 2 rows tall
            if current_line == 1 then
                return "⠛⠛"
            elseif current_bottom_line < total_lines then
                return "⠶⠶"
            else
                return "⣤⣤"
            end
        else 
            -- indicator is 3 rows tall
            if scroll_ratio < 0.4 then
                return "⠿⠿"
            else
                return "⣶⣶"
            end
        end
    end

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
                { winnr, padding = 0, separator = { left = '' }},
                { 'mode', fmt = function(str) return str:sub(1,3) end , separator = {left=nil, right=''} },
            },
            -- lualine_a = {'mode'},
            lualine_b = {'branch', 'diff', 'diagnostics'},
            lualine_c = {project, {'filename', path=1}}, -- path=1 => relative filename
            -- lualine_x = { 'encoding', 'fileformat', 'filetype'},
            -- don't color the filetype icon, else it's not always visible with the 'nord' theme.
            lualine_x = { 'filesize', {'filetype', colored = false, icon_only = true}},
            lualine_y = {'progress', scroll_indicator},
            -- lualine_z = {'location'}
            lualine_z = {
                { 'location', separator = { right = '' }, left_padding = 2 },
            },
        },
        inactive_sections = {
            lualine_b = {
                {winnr, separator = { left = ''}, color = {bg='#4c566a'}},
                {'branch', color = {bg='#4c566a'}},
                {'diff', color = {bg='#4c566a'}},
                {'diagnostics', color = {bg='#4c566a'} },
                {function(str) return "" end, color = {fg='#4c566a'}, padding=0 }
            },
            lualine_c = {project, inactiveRelativePath},
            lualine_x = { 'filesize', {'filetype', colored = false, icon_only = true}},
            lualine_y = {'progress', scroll_indicator},
            lualine_z = {
                { 'location', separator = { left = '', right = '' }, left_padding = 2, color = {bg='#4c566a', fg='white'} },
            },
        },
    }
    -- END lualine

    -- this should be covered by lua/doom/extras/autocmds/init.lua but somehow
    -- I must add this here too.
    vim.cmd("au BufWinEnter,BufWritePost * lua require('lint').try_lint()")

-- require("lspconfig")["null-ls"].setup({
--   -- add to a specific server's on_attach,
--   -- or to a common on_attach callback to enable for all supported filetypes
--   on_attach = function(client)
--       if client.resolved_capabilities.document_formatting then
--           vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
--       end
--   end
-- })
    vim.cmd [[autocmd BufWritePre *.ex lua vim.lsp.buf.formatting_sync()]]
    vim.cmd [[autocmd BufWritePre *.exs lua vim.lsp.buf.formatting_sync()]]

    -- https://github.com/b3nj5m1n/kommentary/issues/11
    vim.api.nvim_set_keymap('n', 'gCC', '<cmd>lua toggle_comment_custom_commentstring_curline()<cr>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', 'gC', ':<C-u>lua toggle_comment_custom_commentstring_sel()<cr>', { noremap = true, silent = true })

  -- https://github.com/mfussenegger/nvim-lint/pull/196/files
  require('lint').linters.credo = {
      cmd = 'mix',
      stdin = true,
      args = { 'credo', 'list', '--format=oneline', '--read-from-stdin' },
      stream = 'stdout',
      ignore_exitcode = true, -- credo only returns 0 if there are no errors
      parser = require('lint.parser').from_errorformat('[%t] %. %f:%l:%c %m, [%t] %. %f:%l %m')
  }

  require("lint").linters_by_ft = {
    sh = {"shellcheck"},
    elixir = {"credo"},
  }

  require"gitlinker".setup({
      opts = {
          action_callback = function(url)
              local human_readable_url = ''
              if vim.fn.mode() == 'n' then
                  human_readable_url = _G.get_file_line()
              else
                  human_readable_url = _G.get_file_line_sel()
              end

              vim.api.nvim_command('let @+ = \'' .. human_readable_url .. ' ' .. url .. '\'')
          end,
      },
      callbacks = {
          ["gitlab.*"] = require"gitlinker.hosts".get_gitlab_type_url
      },
      -- default mapping to call url generation with action_callback
      mappings = "<leader>gy"
  })

  emmanuel_job_specific()
end
