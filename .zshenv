# Load rust if available
if [ -f "$HOME/.cargo/env" ]; then
    source "$HOME/.cargo/env"
fi

# Load ghc if available
if [ -f "$HOME/.ghcup/env" ]; then
    source "$HOME/.ghcup/env" # ghcup-env
fi

# Load poetry if available
if [ -f "$HOME/.poetry/env" ]; then
    source "$HOME/.poetry/env"
fi

