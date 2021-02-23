#!/usr/bin/env bash

UZERID=`whoami`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

if [[ "$#" -ne 2 ]]; then
    echo "must supply python version and destination folder as args";exit 1
fi

# check if we have it locally, if not, download, compile and locally install it
FILE=$HOME/opt/Python-$1/bin/python3
if [[ ! -f "$FILE1" ]]; then
	pushd $HOME/Downloads
	FILE2=$HOME/Downloads/Python-$1.tgz
	if [[ ! -f "$FILE2" ]]; then
    	wget https://www.python.org/ftp/python/$1/Python-$1.tgz
    	rm -rf $HOME/Downloads/Python-$1/
    	tar -zxvf Python-$1.tgz
    fi
    pushd Python-$1

    # nuke existing python dir if it exists
	DIR1=$HOME/opt/Python-$1/
	if [[ -d "$DIR1" ]]; then
		rm -rf $DIR1
	fi

	# rebuild
    ./configure -prefix=$HOME/opt/Python-$1
    make
    make install
    popd
    popd
fi

# nuke existing venv dir if it exists
DIR2=$2/venv$1/
if [[ -d "$DIR2" ]]; then
	rm -rf $DIR2
fi

# create venv
virtualenv -p ~/opt/Python-$1/bin/python3 $2/venv$1