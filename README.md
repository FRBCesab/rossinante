rossinante
================


A Toolbox for Rossinante



System requirements
-------------------



```sh
## Install Python 3 environment ----
$ sudo apt install python3 python3-pip python3-venv python3-dev

## Install Make tools ----
$ sudo apt install build-essential
```



Installation
------------



```sh
## Clone repo ----
$ git clone git@github.com:frbcesab/rossinante.git

## Create Python virtual environment ----
$ python3 -m venv rossinante

## Activate Python virtual environment ----
$ source rossinante/bin/activate

## Install Python dependencies ----
$ pip3 install sphinx sphinx-rtd-theme

## Move to root folder ----
$ cd rossinante
```



Usage
-----



Edit/add **reStructuredText** (`.rst`) pages in `source/`, then update HTML content:

```sh
## Generate doc ----
$ make html
```

Finally deactivate Python virtual environment.

```sh
## Exit Python virtual environment ----
$ deactivate
```

Enjoy!
