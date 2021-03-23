#!/bin/sh

BASEDIR=$(dirname "$0")

command_exists () {
    if command -v $1 &>1
    then
        return 0
    else
        return 1
    fi
}

link_file () {
    if [ -z $2 ]
    then
        ln -s $BASEDIR/$1 $HOME/$1
    else
        ln -s $BASEDIR/$1 $HOME/$2
    fi
}

setup_vim () {
    if [ ! "$(ls -A vim/plugins)" ]
    then
        echo "Please checkout git submodules with command [git submodule --init --recursive]"
        exit 1
    fi

    mkdir -p $HOME/.vim/pack/plugins
    link_file .vimrc
    link_file vim/plugins .vim/pack/plugins/start
}

setup_ohmyzsh () {
    if ! command_exists curl
    then
        echo "Curl required for ZSH setup"
        exit 1
    elif ! command_exists git
    then
        echo "Git required for ZSH setup"
        exit 1
    fi

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

setup_zsh () {
    link_file .zprofile
    link_file .zshrc
    link_file .zshenv

    setup_ohmyzsh
}

setup_git () {
    link_file .gitconfig
}

# Base shell configuration
link_file .profile

# Vim configuration
if ! command_exists vim
then
    echo "Vim not found on system, skipping setup"
else
    setup_vim
fi


# Zsh configuration
if ! command_exists zsh
then
    echo "Zsh not found on system, skipping setup"
else
    setup_zsh
fi

# Git configuration
if ! command_exists git
then
    echo "Git not found on system, skipping setup"
else
    setup_git
fi
