#!/usr/bin/env python3

from argparse import ArgumentParser
from os import listdir, makedirs, path, rename, symlink

DOTFILE_DIR = path.dirname(__file__)
HOME_DIR = path.expanduser("~")
EXCLUSIONS = {".gitmodules", "setup.py"}


def _path_pair(filename, dest=HOME_DIR, src=None):
    pathname = filename if src is None else path.join(src, filename)

    return path.abspath(pathname), path.join(dest, filename)


def config_paths():
    entries = [entry for entry in listdir(DOTFILE_DIR) if entry not in EXCLUSIONS]
    filenames = [entry for entry in entries if path.isfile(entry)]

    return dict([_path_pair(filename, src=DOTFILE_DIR) for filename in filenames])


def plugin_paths(name, target_dir):
    plugin_dir = path.join(DOTFILE_DIR, name, "plugins")
    plugins = [plugin for plugin in listdir(plugin_dir) if path.isdir(path.join(plugin_dir, plugin))]

    return dict([_path_pair(plugin, target_dir, plugin_dir) for plugin in plugins])


def link_file(src, dest, msg=""):
    msg = None

    if path.exists(dest):
        rename(dest, f"{dest}.old")
        msg = f"{dest} renamed to {dest}.old"

    symlink(src, dest)
    return msg


if __name__ == "__main__":
    vim_dir = path.join(HOME_DIR, ".vim", "pack", "plugins", "start")
    zsh_dir = path.join(HOME_DIR, ".oh-my-zsh", "plugins")

    configs = config_paths()
    vim_plugins = plugin_paths("vim", vim_dir)
    zsh_plugins = plugin_paths("zsh", zsh_dir)

    makedirs(vim_dir, exist_ok=True)
    makedirs(zsh_dir, exist_ok=True)

    config_msgs = [link_file(src, dest) for src, dest in configs.items()]
    vim_msgs = [link_file(src, dest) for src, dest in vim_plugins.items()]
    zsh_msgs = [link_file(src, dest) for src, dest in zsh_plugins.items()]

    for msg in config_msgs + vim_msgs + zsh_msgs:
        if len(msg) > 0:
            print(msg)

