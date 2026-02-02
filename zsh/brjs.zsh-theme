# brjs.zsh-theme

VIRTUAL_ENV_DISABLE_PROMPT=true

# primary prompt: dashed separator, directory and vcs info

function aws_prompt_info {
    [[ -n ${AWS_PROFILE} ]] || return

    echo "${ZSH_THEME_AWS_PREFIX}${AWS_PROFILE}${ZSH_THEME_AWS_SUFFIX}"
}

function k8s_prompt_info {
    K8S_CONTEXT=$(kubectx_prompt_info)
    [[ -n ${K8S_CONTEXT} ]] || return

    echo "${ZSH_THEME_K8S_PREFIX}${K8S_CONTEXT}${ZSH_THEME_K8S_SUFFIX}"
}

function virtualenv_prompt_info {
    [[ -n ${VIRTUAL_ENV} ]] || return

    echo "${ZSH_THEME_VIRTUALENV_PREFIX}${VIRTUAL_ENV:t}${ZSH_THEME_VIRTUALENV_SUFFIX}"
}

function prompt_char {
    command git branch &>/dev/null && echo "±" || echo '$'
}

local aws_info='$(aws_prompt_info)'
local git_info='$(git_prompt_info)'
local k8s_info='$(k8s_prompt_info)'
local virtualenv_info='$(virtualenv_prompt_info)'
local prompt_char='$(prompt_char)'

#  left prompt: user@host, current directory, k8s context, virtualenv, and git info
PS1="
🐧${virtualenv_info}${aws_info}${k8s_info}${git_info}
${FG[032]}%~%b
${prompt_char}%{$reset_color%} "
#PS2="%{$fg[red]%}\ %{$reset_color%}"

# right prompt: return code
RPS1="%(?..%{$fg[red]%}%? ↵%{$reset_color%} )"

# aws settings
ZSH_THEME_AWS_PREFIX="${FG[237]}aws:%{$reset_color%}(${fg[yellow]}"
ZSH_THEME_AWS_SUFFIX="%{$reset_color%}) "

# git settings
ZSH_THEME_GIT_PROMPT_PREFIX="${FG[237]}git:%{$reset_color%}(${FG[078]}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="${fg_bold[red]}*"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})%{$reset_color%}"

# k8s settings
ZSH_THEME_K8S_PREFIX="${FG[237]}k8s:%{$reset_color%}(${fg[blue]}"
ZSH_THEME_K8S_SUFFIX="%{$reset_color%}) "

# virtualenv settings
ZSH_THEME_VIRTUALENV_PREFIX="${FG[237]}venv:%{$reset_color%}(%{${fg[cyan]}%}"
ZSH_THEME_VIRTUALENV_SUFFIX="%{$reset_color%}) "
