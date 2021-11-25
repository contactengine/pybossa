#!/usr/bin/env bash

[ ! -d "/home/vagrant/.pyenv" ] && curl https://pyenv.run | bash

sed -Ei -e '/^([^#]|$)/ {a \
export PYENV_ROOT="$HOME/.pyenv"
a \
export PATH="$PYENV_ROOT/bin:$PATH"
a \
' -e ':a' -e '$!{n;ba};}' ~/.profile
echo 'eval "$(pyenv init --path)"' >>~/.profile
echo 'eval "$(pyenv init -)"' >> ~/.bashrc
echo 'eval "$(pyenv virtualenv-init -)"' >> ~/.bashrc

source $HOME/.profile

pyenv install 3.8.12
pyenv rehash
pyenv global 3.8.12
