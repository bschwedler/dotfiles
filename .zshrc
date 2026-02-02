#!/usr/bin/zsh
# .zshrc

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="brjs"
#export PROMPT_EOL_MARK=''

plugins=(
    aws
    fd
    gcloud
    gh
    git
    helm
    kubectx
    z
)

source $ZSH/oh-my-zsh.sh

bindkey "^U" backward-kill-line

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,aliases,functions,dockerfunc,extra,exports}; do
    if [[ -r "$file" ]] && [[ -f "$file" ]]; then
        # shellcheck disable=SC1090
        source "$file"
    fi
done
unset file

# add Pulumi to the PATH
export PATH=$PATH:$HOME/.pulumi/bin
