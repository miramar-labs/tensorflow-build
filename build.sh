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

if [[ "$#" -ne 3 ]]; then
    echo "you must supply the CUDA version, cuDNN version and TF release tag as args";exit 1
fi

make CUDAVER=$1 CUDNNVER=$2 TFVER=$3