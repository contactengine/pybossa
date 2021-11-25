#!/usr/bin/env bash

source $HOME/.profile

rm -rf ~/pybossa
cp -R /vagrant ~/pybossa
cd pybossa || exit
python -mvenv env
source env/bin/activate
pip install -U pip
pip install -r requirements.txt
cp settings_local.py.tmpl settings_local.py
cp alembic.ini.template alembic.ini
