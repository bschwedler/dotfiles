#!/bin/bash
# .bashrc

# If not running interactively, don't do anything
case $- in
    *i*) ;;
    *) return;;
esac

# shellcheck disable=SC1091
source /etc/bashrc

# bash options
shopt -s checkwinsize

# enable color support of ls and also add handy aliases
if which dircolors > /dev/null 2>&1 ; then
    # shellcheck disable=SC2015
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

########################################################################
# Python Setup

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
    # shellcheck disable=SC1091
    source /usr/local/bin/virtualenvwrapper.sh
fi

