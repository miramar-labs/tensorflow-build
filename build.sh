#!/usr/bin/env bash

UZERID=`whoami`
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

FILE1=id_rsa
if [ ! -f "$FILE1" ]; then
    echo "NOTE: Copying your SSH private key into build folder for GutHub authentication"
    cp $HOME/.ssh/$FILE1 $DIR
fi

FILE2=id_rsa.pub
if [ ! -f "$FILE2" ]; then
    echo "NOTE: Copying your SSH public key into build folder for GutHub authentication"
    cp $HOME/.ssh/$FILE2 $DIR
fi

if [[ "$#" -ne 1 ]]; then
    echo "must supply makefile target as arg";exit 1
fi

make $1