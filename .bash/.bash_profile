#!/bin/bash

# bash_profile

# set 256 color profile where possible
if [[ $COLORTERM == gnome-* && $TERM == xterm ]] && infocmp gnome-256color >/dev/null 2>&1; then
    export TERM=gnome-256color
elif infocmp xterm-256color >/dev/null 2>&1; then
    export TERM=xterm-256color
fi

# Other bash definitions.
# You may want to put all your additions into a separate file like
# ~/.bash/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash/.bash_exports ]; then
    . ~/.bash/.bash_exports
fi

if [ -f ~/.bash/.bash_aliases ]; then
    . ~/.bash/.bash_aliases
fi

if [ -f ~/.bash/.bash_functions ]; then
    . ~/.bash/.bash_functions
fi

if [ -f ~/.bash/.bash_prompt ]; then
    . ~/.bash/.bash_prompt
fi

if [ -f ~/.bash/.bash_profile.local ]; then
    . ~/.bash/.bash_profile.local
fi

# Brew dependent commands
if hash brew 2>/dev/null; then
    # Bash completion on OSX w/ Homebrew
    if [ -f `brew --prefix`/etc/bash_completion ]; then
        . `brew --prefix`/etc/bash_completion
    fi
fi