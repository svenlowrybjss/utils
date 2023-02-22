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
export PATH="/mnt/c/Program Files/Microsoft VS Code/bin:$PATH"
fpath=(/home/sven/projects/specsavers/emea/dev-docker/bin/autocomplete $fpath)

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
  MAIN_BRANCH=$(git remote show origin | sed -n '/HEAD branch/s/.*: //p')
  git checkout "$MAIN_BRANCH"
  git pull
  git checkout -
  git merge "$MAIN_BRANCH"
}

docker_nuke() {
  docker system prune -a --volumes
}

# Aliases
alias cat="batcat"
alias cata="batcat -A"
alias awsauth="aws-vault exec specsaversbrand --backend=file"

eval $(thefuck --alias)
