#!/usr/bin/env bash

source $HOME/.profile

cd pybossa || exit
source env/bin/activate
python cli.py db_create
