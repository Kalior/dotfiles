# Path to your oh-my-zsh installation.
export ZSH=/home/kalior/.oh-my-zsh
DISABLE_AUTO_UPDATE=true

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
zstyle ':completion:*:ssh:*' hosts off

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
plugins=(archlinux docker rsync git zsh-autosuggestions poetry)

# User configuration

export PATH="/home/kalior/.bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/share/java/gradle/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl"

export PATH=$PATH:~/go/bin
#PATH=$PATH:~/.cabal/bin
#PATH=$PATH:~/.local/bin
export PATH=$PATH:~/.cargo/bin

export PATH="$PATH:~/anaconda3/bin/"
export PATH="$PATH:~/.yarn/bin/"

export SPICETIFY_INSTALL="/home/kalior/projects/personal/spicetify-cli"
export PATH="$SPICETIFY_INSTALL:$PATH"
export PATH="/home/kalior/.npm/bin/:$PATH"
export PATH="/home/kalior/bin/:$PATH"

#export ANDROID_HOME=/opt/android-sdk

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
    export BROWSER=firefox
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


bindkey "^ " autosuggest-accept

# init ruby stuff
#eval "$(rbenv init -)"
#export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
#export PATH=$GEM_HOME/bin:$PATH

alias irkk="ssh -t cantina irkk"
alias path="echo $PATH | tr ':' '\n'"
#alias synstart="synergyc --name vatten 192.168.30.104"
alias launchsteam="LD_PRELOAD='/usr/$LIB/libstdc++.so.6 /usr/$LIB/libgcc_s.so.1 /usr/$LIB/libxcb.so.1 /usr/$LIB/libgpg-error.so' steam"
#alias home="~/.screenlayout/home.sh"
# Networkmanager aliases
alias netcon="nmcli connection up"
alias netlist="nmcli dev wifi list"

#alias lunch="curl https://chalmers.it/lunch/feed | less"

alias e="exa"
alias ea="exa -bghl"
alias ead="exa -bghl --sort=mod"
alias eag="exa -bghl --git"
alias eat="exa -bhl --git --tree -L 5"

alias gsta="git stash push"

alias nätverk="sudo nmcli dev wifi hotspot ifname wlp59s0 con-name where-the-wifi-at ssid 'Where the wifi at?' password 'nothereanyway'"

alias guvpn="cat ~/.xgujoe-key | sudo openconnect -u xgujoe --passwd-on-stdin fxasa.vpn.gu.se -s 'vpn-slice --verbose --dump hebbe=hebbe2.c3se.chalmers.se=129.16.125.144'" 

alias ssh="TERM=xterm-256color ssh"
alias singularity="TERM=xterm-256color singularity"

alias transfer="rsync --info=progress2 -r"

alias obs="QT_QPA_PLATFORM=xcb obs"

alias profile="sudo perf record -e cycles -e sched:sched_switch --switch-events --sample-cpu -m 8M --aio -z --call-graph dwarf"
#function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}


# fh - repeat history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -r 's/ *[0-9]*\*? *//' | sed -r 's/\\/\\\\/g')
}


#eval "$(rbenv init -)"
eval "$(fasd --init auto)"
# Path additions
#export PATH=$PATH:~/.cabal/bin
export PATH=$PATH:~/.local/bin

eval $(thefuck --alias)
eval "$(_PIPENV_COMPLETE=zsh_source pipenv)"
#eval "$(pipenv --completion)"
# Archey3
PATH="/home/kalior/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/kalior/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/kalior/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/kalior/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/kalior/perl5"; export PERL_MM_OPT;

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/serverless.zsh ]] && . /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/sls.zsh ]] && . /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/slss.zsh ]] && . /home/kalior/projects/personal/hashtag-lunch-reviews/serverless-api/node_modules/tabtab/.completions/slss.zsh

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/kalior/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/kalior/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/kalior/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/kalior/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<
#

export PYTHONSTARTUP=~/.ptyhon_startup
