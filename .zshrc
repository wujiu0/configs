# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="dracula-pro"
# ZSH_THEME="robbyrussell"
# ZSH_THEME="random"

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

# git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting)
# plugins=(git sudo zsh-autosuggestions zsh-syntax-highlighting zsh-completions zsh-history-substring-search zsh-interactive-cd zsh-autopair zsh-256color)

# for ubuntu zsh
# source /etc/zsh_command_not_found

source $ZSH/oh-my-zsh.sh
# eval "$(starship init zsh)"

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ------------------------------ pnpm alias ------------------------------
alias pd="pnpm dev"
alias pb="pnpm build"
alias pi="pnpm install"
alias pid="pnpm install --save-dev"
alias pig="pnpm install -g"
alias prm="pnpm rm"
d(){
  # 自动检测锁文件选择匹配的包管理器执行 dev
  if [ -f "pnpm-lock.yaml" ]; then
    pnpm dev
  elif [ -f "yarn.lock" ]; then
    yarn dev
  else
    npm run dev
  fi
}
# ------------------------------ pnpm alias end ------------------------------

# ------------------------------ git alias ------------------------------
unalias gk
alias gsta="git status"
alias gst="git stash"
alias gbc="git branch --show-current"

# ------------------------------ git alias end ------------------------------

# ------------------------------ custom command ------------------------------
setNodeVersion() {
  # 不带参数执行nvm ls 带1个参数执行nvm use
  if [ $# -eq 0 ]; then
    nvm ls
    # fnm ls
    return
  fi
  nvm alias default ${1} && nvm use ${1}
  # fnm default ${1} && fnm use ${1}
}

openConfigFile() {
  # 声明 gitconfig file
  # local gitconfig_file="$HOME/.gitconfig"
  # local nginx_config_file="/usr/local/etc/nginx/nginx.conf"
  local gitconfig_file="$XDG_CONFIG_HOME/git/config"
  local nginx_config_file="/opt/homebrew/etc/nginx/nginx.conf"
  local file
  case $1 in
  "" | "zsh") file="$HOME/.zshrc" ;;
  "git") file=$gitconfig_file ;;
  "npm") file="$HOME/.npmrc" ;;
  "ssh") file="$HOME/.ssh/config" ;;
  "hosts") file="/etc/hosts" ;;
  "nginx") file="$nginx_config_file" ;;
  *) echo "ERR: invalid parameter \`$1\`. Please provide one of the following: zsh, git, npm, ssh, hosts, nginx." && return ;;
  esac
  code "$file"
}
proxy() {
  if [ $# -eq 0 ]; then
    export https_proxy=http://127.0.0.1:7890
    export http_proxy=http://127.0.0.1:7890
    export all_proxy=socks5://127.0.0.1:7890
    echo 'proxy on'
    return
  fi
  if [ $1 = "git" ]; then
    git config --global http.proxy http://localhost:7890
    git config --global https.proxy http://localhost:7890
    return
  fi
}
noproxy() {
  if [ $# -eq 0 ]; then
    unset all_proxy
    unset https_proxy
    unset http_proxy
    echo 'proxy off'
    return
  fi
  if [ $1 = "git" ]; then
    git config --global --unset http.proxy
    git config --global --unset https.proxy
    return
  fi
}
testproxy(){
  curl google.com
}
openHistoryFile() {
  code ~/.zsh_history
}
rmNodeModules() {
  rm -rf node_modules
}
study() {
  studyPath=$HOME/code/demo
  open $studyPath
  cd $studyPath
}
alias n="setNodeVersion"
alias config="openConfigFile"

alias cls="clear"

alias updateThrift="thrift-typescript  /Users/user/Desktop/lyProjects/search_beans/src/idl/thrift/agent/*"

alias ws="webstorm"
alias sublime="subl"
alias sl="subl"
# ------------------------------ custom command end ------------------------------


# ------------------------------ PATH ENVIRONMENT ------------------------------
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_WEB_ROOT="/opt/homebrew/var/www"

export PATH="$PATH:$HOME/screeps-server/bin"

# nvm
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm end

# fnm
# eval "$(fnm env --use-on-cd --shell zsh)"
# fnm end

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# ------------------------------ PATH ENVIRONMENT END ------------------------------

# ------------------------------ dev setup ------------------------------
devSetup4Linux() {
  # install zsh and set it as default shell
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  chsh -s $(which zsh)

  # build-essential
  apt install -y build-essential

  # oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # fnm
  brew install fnm

  # rustup
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

devSetup4Mac() {

  # homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # fnm
  brew install fnm

  # Xcode command line tools
  xcode-select --install
}

# ------------------------------ dev setup end ------------------------------


