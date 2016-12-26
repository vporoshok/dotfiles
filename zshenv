export EDITOR=vim

export LC_CTYPE=UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

export COPYFILE_DISABLE=1

export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH="$PATH:$PYENV_ROOT/bin"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
source /home/vp/.rvm/scripts/rvm

export GPGKEY=BB000FFB
export GNUPGHOME=~/secrets/gnupg
export PASSWORD_STORE_DIR=~/secrets/passwords

