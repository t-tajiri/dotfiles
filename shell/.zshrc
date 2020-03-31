#
# Executes commands at the start of an interactive session.
#
# Authors:
#   Sorin Ionescu <sorin.ionescu@gmail.com>
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

set -o vi
set tags=tags

alias prj='cd /Users/$USER/project/'
alias vi='nvim'

# Wasmer
export WASMER_DIR="$HOME/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"  # This loads wasmer

# neomutt
export XML_CATALOG_FILES="/usr/local/etc/xml/catalog"

alias neomutt='LC_CTYPE=ja_JP.UTF-8 neomutt'
alias mutt='LC_CTYPE=ja_JP.UTF-8 neomutt'


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export JAVA_HOME=/usr/lib/jvm/jdk-13.0.2
export PATH=$PATH:/usr/lib/jvm/jdk-13.0.2/bin

# rust
export PATH=$PATH:$HOME/.cargo/bin
export WASMTIME_HOME="$HOME/.wasmtime"
export PATH="$WASMTIME_HOME/bin:$PATH"
export PKG_CONFIG_PATH=/usr/lib/x86_64-linux-gnu/pkgconfig/
