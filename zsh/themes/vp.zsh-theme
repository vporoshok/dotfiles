setopt prompt_subst

local return_code="%(?..%{$fg[red]%}%? ↵%{$reset_color%})"

if [[ $UID -eq 0 ]]; then
    local user_host='%{$terminfo[bold]$fg[red]%}%n@%m%{$reset_color%}'
else
    local user_host='%{$terminfo[bold]$fg[green]%}%n@%m%{$reset_color%}'
fi

local current_dir='%{$terminfo[bold]$fg[blue]%} %~%{$reset_color%}'
local git_branch='$(git_prompt_info)%{$reset_color%}'

function __docker_machine {
    [ $DOCKER_MACHINE_NAME ] && echo "%{$fg[cyan]%}$DOCKER_MACHINE_NAME%{$reset_color%}  "
}
local docker_machine='$(__docker_machine)'

function __current_venv {
    [ $VIRTUAL_ENV ] && echo "(`basename $VIRTUAL_ENV`)  "
}
local current_venv='$(__current_venv)'

function __telepresence {
    [ $TELEPRESENCE_CONTAINER ] && echo "%{$fg[cyan]%}$TELEPRESENCE_CONTAINER_NAMESPACE/$TELEPRESENCE_CONTAINER%{$reset_color%}  "
}
local telepresence='$(__telepresence)'

PROMPT="╭─${user_host} ${current_dir} ${git_branch} ${docker_machine}${current_venv}${telepresence}
╰─%B$%b "
RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[yellow]%}‹"
ZSH_THEME_GIT_PROMPT_SUFFIX="› %{$reset_color%}"
