#!/bin/bash

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,aliases,functions,dockerfunc,extra,exports}; do
    if [[ -r "$file" ]] && [[ -f "$file" ]]; then
        # shellcheck disable=SC1090
        source "$file"
    fi
done
unset file

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Append to the Bash history file, rather than overwriting it
shopt -s histappend

stty -ixon

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

