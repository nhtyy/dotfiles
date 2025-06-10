#!/bin/bash

set -e


if [[ $SHELL == *"zsh"* ]]; then
    echo "found zsh"
    echo "assuming you have a ~/.zshrc file @ $HOME/.zshrc"
    RC_FILE=$HOME/.zshrc
elif [[ $SHELL == *"bash"* ]]; then
    echo "found bash"
    echo "assuming you have a ~/.bashrc file @ $HOME/.bashrc"
    RC_FILE=$HOME/.bashrc
else
    echo "Unknown shell type $SHELL"
    exit 1
fi

echo "adding useful commands to $RC_FILE"

mkdir -p $HOME/.nhtyy-helpers/bin
cp -r shell/helpers/* $HOME/.nhtyy-helpers/bin

echo "Amending PATH to include $HOME/.nhtyy-helpers/bin"
echo "You must run 'source $RC_FILE' to apply the changes"
echo "export PATH=$HOME/.nhtyy-helpers/bin:$PATH" >> $RC_FILE
