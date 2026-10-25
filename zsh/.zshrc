# oh-my-zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-vi-mode)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# vi mode
bindkey -v

# Environment Variables
export PATH=/bin:/usr/bin:/usr/.local/bin:/sbin:/home/obathily/.local/bin/:/home/obathily/bin:${PATH}
export PATH=/home/obathily/.cargo/bin/:${PATH}
export CURL_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export REQUESTS_CA_BUNDLE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_FILE="/etc/ssl/certs/ca-certificates.crt"
export SSL_CERT_DIR="/etc/ssl/certs/"
export EDITOR="nvim"
export LS_COLORS=$LS_COLORS:'ow=1;34:'
export PATH=$PATH:/usr/local/go/bin

# Switch Theme

alias ats="althemer"

# Open Java GUI Apps with Sway
export WM_NAME="LG3D"
export _JAVA_AWT_WM_NONREPARENTING=1

# Basic

alias c="clear"
alias ll="ls -la"
alias shn="shutdown -h now"
alias pp="xclip -sel clip"
nv() {
  nvim "${@:-.}"
}


# Shell

alias zi="nvim ~/.zshrc"
alias rld="exec zsh"
eval "$(direnv hook zsh)"

# CD's

alias cdc="cd ~/.config/"
alias cdt="cd ~/Téléchargements"
alias cdd="cd ~/dev"
alias cdn="cd ~/.config/nvim"


# PYTHON

alias pip="python -m pip"
pv() {
  eval $(poetry env activate)
}

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# TMUX

alias tm="tmux"
alias tx="tmuxinator"
alias tmc="nvim ~/.tmux.conf"
alias txc="nvim ~/.config/tmuxinator"
alias tks="tmux kill-server"
alias txs="tx stop"

# Docker

alias dps="docker ps"
alias dpsa="dps -a"
alias dsa="docker stop $(docker ps -qa)"
alias dcub="docker compose up --build"
alias dcu="docker compose up"
alias dcs="docker compose stop"
alias dcr="docker compose rm"
alias dll="docker ps -aq"
alias dcd="docker compose down"
alias dcr="docker compose restart"
alias dcdv="dcd -v"
dockerclean() {
  docker stop $(docker ps -qa)
  docker rm $(docker ps -qa)
  docker rmi -f $(docker images -qa)
  docker volume rm $(docker volume ls -q)
  docker network rm $(docker network ls -q)
  docker system prune -af --volumes
}
alias doremi="docker images -f dangling=true -q | xargs docker rmi -f"

de() {
  if [[ -z "$1" ]]; then
    echo "docker exec: Missing container ID"
    return 1
  fi
  docker exec -it "${1}" ${2:-bash}
}

# Sonar

# zsh-vi-mode
ZVM_SYSTEM_CLIPBOARD_ENABLED=true

# Git

alias gs="git status"
alias grs="git restore --staged"
alias gc='git commit'
alias gco="git checkout"
alias gmd="git merge"
alias glo="git log --oneline"
alias gd="git diff"
alias gds="git diff --staged"
gan() {
  git ls-files --others --exclude-standard -z \
  | xargs -0 --no-run-if-empty git add -N
}

# Fzf

fcd() {
  local dir
  local from_home=false
  # Use argument -h or --home to search from home dir
  if [[ "$1" == "-h" || "$1" == "--home" ]]; then
    from_home=true
    shift
  fi
  if [[ $from_home == true ]]; then
    dir=$(fd --type d --hidden --exclude .git . ~ | fzf)
  else
    dir=$(fd --type d --hidden --exclude .git . | fzf)
  fi
  [ -n "$dir" ] && cd "$dir"
}

fn() {
  local file
  file=$(fd --type f --hidden --exclude .git . | fzf) && nvim "$file"
}

fls() {
  local sel
  sel=$(fd --hidden --exclude .git . | \
    fzf --preview '
      if [ -d {} ]; then
        tree -C -L 2 {} | head -200
      else
        bat --color=always {} 2>/dev/null || head -200 {}
      fi
    ') || return

  if [ -d "$sel" ]; then
    cd "$sel"
  else
    nvim "$sel"
  fi
}

# Apps

killcom() {
  pkill -x zoom
  pkill -x evolution
}
com() {
  zoom > /dev/null 2>&1 &
  evolution > /dev/null 2>&1 &
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
fpath+=${ZDOTDIR:-~}/.zsh_functions

. "$HOME/.local/bin/env"
