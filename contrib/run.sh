#!/usr/bin/env bash

source $HOME/.profile

cd pybossa || exit
source env/bin/activate
redis-server contrib/sentinel.conf --sentinel
python run.py
