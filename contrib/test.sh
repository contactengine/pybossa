#!/usr/bin/env bash

source $HOME/.profile

sudo su postgres -c "psql -c \"CREATE ROLE rtester SUPERUSER LOGIN PASSWORD 'rtester'\" "
sudo su postgres -c "createdb pybossa_test -O rtester"

cd pybossa || exit
source env/bin/activate
nosetests test/
