export GPGKEY=BB000FFB
export GNUPGHOME=~/.gnupg
export PASSWORD_STORE_DIR=$HOME/.pass

export PATH="/home/linuxbrew/.linuxbrew/bin:$PATH"
export MANPATH="/home/linuxbrew/.linuxbrew/share/man:$MANPATH"
export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:$INFOPATH"

# export ZSH_TMUX_AUTOSTART=true
export ZSH_TMUX_AUTOCONNECT=false
export ZSH_TMUX_ITERM2=true

export PYENV_ROOT=$HOME/.pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1
export PATH=$PYENV_ROOT/bin:$PATH

export NPM_PACKAGES=$HOME/.npm-packages
export PATH=$NPM_PACKAGES/bin:$PATH

export GOPATH=/opt/go:$HOME/go
export PATH=/opt/go/bin:$PATH

export PATH=$HOME/.asdf:$PATH

export TILLER_NAMESPACE=dev-bastrykov
export KUBE_DNS_SUFFIX=dev-bastrykov.svc.cluster.local
export ELMA365_POSTGRESQL_USER=postgres
export ELMA365_POSTGRESQL_PASSWORD=postgres
export ELMA365_RABBITMQ_USER=rabbitmq
export ELMA365_RABBITMQ_PASSWORD=rabbitmq
