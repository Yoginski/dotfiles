export EDITOR=vim

export GOPATH=$HOME/Projects/Golang
export PATH=$PATH:$GOPATH/bin

export PATH=$PATH:$HOME/.local/bin

alias cargo-static='docker run --rm -it -v "$(pwd)":/home/rust/src rust-musl cargo'
alias rustc-static='docker run --rm -it -v "$(pwd)":/home/rust/src rust-musl rustc'

alias ssh="TERM=xterm ssh"
