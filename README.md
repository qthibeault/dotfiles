# Dotfiles

My collection of dotfiles to quickly setup a new system.

## Usage

Befoe getting started, please ensure that you have installed
[stow](https://www.gnu.org/software/stow/) on your system.

The dotfiles in the repo can be installed by first checking out this repository
by executing the command `git clone https://github.com/qthibeault/dotfiles
.dotfiles` in your home directory. After checkout, run the `install.sh` script
to create symlinks in your home directory. The arguments of the shell script can
be seen by providing the `--help` flag but in summary each component will be
installed unless the corresponding `--no-{component}` flag is provided to the
installer.
