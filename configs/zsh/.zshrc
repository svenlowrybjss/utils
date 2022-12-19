# Set up the prompt

source ~/zshmodules/zsh-autocomplete/zsh-autocomplete.plugin.zsh
skip_global_compinit=1

autoload -Uz promptinit
promptinit
prompt adam1

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
HISTSIZE=1000
SAVEHIST=1000
HISTFILE=~/.zsh_history

# Use modern completion system
# autoload -Uz compinit
# compinit

# zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete _correct _approximate
# zstyle ':completion:*' format 'Completing %d'
# zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select
# eval "$(dircolors -b)"
# zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
# zstyle ':completion:*' list-colors ''
# zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
# zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
# zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
# zstyle ':completion:*' use-compctl false
# zstyle ':completion:*' verbose true

# zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
# zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
eval "$(oh-my-posh init zsh --config /home/svenlowry/projects/personal/utils/configs/oh-my-posh/omp.json)"

# Helper scripts
export PATH="$HOME/projects/specsavers/emea/webapp-tooling/scripts/helper:$PATH"
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Windows apps
export PATH="/mnt/c/Program Files/Microsoft VS Code/bin:$PATH"

# Custom functions
mkcd () {
  mkdir "$1"
  cd "$1"
}

ucd () {
  cdto=".."
  if [ ! -z "$1" ]; then
    for ((i=1; i<$1; i++)); do
      cdto="${cdto}/.."
    done
  fi
  if [ ! -z "$2" ]; then
    cdto="${cdto}/${2}"
  fi
  cd "$cdto"
}

ucdc () {
  ucd "$@" && code .
}

cdc () {
  cd "$1" && code .
}

cloneopen() {
  git clone "$1" && cd "$(basename "$1" .git)" && code .
}

qa-ssh () {
  aws-vault exec specsaversbrand
  borls-ssm -g qa -e "$1" -t "$2" -s webapp
}

# exit () {
#   if [[ $SHLVL -eq 1 ]]; then
#     printf '%s\n' "Don't quit the primary shell!" >&2
#   else
#     command exit
#   fi
# }

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export AWS_VAULT_BACKEND=pass
export AWS_VAULT_PASS_PREFIX=aws-vault
export GPG_TTY=$(tty)

# alias ls="logo-ls"
# alias ls="exa --icons"
alias cat="batcat"
alias cata="batcat -A"
alias aws-auth="aws-vault exec specsaversbrand"
