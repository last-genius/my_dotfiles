eval "$(gh completion -s zsh)"
eval "$(zoxide init zsh)"

#eval "$(starship init zsh)"
#eval "$(navi widget zsh)"
# Zellij on startup
#echo 'eval "$(zellij setup --generate-auto-start zsh)"' >> ~/.zshrc

# THE DEFAULT STUFF (MOST OF IT COMMENTED OUT)
# If you come from bash you might have to change your $PATH.
export PATH=/home/lastgenius/Documents/notes/gb/gbdk2020/bin:/home/lastgenius/.local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/lastgenius/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
DISABLE_UPDATE_PROMPT="true"

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
export RUSTC_WRAPPER=/home/lastgenius/.cargo/bin/sccache
export CARGO_REGISTRIES_CRATES_IO_PROTOCOL=sparse
function frg {
      result=$(rg --ignore-case --color=always --line-number --no-heading "$@" |
        fzf --ansi \
            --color 'hl:-1:underline,hl+:-1:underline:reverse' \
            --delimiter ':' \
            --preview "bat --color=always {1} --theme='Solarized (light)' --highlight-line {2}" \
            --preview-window 'up,60%,border-bottom,+{2}+3/3,~3')
      file=${result%%:*}
      linenumber=$(echo "${result}" | cut -d: -f2)
      if [[ -n "$file" ]]; then
              $EDITOR +"${linenumber}" "$file"
      fi
    }

# Just aliases that greatly improve my workflow.
# The Minecraft one is the most used. 
alias gef="gdb -x ~/.gefinit"
alias cal="cal -m "
alias bandcamp-dl="bandcamp-dl --base-dir=."
#alias spotdl="spotdl --path-template '{artist}/{album}/{title} - {artist}.{ext}'"
alias youtube-dl="youtube-dl --download-archive ~/youtube-dl.txt"
alias cb="cargo build"
alias cbr="cargo build --release"
alias cr="cargo run"
alias crr="cargo run --release"
alias tlauncher="java -jar ~/Downloads/tlauncher/*.jar"
alias wificonnect="nmcli device wifi connect"
alias wifilist="nmcli device wifi list"
alias time="timedatectl set-ntp true"
alias cat="bat"
alias stree="/bin/tree -sh --du"
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
alias valgrind_debug="valgrind --leak-check=full \
         --show-leak-kinds=all \
         --track-origins=yes \
         --verbose \
         --log-file=valgrind-out.txt"
alias shutup="shutdown now"
alias big="du -hsx -- * | sort -rh | head -10"
alias i3conf="nvim ~/.config/i3/config"
alias zshconf="nvim ~/.zshrc"
alias vimconf="nvim ~/.config/nvim/init.vim"
alias gdbconf="nvim ~/.config/gdb/gdbinit"
alias l="eza --all --long --header --git"
alias vact="source venv/bin/activate"
alias vimupdate="nvim +PlugInstall +PlugClean +PlugUpdate +UpdateRemotePlugins"
alias vim="nvim"
alias view="nvim -R"

# CMake stuff
alias cbb="cmake --build build -- -j 6"
alias cmm="cmake -DCMAKE_BUILD_TYPE=Debug -S . -B build"
alias cmr="cmake -DCMAKE_BUILD_TYPE=Release -S . -B build"

# Docker stuff
alias prune="docker system prune --volumes"
alias dcb="docker-compose build"
alias dcu="docker-compose up"
alias dbuild="docker build ."
alias drun="docker run --rm"
alias dc="docker-compose"

alias py="python"
alias top="btm --color gruvbox"
mkcd() {
	mkdir $1 && cd $1
}

# Fuzzy search set up
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# zsh history stuff
export HISTFILE=~/.zsh_history
export HISTSIZE=1000000
export SAVEHIST=1000000
setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

export LC_ALL=en_US.UTF-8

# Probably has something to do with the broot. Have no idea why it's here.
source /home/lastgenius/.config/broot/launcher/bash/br

autoload -Uz compinit
compinit
# Completion for kitty
kitty + complete setup zsh | source /dev/stdin

# Automatically change the current working directory after closing ranger
#
# This is a shell function to automatically change the current working
# directory to the last visited one after ranger quits. Either put it into your
# .zshrc/.bashrc/etc or source this file from your shell configuration.
# To undo the effect of this function, you can type "cd -" to return to the
# original directory.
ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Accel Speed' 0.15
xinput set-prop 'SynPS/2 Synaptics TouchPad' 'libinput Tapping Enabled' 1
xinput set-prop 'SYNA309C:00 06CB:826F Touchpad' 'libinput Accel Speed' 0.15
xinput set-prop 'SYNA309C:00 06CB:826F Touchpad' 'libinput Tapping Enabled' 1

## antigen 
#source ~/antigen.zsh

## Load the oh-my-zsh's library.
#antigen use oh-my-zsh

## Bundles from the default repo (robbyrussell's oh-my-zsh).
#antigen bundle git
#antigen bundle pip
#antigen bundle command-not-found
#antigen bundle colored-man-pages
#antigen bundle colorize
#antigen bundle cp
#antigen bundle extract
#antigen bundle safe-paste

#antigen bundle zsh-users/zsh-syntax-highlighting
#antigen bundle zsh-users/zsh-autosuggestions

## Load the theme.
#antigen theme agnoster

## Tell Antigen that you're done.
#antigen apply
