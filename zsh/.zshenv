export GOPATH="$HOME/go"
export EDITOR="nvim"
export CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

export PATH="$PATH:$GOPATH/bin" # Go
export PATH="$PATH:`python3 -m site --user-base`/bin" # Python
export PATH="$PATH:$HOME/.cargo/bin" # Rust
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH" # Java
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH" # Krew
