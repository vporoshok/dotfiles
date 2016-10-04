export EDITOR=vim
export LC_CTYPE=UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export COPYFILE_DISABLE=1
export VIRTUAL_ENV_DISABLE_PROMPT=1
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PASSWORD_STORE_DIR=~/secrets/passwords
export GNUPGHOME=~/secrets/gnupg
export GPGKEY=BB000FFB
