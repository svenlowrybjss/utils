zstyle ':znap:*' repos-dir ~/zsh
source ~/zsh-snap/znap.zsh
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
unsetopt beep
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/sven/.zshrc'

# autoload -Uz compinit
# compinit
# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

# `znap prompt` makes your prompt visible in just 15-40ms!
# znap prompt sindresorhus/pure

# `znap source` automatically downloads and starts your plugins.
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting

# `znap eval` caches and runs any kind of command output for you.
znap eval iterm2 'curl -fsSL https://iterm2.com/shell_integration/zsh'

# `znap function` lets you lazy-load features you don't always need.
znap function _pyenv pyenv 'eval "$( pyenv init - --no-rehash )"'
compctl -K    _pyenv pyenv
# End of lines added by compinstall
eval "$(oh-my-posh init zsh --config /home/sven/projects/personal/utils/configs/oh-my-posh/omp.json)"

# PATH additions
export PATH="$HOME/projects/specsavers/emea/webapp-tooling/scripts/helper:$PATH"
export PATH="/mnt/c/Users/sven.lowry/AppData/Local/Programs/Microsoft VS Code/bin:$PATH"
fpath=(/home/sven/projects/specsavers/emea/dev-docker/bin/autocomplete $fpath)
fpath=(/home/sven/projects/specsavers/ca/php-canada_drupal9_ecomm/bin/autocomplete $fpath)
JAVA_HOME='/opt/jdk-20.0.1'
export PATH="$JAVA_HOME/bin:$PATH"
M2_HOME='/opt/apache-maven-3.9.2'
export PATH="$M2_HOME/bin:$PATH"

# Environment Variables
export AWS_VAULT_BACKEND=pass
export OPENAI_KEY=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

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

mainmerge() {
  BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  gitmain
  git checkout "$BRANCH_NAME"
  git merge "$MAIN_BRANCH"
}

gitmain() {
  MAIN_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
  git checkout "$MAIN_BRANCH"
  git pull
}

load_pageant() {
  weaselpath="/mnt/c/Program Files/KeePass Password Safe 2/weasel-pageant"
  echo -n "Pageant loading, wait..."
  "$weaselpath/weasel-pageant" -k> /dev/null 2> /dev/null
  eval $("$weaselpath/weasel-pageant" -r -a "/tmp/.weasel-pageant-$USER")> /dev/null 2> /dev/null
  sleep 1
  sshkeysloaded=$(ssh-add -l | grep -c SHA)
  if [[ $sshkeysloaded -gt 0 ]];  then
      echo -e "Loaded $sshkeysloaded keys."
  else
      echo -e "Failed to load any keys."
  fi
}

# Aliases
alias cat="batcat"
alias cata="batcat -A"
alias drop_cache="sudo sh -c \"echo 3 >'/proc/sys/vm/drop_caches' && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'\""
alias docker_nuke="docker system prune -a --volumes -f"
eval "$(thefuck --alias)"
eval "$(atuin init zsh)"

export NVM_DIR="$HOME/.config/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Run tasks
docker-compose -f /home/sven/projects/misc/ittools/docker-compose.yml pull &>/dev/null
docker-compose -f /home/sven/projects/misc/ittools/docker-compose.yml up -d &>/dev/null
clear
