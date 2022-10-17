#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ll="ls -lah"
alias l="ls -lh"
alias n="nvim"
alias c="clear"
alias r="fc -s"
alias rr="fc -e nvim"
alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"
