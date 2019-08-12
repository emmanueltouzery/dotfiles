export TERM="xterm-256color"

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

POWERLEVEL9K_MODE='awesome-fontconfig'

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  export ZSH=/home/emmanuel/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="powerlevel9k/powerlevel9k"

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs dir_writable)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status command_execution_time)
POWERLEVEL9K_STATUS_VERBOSE=false

# POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
# POWERLEVEL9K_SHORTEN_DELIMITER=""
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
POWERLEVEL9K_SHORTEN_DELIMITER=".."
POWERLEVEL9K_SHORTEN_STRATEGY="Default"

#ZSH_THEME="bullet-train"
#
#BULLETTRAIN_PROMPT_ORDER=(
#  dir
#  git
#)
#BULLETTRAIN_PROMPT_SEPARATE_LINE=false
#BULLETTRAIN_PROMPT_CHAR=
#BULLETTRAIN_PROMPT_ADD_NEWLINE=false

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git mvn npm fasd zsh-autosuggestions history history-substring-search)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

POWERLEVEL9K_DIR_PATH_SEPARATOR="%F{black} $(print_icon 'LEFT_SUBSEGMENT_SEPARATOR') %F{black}"
# POWERLEVEL9K_HOME_FOLDER_ABBREVIATION="%k%F{white}~%F{blue}"
POWERLEVEL9K_HOME_FOLDER_ABBREVIATION=""

# https://github.com/zzrough/gs-extensions-drop-down-terminal/issues/57#issuecomment-170202054
# 0 is the text foreground color
# 2 is the git branch info back color
# 4 is the dir path back color
# tput initc 0 172 196 200
# tput initc 1 776 0 0
# tput initc 2 298 568 19
# tput initc 3 749 592 0
# tput initc 4 200 372 800
# tput initc 5 447 294 376
# tput initc 6 23 560 470
# tput initc 7 815 835 800
# tput initc 8 329 337 313
# tput initc 9 929 160 156
# tput initc 10 537 878 196
# tput initc 11 980 905 298
# tput initc 12 380 600 1000
# tput initc 13 992 243 886
# tput initc 14 203 878 854
# tput initc 15 905 909 901

# alternative
# tput initc 0 300 300 300
# tput initc 1 800 210 100
# tput initc 2 650 760 380
# tput initc 3 800 460 180
# tput initc 4 350 530 670
# tput initc 5 630 380 470
# tput initc 6 470 710 760
# tput initc 7 810 810 810
# tput initc 8 570 570 570
# tput initc 9 1000 280 200
# tput initc 10 720 710 0
# tput initc 11 1000 780 430
# tput initc 12 530 760 1000
# tput initc 13 820 820 1000
# tput initc 14 440 760 830
# tput initc 15 910 910 910

tput initc 0 172 196 200
tput initc 1 800 210 100
tput initc 2 220 560 220
tput initc 3 800 460 180
tput initc 4 350 530 670
tput initc 5 630 380 470
tput initc 6 470 710 760
tput initc 7 810 810 810
tput initc 8 570 570 570
tput initc 9 1000 280 200
tput initc 10 720 710 0
tput initc 11 1000 780 430
tput initc 12 530 760 1000
tput initc 13 820 820 1000
tput initc 14 440 760 830
tput initc 15 910 910 910

# https://unix.stackexchange.com/a/114243/36566
zstyle ':completion:*' special-dirs true


source $HOME/.zprofile
source $HOME/.oh-my-zsh/custom/plugins/zsh-you-should-use/you-should-use.plugin.zsh
source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
