eval "$(gh completion -s zsh)"
eval "$(navi widget zsh)"

# https://github.com/rupa/z/ launcher
# A nice script that allows you to quickly jump between your most frequent folders
. ~/z.sh

# THE DEFAULT STUFF (MOST OF IT COMMENTED OUT)
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lastgenius/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# There aren't that many useful zsh scripts. I don't use these that often either,
# but they definitely help sometimes (some of them work all the time and you might
# not even notice them)
plugins=(
git 
colored-man-pages
colorize
command-not-found
cp
extract
safe-paste
)

# You should definitely use oh-my-zsh with zsh
# My file is just the default one here
source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor :)
export EDITOR='nvim'

# Just aliases that greatly improve my workflow.
# The Minecraft one is the most used. 
alias tlauncher="java -jar ~/Downloads/tlauncher/*.jar"
alias wificonnect="nmcli device wifi connect"
alias wifilist="nmcli device wifi list"
alias time="timedatectl set-ntp true"
alias cat="bat"
alias tree="broot"
alias g="git"
alias gt="git"
alias gti="git"
alias gc="git clone"
alias ga="git add"
alias gs="git status"
alias gcm="git commit"
alias gp="git push"
alias cmkae="cmake"
alias yya="yay"
alias valgrind_debug="valgrind --leak-check=full \
         --show-leak-kinds=all \
         --track-origins=yes \
         --verbose \
         --log-file=valgrind-out.txt"
alias shutup="shutdown now"
alias big="du -hsx -- * | sort -rh | head -10"
alias zshconf="nvim ~/.zshrc"
alias vimconf="nvim ~/.config/nvim/init.vim"
alias l="exa --long --header --git"
alias vact="source venv/bin/activate"
alias update="sudo pacman -Syu"
alias vimupdate="nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins"
alias vim="nvim"
alias view="nvim -R"

# CMake stuff
alias cbb="cmake --build build"
alias cmm="cmake -DCMAKE_BUILD_TYPE=Release -S . -B build"

# Docker stuff
alias yay="paru"
alias prune="docker system prune --volumes"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dbuild="docker build ."
alias drun="docker run --rm"
alias dc="docker-compose"

alias py="python"
alias top="ytop -c monokai"
mkcd() {
	mkdir $1 && cd $1
}

# Fuzzy search set up
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

export LC_ALL=en_US.UTF-8

# Probably has something to do with the broot. Have no idea why it's here.
source /home/lastgenius/.config/broot/launcher/bash/br

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
