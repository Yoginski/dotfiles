PROMPT_COLOR="1;31m"
let $UID && PROMPT_COLOR="1;32m"
PS1="\[\033[$PROMPT_COLOR\][\u@\h:\w]\\$\[\033[0m\] "

export EDITOR=vim
export BROWSER=firefox

export GOPATH=$HOME/Projects/Golang

export CARGO_HOME=$HOME/.cargo
export RUST_SRC_PATH=$HOME/.rust-src/rustc-nightly

export PATH=$PATH:$GOPATH/bin:$HOME/.cargo/bin:$PATH:$HOME/.local/bin

