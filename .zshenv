# Load rust if available
if [ -f "$HOME/.cargo/env" ]
then
    source "$HOME/.cargo/env"
fi

# Load poetry if available
if [ -f "$HOME/.poetry/env" ]
then
    source "$HOME/.poetry/env"
fi

# Load ghc if available
if [ -f "/home/quinn/.ghcup/env" ]
then
    source "/home/quinn/.ghcup/env" # ghcup-env
fi

