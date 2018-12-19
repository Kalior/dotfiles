# Path to your oh-my-zsh installation.
export ZSH=/home/kalior/.oh-my-zsh

# Background is this neccesary? and also should this be done ine .xinitrc?
# sh .fehbg

# Functions to be able to write time in terminal
function preexec() {
  timer=${timer:-$(($(date +%s%N)/1000000))}
}

function precmd() {
  if [ $timer ]; then
    timer_show=$(($(($(date +%s%N)/1000000)) - $timer))
    export TIMEPROMPT="%F{cyan}${timer_show}ms %F{white}%{$reset_color%}"
    unset timer
  fi
}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="kaliorparty"

# Autocomplete .. to ../
zstyle ':completion:*' special-dirs true

#
# zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
plugins=(archlinux rsync git zsh-syntax-highlighting)

# User configuration

export PATH="/home/kalior/.bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/share/java/gradle/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

PATH=$PATH:~/go/bin
PATH=$PATH:~/.cabal/bin
PATH=$PATH:~/.local/bin
PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH"
PATH=$PATH:~/.cargo/bin

export ANDROID_HOME=/opt/android-sdk

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

if [[ -n "$DISPLAY" ]]; then
    export BROWSER=chromium
else
    export BROWSER=w3m
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"



# init ruby stuff
# eval "$(rbenv init -)"
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
export PATH=$GEM_HOME/bin:$PATH

alias irkk="ssh -t cantina irkk"
alias path="echo $PATH | tr ':' '\n'"
alias synstart="synergyc --name vatten 192.168.30.104"
alias launchsteam="LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam"
alias home="~/.screenlayout/home.sh"
# Networkmanager aliases
alias netcon="nmcli connection up"
alias netlist="nmcli dev wifi list"

alias lunch="curl https://chalmers.it/lunch/feed | less"

alias e="exa"
alias ea="exa -bghl"
alias eag="exa -bghl --git"
alias eat="exa -bhl --git --tree -L 5"

alias gsta="git stash push"

alias nätverk="sudo nmcli dev wifi hotspot ifname wlp58s0 con-name where-the-wifi-at ssid 'Where the wifi at?' password 'nothereanyway'"

function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

eval "$(rbenv init -)"
eval "$(fasd --init auto)"

# Path additions
#export PATH=$PATH:~/.cabal/bin
# Archey3
PATH="/home/kalior/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kalior/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kalior/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kalior/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kalior/perl5"; export PERL_MM_OPT;

