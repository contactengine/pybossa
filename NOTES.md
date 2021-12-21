# TO TIDY

```
asdf install python 3.8.12
asdf local python 3.8.12
```

```
git submodule sync --recursive
git submodule update --recursive --init
```

## Redis

```
apt-get -y install redis-tools

redis-cli -h HOST -a PASSWORD -p PORT ping
# pong

# list all keys
keys "*"
```

## PostgresSQL

```

apt-get -y install postgresql-client

pg_isready -h FOO

# user: POSTGRES_USER

# password: POSTGRES_PASSWORD

PGPASSWORD=$POSTGRES_PASSWORD psql -U postgres -c -h FOO "<command>"

# shortcuts

\du # users
\l # databases
\c # connect
\dt tables

#

CREATE ROLE <user> LOGIN CREATEDB PASSWORD '<password>' ;
CREATE DATABASE <database> OWNER <user> ;

```

```

# check if package installed

dpkg -l <package>

# is package installed ?

# what version of the package is available to install

apt-cache policy <package>

# show available package version to install

# show if installed

apt search <package>

```

```

vagrant up
vagrant destroy --force
vagrant provision --provision-with <name>
vagrant ssh-config --host pybossa > ~/.ssh/config.d/pybossa

```

```

# scan for package CVE's

# for vulerable package, check dependencies

# any dependencies will need addressing first

pip install johnnydep
johnnydep <package>

# show available, installed and latest versions

pip index versions <package>

# cant just update a package outside of the requirements.txt

pip install --upgrade <package>==<version>

# so ....

# 1. Update the requirements.txt

# 2. Update the packages using the requirements.txt

pip install --upgrade -r requirements.txt

```

```

```
