# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
  #export ZSH=/home/taimur/.oh-my-zsh
  export OF_ROOT="/opt/openFrameworks"
  export PG_OF_PATH="/opt/openFrameworks/"
  export PATH=$HOME/bin:/usr/local/bin:/opt/cuda/bin:/usr/local/stata16:$PATH
  export LD_LIBRARY_PATH=/usr/local/lib

  export GOPATH=$HOME/dev/go
  export PATH=$PATH:$GOPATH/bin
  export VISUAL="vim"
  export FZF_DEFAULT_COMMAND='fd --type f'

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH=/usr/share/oh-my-zsh/
#ZSH=/usr/share/zsh
ZSH_THEME="mh"

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
plugins=(git z zsh-syntax-highlighting)

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
alias ll="ls -alFh --color"
alias code="code-oss"
alias weather="curl wttr.in"
alias tb="nc termbin.com 9999"
alias tlmgr='/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode'
alias vpn_aws='sudo openvpn /etc/openvpn/client/client.conf'
alias kube_airmed='gcloud config set project cerp-airmed && gcloud container clusters get-credentials staging --zone=asia-southeast1-a'
alias kube_platform='gcloud config set project cerp-platform && gcloud container clusters get-credentials platform-backend-cluster --zone=asia-southeast1-c'
alias kube_airmed_prod='gcloud config set project airmed-dev && gcloud container clusters get-credentials production-cluster --zone=asia-southeast1-a'
alias kube_life='gcloud config set project life-212607 && gcloud container clusters get-credentials mischool-web-cluster --zone=asia-southeast1-c'
alias docked="sh ~/.screenlayout/dock-minimal.sh && feh --bg-scale /home/taimur/Downloads/wallpapers/pink-floyd-gruvbox.jpg"
alias docked2="sh ~/.screenlayout/docked.sh && feh --bg-scale /home/taimur/Downloads/wallpapers/pink-floyd-gruvbox.jpg"
alias undocked= "sh ~/.screenlayout/regular.sh" # && feh --bg-scale /home/taimur/Downloads/wallpapers/pink-floyd-gruvbox.jpg"
alias workdock="sh ~/.screenlayout/workdock.sh && feh --bg-scale /home/taimur/Downloads/wallpapers/pink-floyd-gruvbox.jpg && polybar secondscreen & disown" 

alias vim="nvim"
alias night="alacritty-themes Gruvbox-Dark && xbacklight -set 1"

alias config='/usr/bin/git --git-dir=$HOME/.cfg/.git/ --work-tree=$HOME'

function pkslim(){
    export DOCKER_HOST="pk.metal.fish:5732"
    export DOCKER_TLS_VERIFY="1"
    export DOCKER_CERT_PATH="/var/docker/certs2"
}

function reset_docker(){
    unset DOCKER_HOST
    unset DOCKER_TLS_VERIFY
    unset DOCKER_CERT_PATH
}

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/taimur/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/home/taimur/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/taimur/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/taimur/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
