-- doom_config - Doom Nvim user configurations file
--
-- This file contains the user-defined configurations for Doom nvim and consists
-- in two Lua tables:
--   1. Doom, this one defines all the Doom nvim configurations that you can
--      tweak to fit your needs or tastes.
--
--   2. Nvim, this one defines all the custom configurations that you want to
--      use in Neovim, e.g. a colorscheme italic_comments global variable

-- {{{ Doom
local doom = {
  -- Autosave
  -- false : Disable autosave
  -- true  : Enable autosave
  -- @default = false
  autosave = false,

  -- Format on save
  -- false : Disable format on save
  -- true  : Enable format on save
  -- @default = false
  fmt_on_save = false,

  -- Disable Vim macros
  -- false : Enable Vim macros
  -- true  : Disable Vim macros
  -- @default = false
  disable_macros = false,

  -- Autosave sessions
  -- false : Disable session autosave
  -- true  : Enable session autosave
  -- @default = false
  autosave_sessions = false,

  -- Autoload sessions
  -- false : Disable session autoload
  -- true  : Enable session autoload
  -- @default = false
  autoload_last_session = false,

  -- Enable Swap files
  -- false : no swap files
  -- true  : enables swap files
  -- @default = false
  swap_files = false,

  -- Undo Directories
  -- the backup variable enables backup related settings (undofile, undodir)
  -- false : ignores undo Directories (this code block will be ignored)
  -- true  : enable undo files/undo dirs.
  -- @default = false
  backup = false, -- WARNING: if you change this to false and you have an undo dir already, it will REMOVE the undodir (loss of data might take place)

  -- Enable Line wrapping
  -- false : disables line wrapping
  -- true  : enables line wrapping
  -- @default = false
  line_wrap = false,

  -- Enable Show mode ( -- INSERT --, -- NORMAL --, -- VISUAL -- )
  -- false : disables show mode
  -- true  : enables show mode
  -- @default = false
  show_mode = false,

  -- Enable scroll off
  -- false : disables scroll off
  -- true  : enables scroll off
  -- @default = true, @default scrolloff_amount = 4,
  scrolloff = true,
  scrolloff_amount = 4,

  -- Enable mouse
  -- false : disables mouse
  -- true  : enables mouse
  -- @default = true
  mouse = true,

  -- Preserve last editing position
  -- false : Disable preservation of last editing position
  -- true  : Enable preservation of last editing position
  -- @default = false
  preserve_edit_pos = false,

  -- Allow overriding the default Doom Nvim keybinds
  -- false : Default keybinds cannot be overwritten
  -- true  : Default keybinds can be overwritten
  -- @default = true
  allow_default_keymaps_overriding = true,

  -- horizontal split on creating a new file (<Leader>fn)
  -- false : doesn't split the window when creating a new file
  -- true  : horizontal split on creating a new file
  -- @default = true
  new_file_split = false,

  -- enable current line highlight
  -- false : disables current line highlight
  -- true  : enables current line highlight
  -- @default = true
  line_highlight = true,

  -- Automatically split right
  -- false : splits right (vertically)
  -- true  : splits left (vertically)
  -- @default = true
  split_right = true,

  -- Automatically split above
  -- false : splits above (horizontally)
  -- true  : splits below (horizontally)
  -- @default = true
  split_below = true,

  -- Use clipboard outside of vim
  -- false : won't use third party clipboard
  -- true  : enables third part clipboard
  -- @default = true
  clipboard = true,

  -- Enable auto comment (current line must be commented)
  -- false : disables auto comment
  -- true  : enables auto comment
  -- @default = false
  auto_comment = false,

  -- Show indent lines
  -- @default = true
  show_indent = true,

  -- Expand tabs
  -- Specifies if spaces or tabs must be used
  -- false : spaces
  -- true  : tabs
  -- @default = true
  expand_tabs = true,

  -- Set numbering
  -- false : Shows absolute number lines
  -- true  : Shows relative number lines
  -- @default = true
  relative_num = true,

  -- Enable winwidth
  -- false : Manually set win width
  -- true  : Active window auto sets width
  -- @default = false, @default win_width_nr = 85
  win_width = false,
  win_width_nr = 85,

  -- Enable Highlight on yank
  -- false : disables highligh on yank
  -- true  : enables highlight on yank
  -- @default = true
  highlight_yank = true,

  -- Enable guicolors
  -- Enables gui colors on GUI versions of Neovim
  -- @default = true
  enable_guicolors = true,

  -- Tree explorer on the right
  -- Places the Tree explorer buffer to the right when enabled
  -- @default = false
  explorer_right = false,

  -- Show hidden files
  -- @default = true
  show_hidden = true,

  -- Checkupdates on start
  -- @default = false
  check_updates = false,

  -- Auto install plugins on launch, useful if you don't want to run
  -- PackerInstall every time you add a new plugin
  -- @default = true
  auto_install_plugins = true,

  -- Disable dashboard status line (does not work perfectly)
  -- false : disables dashboard status line
  -- true  : enables dashboard status line
  -- @default = true
  dashboard_statline = true,

  -- Default indent size
  -- @default = 4
  indent = 4,

  -- Set max cols
  -- Defines the column to show a vertical marker
  -- @default = 80
  max_columns = 80,

  -- Completion box height
  -- @default = 10
  complete_size = 10,

  -- Completion box transparency
  -- 0 = no transparency
  -- 100 = fully transparent
  -- @default = 25
  complete_transparency = 25,

  -- Sidebar sizing
  -- Specifies the default width of Tree Explorer and Tagbar
  -- @default = 25
  sidebar_width = 25,

  -- Set the Terminal width
  -- Applies only to float direction
  -- @default = 70
  terminal_width = 70,

  -- Set the Terminal height
  -- Applies to all directions except window
  -- @default = 20
  terminal_height = 20,

  -- Conceal level
  -- Set Neovim conceal level
  -- 0 : Disable indentline and show all
  -- 1 : Conceal some functions and show indentlines
  -- 2 : Concealed text is completely hidden unless it has a custom replacement
  --     character defined
  -- 3 : Concealed text is completely hidden
  conceallevel = 0,

  -- Logging level
  -- Set Doom logging level
  -- Available levels:
  --   · trace
  --   · debug
  --   · info
  --   · warn
  --   · error
  --   · fatal
  -- @default = 'info'
  logging = "info",

  -- Set the Terminal direction
  -- Available directions:
  --   - vertical
  --   - horizontal
  --   - window
  --   - float
  -- @default = 'horizontal'
  terminal_direction = "horizontal",

  -- NOTE: This will only be activated if 'backup' is true.
  -- We don'recommend you put this outside of neovim so we've restricted to the path: ~/.config/nvim
  -- WARNING: only put the folder name that you want. (eg: undo_dir = '/undodir')
  -- @default_directory = '~/.config/nvim/undodir'
  undo_dir = "/undodir",

  -- Default colorscheme
  -- @default = doom-one
  colorscheme = "doom-one",

  -- Background color
  -- @default = dark
  colorscheme_bg = "dark",

  -- Doom One colorscheme settings
  doom_one = {
    -- If the cursor color should be blue
    -- @default = false
    cursor_coloring = false,
    -- If TreeSitter highlighting should be enabled
    -- @default = true
    enable_treesitter = true,
    -- If the comments should be italic
    -- @default = false
    italic_comments = false,
    -- If the telescope plugin window should be colored
    -- @default = true
    telescope_highlights = true,
    -- If the built-in Neovim terminal should use the doom-one
    -- colorscheme palette
    -- @default = false
    terminal_colors = true,
    -- If the Neovim instance should be transparent
    -- @default = false
    transparent_background = false,
  },

  -- Set gui fonts here
  -- @default = "FiraCode Nerd Font", @default font size = 15,
  -- WARNING: Font sizes must be in string format!
  guifont = "FiraCode Nerd Font",
  guifont_size = "10.5",

  -- change Which Key background color
  -- can use hex, or normal color names (eg: Red, Gree, Blue)
  -- @default = #202328
  whichkey_bg = "#202328",

  -- set your custom lsp diagnostic symbols below
  lsp_error = "",
  lsp_warning = "",
  lsp_hint = "",
  lsp_information = "",
  lsp_virtual_text = " ",

  -- Set your dashboard custom colors below
  -- @default = doom emacs' default dashboard colors
  dashboard_custom_colors = {
    header_color = "#586268",
    center_color = "#51afef",
    shortcut_color = "#a9a1e1",
    footer_color = "#586268",
  },

  -- Set your custom dashboard header below
  -- @default = doom emacs' default dashboard header
  dashboard_custom_header = {},
}
-- }}}

function _G.my_open_tele()
    local w = vim.fn.expand('<cword>')
    -- require('telescope.builtin').live_grep()
    require("telescope").extensions.live_grep_raw.live_grep_raw()
    vim.fn.feedkeys(w)
end

-- https://vi.stackexchange.com/a/3749/38754
function open_file_branch(branch, fname)
    vim.api.nvim_command('new')
    vim.api.nvim_exec('silent r! git show ' .. branch .. ':' .. fname, false)
    vim.api.nvim_command('1d')
    local fname_without_path = fname:match( "([^/]+)$")
    vim.api.nvim_exec('silent file [' .. branch .. '] ' .. fname_without_path, false)
    vim.api.nvim_command('filetype detect')
    vim.api.nvim_command('setlocal readonly')
    vim.bo.readonly = true
    vim.bo.modified = false
    vim.bo.modifiable = false
end

function get_relative_fname()
    local fname = vim.fn.expand('%:p')
    return fname:gsub(vim.fn.getcwd() .. '/', '')
end

function pick_file_from_branch(branch)
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local opts = {}
    local relative_fname = get_relative_fname()
    opts.initial_model = 'insert'
    pickers.new(opts, {
        prompt_title = "filename",
        finder = finders.new_oneshot_job { "git", "ls-tree", "-r", "--name-only", branch, opts },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
            actions.select_default:replace(function()
              actions.close(prompt_bufnr)
              local selection = action_state.get_selected_entry()
              -- open fugitive for that branch and filename
              -- vim.cmd('Gedit ' .. branch .. ':' .. selection[1])
              open_file_branch(branch, selection[1])
            end)
            return true
        end,
    }):find()
    -- the file picker is not insert mode.. possibly it's reusing the picker
    -- from the previous branch picker... switch to insert mode (i), then
    -- enter the current filename. Couldn't find how to set the picker default
    -- entry text otherwise -- did ask on the telescope gitter, no answer.
    vim.fn.feedkeys('i' .. relative_fname)
end

function _G.open_file_git_branch()
    -- https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/builtin/git.lua#L269
    local pickers = require "telescope.pickers"
    local finders = require "telescope.finders"
    local conf = require("telescope.config").values
    local actions = require "telescope.actions"
    local action_state = require "telescope.actions.state"
    local opts = {}

    pickers.new(opts, {
        prompt_title = "branch",
        finder = finders.new_oneshot_job { "git", "branch", opts },
        sorter = conf.generic_sorter(opts),
        attach_mappings = function(prompt_bufnr, map)
          actions.select_default:replace(function()
            actions.close(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            local branch = selection[1]:sub(3)
            pick_file_from_branch(branch)
          end)
          return true
        end,
    }):find()
end

function parse_blame_record(lines, i)
    local record = {}
    record.sha = lines[i]:sub(1, 40)
    i = i + 1
    while lines[i] and not lines[i]:match('^\t') do
        local l = lines[i]
        if l:match('^author ') then
            record.author = l:sub(8)
        -- for some reason author-time doesn't match, so i put a dot
        elseif l:match('^author.time ') then 
            record.date = os.date('*t', l:sub(13))
        end
        i = i + 1
    end
    i = i + 1
    return i, record
end

-- generated through https://medialab.github.io/iwanthue/
-- H 0-360
-- C 30-80
-- L 5-100
COLORS = {
    "#7971fd", "#f759d4", "#ffdb72", "#62438d", "#5b6700", "#7cb3ff", "#01d890", "#fdbbff",
    "#bfffa3", "#01a4a2", "#005baf", "#afffd8", "#db0051", "#f6ab06", "#276e00", "#ffcd9f",
    "#01b039", "#902871", "#017eef", "#ff6943", "#fa2f98", "#3643bf", "#d60996", "#66501f",
    "#f0ff5f", "#ff86d2", "#9d2326", "#ba9600", "#01cce4", "#008554", "#00feed", "#9eab00",
    "#d2dc2d",
}

function render_blame_sidebar(results)
    local fname = vim.fn.expand('%:p')
    vim.api.nvim_command('leftabove 30 vnew')
    local i = 1
    while COLORS[i] do
        vim.api.nvim_command("highlight BLAME_COL" .. i .. " guifg=" .. COLORS[i])
        i = i + 1
    end
    i = 1
    local prev_row
    local prev_color
    local sha_to_highlight = {}
    local last_color = 1
    while results[i] do
        local r = results[i]
        if r['author'] ~= nil then
            prev_row = string.format('%02d-%02d-%02d %s',
                r.date.year, r.date.month, r.date.day, r.author)

            if sha_to_highlight[r.sha] == nil then
                sha_to_highlight[r.sha] = "BLAME_COL" .. (last_color % #COLORS)
                last_color = last_color + 1
            end
            prev_color = sha_to_highlight[r.sha]
                
        end
        vim.fn.append('$', prev_row)
        vim.api.nvim_buf_add_highlight(0, -1, prev_color, i, 0, -1)
        i = i + 1
    end
    vim.api.nvim_command('0delete')
    vim.api.nvim_command('setlocal readonly')
    vim.api.nvim_command('set nowrap')
    vim.api.nvim_command('set nonumber')
    vim.api.nvim_command('set norelativenumber')
    local fname_without_path = fname:match( "([^/]+)$")
    vim.api.nvim_exec('silent file [blame] ' .. fname_without_path, false)
    vim.bo.readonly = true
    vim.bo.modified = false
    vim.bo.modifiable = false
end

-- https://www.reddit.com/r/vim/comments/9ydreq/vanilla_solutions_to_git_blame/ea1sgej/
function position_blame_sidebar()
    vim.api.nvim_command('set scrollbind')
    vim.api.nvim_command('wincmd p')
    vim.api.nvim_command('set scrollbind')
end

function handle_blame(lines)
    local i = 1
    local results = {}
    while lines[i] do
        i, line_info = parse_blame_record(lines, i)
        table.insert(results, line_info)
    end
    render_blame_sidebar(results)
    position_blame_sidebar()
end

function _G.git_blame()
    local relative_fname = get_relative_fname()
    local Job = require'plenary.job'
    local output = {}
    Job:new {
        command = 'git',
        -- i think -p only would be maybe faster, git's output differs with
        -- -p or --line-porcelain! I mean I see different authors for different
        -- lines between these flags. And everyone matches with --line-porcelain.
        -- Also, -w, ignore whitespace, is nice, and intellij does it, but
        -- gitsigns doesn't, and i'd like to match with gitsigns.
        -- args = {'blame', relative_fname, '--line-porcelain', '-w'},
        args = {'blame', relative_fname, '--line-porcelain'},
        on_stdout = function(error, data, self)
            table.insert(output, data)
        end,
        on_exit = function(self, code, signal)
            vim.schedule_wrap(function()
                handle_blame(output)
            end)()
        end
    }:start()
end

function _G.git_blame_close()
    local fname = vim.fn.expand('%:p')
    local fname_without_path = fname:match("([^/]+)$")
    local last_buf_id = vim.fn.bufnr('$')
    local i = 1
    while i <= last_buf_id do
        if vim.fn.bufexists(i) and vim.fn.bufname(i):find('^%[blame%] ' .. fname_without_path) ~= nil then
            vim.api.nvim_command("bd " .. i)
            i = last_buf_id + 1
        end
        i = i + 1
    end
end

function open_time_machine()
    vim.api.nvim_exec('silent r! git show ' .. branch .. ':' .. fname, false)
    vim.api.nvim_command('1d')
    local fname_without_path = fname:match( "([^/]+)$")
    vim.api.nvim_exec('silent file [' .. branch .. '] ' .. fname_without_path, false)
    vim.api.nvim_command('filetype detect')
    vim.api.nvim_command('setlocal readonly')
    vim.bo.readonly = true
    vim.bo.modified = false
    vim.bo.modifiable = false
end

local Str = require'plenary.strings'

function force_length(msg, len)
    if Str.strdisplaywidth(msg) > len then
        return Str.truncate(msg, len)
    else
        return Str.align_str(msg, len, false)
    end
end

function statusline_escape(msg)
    return msg:gsub(' ', '\\ '):gsub('"', '\\"')
end

function time_machine_statusline(i)
    local record = vim.b.time_machine_entries[i]
    vim.api.nvim_command('set laststatus=2')
    vim.api.nvim_command('set statusline=')
    vim.api.nvim_command('set statusline+=%#StatusLineNC#')
    vim.api.nvim_command('set statusline+=['  .. (#vim.b.time_machine_entries + 1 - i) .. '\\/' .. #vim.b.time_machine_entries .. ']')
    vim.api.nvim_command('set statusline+=%#Title#')
    vim.api.nvim_command('set statusline+=\\ ' .. statusline_escape(force_length(record.author, 18)))
    vim.api.nvim_command('set statusline+=\\ ')
    vim.api.nvim_command('set statusline+=%#TabLineSel#')
    vim.api.nvim_command('set statusline+=' .. statusline_escape(force_length(record.message, 50)))
    vim.api.nvim_command('set statusline+=%#TabLine#')
    vim.api.nvim_command('set statusline+=\\ ' .. record.date:gsub(' ', '\\ ') .. '\\ ')
    vim.api.nvim_command('set statusline+=%#StatusLineNC#')
    vim.api.nvim_command('set statusline+=<c-p>\\ Previous\\ \\|\\ <c-n>\\ Next\\ \\|\\ <c-y>\\ Copy\\ commit\\ SHA\\ \\|\\ [q]uit')
end

function git_time_machine_display()
    local i = vim.b.time_machine_cur_idx
    time_machine_statusline(i)
end

function _G.git_time_machine_next()
    if vim.b.time_machine_cur_idx > 1 then
        vim.b.time_machine_cur_idx = vim.b.time_machine_cur_idx - 1
    end
    git_time_machine_display()
end

function _G.git_time_machine_previous()
    if vim.b.time_machine_cur_idx < #vim.b.time_machine_entries then
        vim.b.time_machine_cur_idx = vim.b.time_machine_cur_idx + 1
    end
    git_time_machine_display()
end

function parse_time_machine_record(lines, i)
    if lines[i]:sub(1, 7) ~= "commit " then
        error("Expected 'commit', got " .. lines[i])
    end
    local record = {}
    record.sha = lines[i]:sub(8)
    i = i + 1
    record.author = lines[i]:sub(9):gsub(' <.*$', '')
    i = i + 1
    record.date = lines[i]:sub(9, 24)
    i = i + 2
    record.message = lines[i]:sub(5)
    while i <= #lines and lines[i]:sub(1, 7) ~= 'commit ' do
        i = i + 1
    end
    return i, record
end

function handle_time_machine(lines)
    local i = 1
    local results = {}
    while lines[i] do
        i, line_info = parse_time_machine_record(lines, i)
        table.insert(results, line_info)
    end
    vim.b.time_machine_entries = results
    vim.b.time_machine_cur_idx = 1
    _G.git_time_machine_next()
end

-- 'git log --no-merges -- afc/pom.xml'
function _G.git_time_machine()
    local relative_fname = get_relative_fname()
    vim.api.nvim_command('new')
    vim.api.nvim_command('nnoremap <buffer> <c-p> :lua git_time_machine_previous()<CR>')
    vim.api.nvim_command('nnoremap <buffer> <c-n> :lua git_time_machine_next()<CR>')
    vim.api.nvim_command('nnoremap <buffer> <c-y> :lua git_time_machine_copy_sha()<CR>')
    vim.api.nvim_command('nnoremap <buffer> q :lua git_time_machine_quit()<CR>')
    local Job = require'plenary.job'
    local output = {}
    Job:new {
        command = 'git',
        -- i'd really want a plumbing command here, but i think there isn't one
        -- https://stackoverflow.com/a/29239964/516188
        args = {'log', '--no-merges', '--follow', '--date=iso', '--', relative_fname},
        on_stdout = function(error, data, self)
            table.insert(output, data)
        end,
        on_exit = function(self, code, signal)
            vim.schedule_wrap(function()
                handle_time_machine(output)
            end)()
        end
    }:start()
end

-- {{{ Nvim
local nvim = {
  -- Set custom Neovim global variables
  -- @default = {}
  -- example:
  --   { ['sonokai_style'] = 'andromeda' }
  global_variables = {},

  -- Set custom autocommands
  -- @default = {}
  -- example:
  --   augroup_name = {
  --      { 'BufNewFile,BufRead', 'doomrc', 'set ft=lua'}
  --   }
  autocmds = {},

  -- Set custom key bindings
  -- @default = {}
  -- example:
  --   {
  --      {'n', 'ca', ':Lspsaga code_action<CR>', options}
  --   }
  --
  --   where
  --     'n' is the map scope
  --     'ca' is the map activator
  --     ':Lspsaga ...' is the command to be executed
  --     options is a Lua table containing the mapping options, e.g.
  --     { silent = true }, see ':h map-arguments'.
  mappings = {
        -- https://www.reddit.com/r/neovim/comments/ook0o6/how_to_paste_current_word_under_the_cursor_to/h5zefzo/
        -- {'n', 'M', "':Telescope find_files<cr>' . expand('<cword>')", {}}
        {'n', 'M', ':lua my_open_tele()<cr>', {}},
        {'n', 'P', ':lua open_file_git_branch()<cr>', {}},
        {'n', 'ćp', '<Cmd>lua require("gitsigns").prev_hunk()<CR>', {}},
        {'n', 'ćn', '<Cmd>lua require("gitsigns").next_hunk()<CR>', {}},
        {'n', '-', '<Cmd>ChooseWin<CR>', {}}
    },

  -- Set custom commands
  -- @default = {}
  -- example:
  --   {
  --      'echo "Hello, custom commands!"'
  --   }
  commands = {},

  -- Set custom functions
  -- @default = {}
  -- example:
  --   {
  --      hello_custom_func = function()
  --        print("Hello, custom functions!")
  --      end
  --   }
  functions = {
     init_komments = function()
        require('kommentary.config').configure_language("default", {
            prefer_single_line_comments = true,
        })
     end
  },

  -- Set custom options
  -- @default = {}
  -- example:
  --   {
  --      ['shiftwidth'] = 4
  --   }
  options = {},
}
-- }}}

-- i want a wider space for file names (for instance with
-- java projects having tons of subfolders). Also the preview
-- is not super useful when opening files
require('telescope').setup {
    pickers = {
    	find_files = {
    	    layout_strategy='vertical',layout_config={width=0.6}
    	}
    }
}

require('telescope').load_extension('fzf')

require('neogit').setup {
  signs = {
    -- { CLOSED, OPENED }
    section = { "▶", "▼" },
    item = { "▶", "▼" },
    hunk = { "", "" },
  }
}

-- https://vim.fandom.com/wiki/Map_Ctrl-Backspace_to_delete_previous_word
vim.cmd('inoremap <C-h> <C-\\><C-o>dB')
vim.cmd('inoremap <C-BS> <C-\\><C-o>db')

return {
  doom = doom,
  nvim = nvim,
}

-- vim: fdm=marker
