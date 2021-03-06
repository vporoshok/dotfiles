# PATH setup
if [ -d "$HOME/.bin" ] ; then
    PATH="$HOME/.bin:$PATH"
fi
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

export ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh
ZSH_CACHE=$ZSH_CUSTOM/cache
ZSH_THEME="vp"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="dd.mm.yyyy"

k_context="$(kubectl config current-context)"
K_CONTEXT="$k_context"
k_namespace=$(kubectl config view -o jsonpath="{.contexts[?(@.name==\"$K_CONTEXT\")].context.namespace}")
K_NAMESPACE=$(test -z $k_namespace && echo "kube-system" || echo $k_namespace)

plugins=(
    asdf
    aws
    brew
    colorize
    docker docker-compose
    git git-extras git-flow
    golang
    fabric
    history-substring-search
    httpie
    kubectl
    ng
    pass
    pip
    postgres
    symfony
    tmux
)

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

source $ZSH/oh-my-zsh.sh

# User configuration

# Set important shell variables
    export EDITOR=vim                           # Set default editor
    export PAGER=less                           # Set default pager
    export LESS="-R"                            # Set the default options for less
    export LANG="en_US.UTF-8"                   # I'm not sure who looks at this, but I know it's good to set in general
    export LC_CTYPE=UTF-8
    export LC_ALL=en_US.UTF-8
    export COPYFILE_DISABLE=1                   # Prevent mac copy / tar and more actions with ._* files
    export VIRTUAL_ENV_DISABLE_PROMPT=1         # Hide virtualenv from standart prompt position (see theme)

# Misc
    setopt ZLE                                  # Enable the ZLE line editor, which is default behavior, but to be sure
    declare -U path                             # prevent duplicate entries in path
    LESSHISTFILE="/dev/null"                    # Prevent the less hist file from being made, I don't want it
    umask 002                                   # Default permissions for new files, subract from 777 to understand
    setopt NO_BEEP                              # Disable beeps
    setopt AUTO_CD                              # Sends cd commands without the need for 'cd'
    setopt MULTI_OS                             # Can pipe to mulitple outputs
    unsetopt NO_HUP                             # Kill all child processes when we exit, don't leave them running
    setopt INTERACTIVE_COMMENTS                 # Allows comments in interactive shell.
    setopt RC_EXPAND_PARAM                      # Abc{$cool}efg where $cool is an array surrounds all array variables individually
    unsetopt FLOW_CONTROL                       # Ctrl+S and Ctrl+Q usually disable/enable tty input. This disables those inputs
    setopt LONG_LIST_JOBS                       # List jobs in the long format by default. (I don't know what this does but it sounds good)
    setopt vi                                   # Make the shell act like vi if i hit escape

# ZSH History
    alias history='fc -fl 1'
    HISTFILE=$ZSH_CACHE/history                 # Keep our home directory neat by keeping the histfile somewhere else
    SAVEHIST=10000                              # Big history
    HISTSIZE=10000                              # Big history
    setopt EXTENDED_HISTORY                     # Include more information about when the command was executed, etc
    setopt APPEND_HISTORY                       # Allow multiple terminal sessions to all append to one zsh command history
    setopt HIST_FIND_NO_DUPS                    # When searching history don't display results already cycled through twice
    setopt HIST_EXPIRE_DUPS_FIRST               # When duplicates are entered, get rid of the duplicates first when we hit $HISTSIZE
    setopt HIST_IGNORE_SPACE                    # Don't enter commands into history if they start with a space
    setopt HIST_VERIFY                          # makes history substitution commands a bit nicer. I don't fully understand
    setopt SHARE_HISTORY                        # Shares history across multiple zsh sessions, in real time
    setopt HIST_IGNORE_DUPS                     # Do not write events to history that are duplicates of the immediately previous event
    setopt INC_APPEND_HISTORY                   # Add commands to history as they are typed, don't wait until shell exit
    setopt HIST_REDUCE_BLANKS                   # Remove extra blanks from each command line being added to history

# Third-part sources
    eval "$(direnv hook zsh)"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
    . $HOME/.asdf/asdf.sh
    . $HOME/.asdf/completions/asdf.bash
    if [ -f "$(which minikube)" ]; then
        eval "$(minikube completion zsh)"
    fi
    if [ -f "$(which helm)" ]; then
        eval "$(helm completion zsh)"
    fi

# Aliases
    alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"
    alias tx="tmux new -s"
    alias zaplog="jq '\"\", \"=\" * 80, \"\", \"ts: \" + (.ts | todate), \"msg: \" + .msg, \"\", .stacktrace' -r"
    alias pe="env | grep"

# Mac custom
if [[ "$(uname -s)" == "Darwin" ]]; then
    alias curl=curlish
fi

# Linux custom
if [[ "$(uname -s)" == "Linux" ]]; then
    alias pbcopy='xclip -selection clipboard'
    alias pbpaste='xclip -selection clipboard -o'
    function open {
        nautilus $1 &> /dev/null &
    }
fi

# Functions

# Make a directory and cd into it
function mcd {
	mkdir -p $1
	cd $1
}

# Grep env
function genv {
    env | grep -i $@
}

# Extract lines between given lines by patterns or line numbers
function xtr {
    local a
    local b
    if [[ -z $1 ]]; then
        echo xtr: too few argument >&2
        return 1
    elif [[ $1 =~ '^[0-9]+$' ]]; then
        a=$1
    else
        a="/$1/"
    fi
    if [[ -z $2 ]]; then
        b='$'
    elif [[ $2 =~ '^[0-9]+$' ]]; then
        b = $2
    else
        b="/$2/"
    fi

    sed -n "$a,${b}p"
}

# Jump to project
function j {
    local project_dir=$(ghq list --full-path | grep $1 | peco --select-1)
    if [ -n "$project_dir" ]; then
        cd $project_dir
        direnv reload
    fi
}

# Make standup review
function standup {
    standup.py $@ >> ~/standup && vim ~/standup && pbcopy < ~/standup
}

# Port-forward over ssh
function ssh-forward {
    ssh -nNT -L ${2}:localhost:$2 $1
}

# Get code of process by id
function bpcode {
    http $ELASTIC/$COMPANY@system:bp_templates/item/$1 | jq ._source.code -r
}

# Cleanup instances of process by id
function bpclear {
    jarg 'query[match_all]:={}' | http post $ELASTIC/$COMPANY@global:_process_`bpcode $1`/_delete_by_query
}

# Get instances of process by id
function bpget {
    http $ELASTIC/$COMPANY@global:_process_`bpcode $1`/_search | jq .
}

function taskclear {
    jarg 'query[match_all]:={}' | http post $ELASTIC/$COMPANY@system:tasks/_delete_by_query
}

function set_admin_namespace {
    sed -i "/# admin namespace/{n;s/namespace: .*/namespace: $1/}" ~/.kube/config
}

function get_services_versions {
    kubectl --context elma365-dev --namespace $1 get pod -o json | jq '.items[].spec.containers[].image | select(. | startswith("dreg"))'
}

