HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000

setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Configure the push directory stack (most people don't need this)
setopt AUTO_PUSHD
setopt PUSHD_IGNORE_DUPS
setopt PUSHD_SILENT

# Emacs keybindings
bindkey -e

# Use the up and down keys to navigate the history
bindkey "\e[B" history-beginning-search-forward
# bindkey "\e[A" history-beginning-search-backward
# https://unix.stackexchange.com/a/690912/36566
function history-beginning-search-backward-end-of-line {
  # local original_buffer_length=$#BUFFER
  CURSOR=0
  zle history-beginning-search-backward
  # if ((original_buffer_length == 0)); then
    CURSOR=$#BUFFER
  # fi
}
zle -N history-beginning-search-backward-end-of-line
bindkey "\e[A" history-beginning-search-backward-end-of-line

# Ctrl binds
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
bindkey "^[[3~" delete-char
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line
# Bind Ctrl + Delete to delete word to the right
bindkey '^[[3;5~' kill-word
# Bind Ctrl + Backspace to delete word to the left
bindkey '^H' backward-kill-word # kitty
bindkey '^[[127;5u' backward-kill-word # neovim terminal
# Bind Ctrl + Right Arrow to move to the next word
bindkey '^[[1;5C' forward-word

# Move to directories without cd
setopt autocd

# Initialize completion
autoload -U compinit; compinit

alias gupa='git pull --rebase --autostash'
alias gst='git status'
alias gp='git push'
alias grhh='git reset --hard HEAD'

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Set up zoxide to move between folders efficiently
# eval "$(zoxide init zsh)"

# Set up the Starship prompt
eval "$(starship init zsh)"

# # Lines configured by zsh-newuser-install
# HISTFILE=~/.histfile
# HISTSIZE=10000
# SAVEHIST=10000
# bindkey -e
# # End of lines configured by zsh-newuser-install
# # The following lines were added by compinstall
# zstyle :compinstall filename '/home/emmanuel/.zshrc'
# 
# autoload -Uz compinit
# compinit
# # End of lines added by compinstall
# 
# eval "$(starship init zsh)"
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# https://github.com/emmanueltouzery/projectpad2
# shell integration for ppcli: control-space to run

# two options were considered so that we can add ppcli-run commands
# to the shell history:
# 1. creating a temporary file, give the path to ppcli, ppcli writes
#    the command that was run there
# 2. this approach: in shell integration mode, ppcli doesn't run
#    commands, but gives the shell all the info needed, and the
#    shell runs the commands and writes to the history
# I started with #2 and kept it as it was working OK.
ppcli-run() {
    output=$(ppcli --shell-integration)
    # split by NUL https://stackoverflow.com/a/2269760/516188
    pieces=( ${(ps.\0.)output} )
    case "$pieces[1]" in
        R) # R == run
            cur_folder=$(pwd)
            if [[ ! -z $pieces[3] ]]; then
               cmd="cd $pieces[3] && $pieces[2]"
            else
               cmd="$pieces[2]"
            fi
            echo -e "\e[3m$cmd\e[0m" # print with italics because it wasn't really _typed_
            print -s "$cmd" # https://stackoverflow.com/a/2816792/516188
            # need the </dev/tty and the stty so that ssh shells work
            # https://stackoverflow.com/questions/57539180/why-is-interactive-command-breaking-when-using-zsh-widget-to-execute-it#comment101556821_57539863
            # i need the printf to avoid ~0 and ~1 around pasting https://unix.stackexchange.com/a/196574/36566
            eval "stty sane; printf '\e[?2004l'; $cmd" </dev/tty
            cd $cur_folder
            # accept-line: give me a prompt, and that takes into account the
            # new history i've added with print -s (zle reset-prompt doesn't do that)
            zle && zle accept-line
            ;;
        P) # P == print to the prompt
            zle -U "$pieces[2]"
            ;;
        C) # C == Copy to the clipboard
            # https://stackoverflow.com/questions/42655304/how-do-i-check-if-a-variable-is-set-in-zsh/42655305
            if [[ -v WAYLAND_DISPLAY ]]; then
                wl-copy "$pieces[2]"
            else
                echo "$pieces[2]" | xsel --clipboard
            fi
            ;;
    esac
    if [[ ! -z "$pieces[4]" ]]; then
        echo "\n\nppcli has detected a new version is available.\nIt's recommended to upgrade by running:\n ppcli --upgrade\n new version URL: $pieces[4]"
    fi
}
zle -N ppcli-run
bindkey '^ ' ppcli-run

export EDITOR=nvim
