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

# Load nodenv if available
if [ -x "$HOME/.nodenv/bin/nodenv" ]; then
    export PATH="$HOME/.nodenv/bin:$PATH"
    eval "$($HOME/.nodenv/bin/nodenv init -)"
fi

