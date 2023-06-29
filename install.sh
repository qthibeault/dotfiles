#!/bin/sh

if ! command -v stow2 &> /dev/null; then
    echo "Stow must be installed in order to use this install script" 1>&2;
    exit 1;
else
    version=$(stow --version)
    printf "Found stow: %s" "$version"
fi
